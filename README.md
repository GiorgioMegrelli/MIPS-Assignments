# MIPS-Assignments

## Assignment 1
[Problem description Url](https://www.informatics.ge/problem/433)

## Assignment 2
[Problem description Url](https://informatics.ge/problem/179)

## Assignment 3
[Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes) of First 10000th number

## Assignment 4
[Longest increasing subsequence](https://www.geeksforgeeks.org/longest-increasing-subsequence-dp-3/)

<p>Example source code:</p>

```cpp
int i, n, j, x, a[10001], b[10001];

main() {
    cin >> n;
    for (i = 0; i < n; i++) {
        scanf("%d", &a[i]);
    }

    b[0] = 1;
    for (i = 1; i < n; i++) {
        b[i] = 1;

        for (j = i - 1; j >= 0; j--) {
            if (a[i] > a[j]) {
                b[i] = max(b[i], b[j] + 1);
            }
        }

        x = max(x, b[i]);
    }

    cout << x << endl;
}
```
