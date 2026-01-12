#include <bits/stdc++.h>
using namespace std;

typedef long long ll;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, k;
    cin >> n >> k;

    vector<int> a(n + 1);
    map<int, int> pos;  // pos[x] = x在数组中的位置

    for (int i = 1; i <= n; i++) {
        cin >> a[i];
        pos[a[i]] = i;
    }

    ll ans = LLONG_MIN;

    // 枚举所有可能的最大值M
    // M = a[i] - j，其中 1 <= j <= n
    set<int> M_values;
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            M_values.insert(a[i] - j);
        }
    }

    for (int M : M_values) {
        // 找出所有能达到M的数
        // 数x能达到M当且仅当：x在数组中，且目标位置 x-M 在 [1,n] 范围内
        vector<int> S;  // 能达到M的数
        for (int x = M + 1; x <= M + n; x++) {
            if (pos.count(x)) {
                S.push_back(x);
            }
        }

        if (S.empty()) continue;

        // 计算位置索引之和
        ll sum_idx = 0;
        for (int x : S) {
            sum_idx += (x - M);  // 目标位置
        }

        // 计算最小交换次数
        // 对于每个x in S，它需要从 pos[x] 移动到 x-M
        // 交换次数 = 需要移动的数的个数 - 环的个数

        vector<bool> visited(n + 1, false);
        int num_cycles = 0;
        int need_move = 0;  // 需要移动的数的个数

        for (int x : S) {
            int cur_pos = pos[x];
            int tar_pos = x - M;

            if (cur_pos == tar_pos) continue;  // 已经在目标位置
            if (visited[cur_pos]) continue;

            // 从cur_pos开始追踪环
            int p = cur_pos;
            int cnt = 0;

            while (!visited[p]) {
                visited[p] = true;
                cnt++;

                // p位置的数是a[p]，它的目标位置是 a[p] - M
                int num_at_p = a[p];
                int target = num_at_p - M;

                // 检查这个数是否在S中且需要移动
                if (target >= 1 && target <= n && pos.count(num_at_p) && pos[num_at_p] != target) {
                    p = target;
                } else {
                    break;  // 链的终点
                }
            }

            need_move += cnt;

            // 如果回到起点，是一个环
            if (p == cur_pos) {
                num_cycles++;
            }
        }

        // 重新计算需要移动的数
        need_move = 0;
        for (int x : S) {
            if (pos[x] != x - M) {
                need_move++;
            }
        }

        // 重新计算环的数量
        fill(visited.begin(), visited.end(), false);
        num_cycles = 0;

        for (int x : S) {
            int start = pos[x];
            if (pos[x] == x - M) continue;  // 不需要移动
            if (visited[start]) continue;

            int p = start;
            while (!visited[p]) {
                visited[p] = true;
                int num_at_p = a[p];
                int target = num_at_p - M;

                if (target >= 1 && target <= n && pos.count(num_at_p)) {
                    if (pos[num_at_p] != target) {
                        p = target;
                    } else {
                        break;
                    }
                } else {
                    break;
                }
            }

            if (p == start) {
                num_cycles++;
            }
        }

        ll swaps = need_move - num_cycles;
        ll score = sum_idx - swaps * k;
        ans = max(ans, score);
    }

    cout << ans << endl;

    return 0;
}
