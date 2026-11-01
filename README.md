# Dear Data 100 - my Valorant trades

A Processing sketch that shows how my gunfights and trades go, round by round, across my Valorant matches.

Open `DearData100.pde` in Processing and press Run.

## How I record the data

Each row in `data/trades.csv` is **one round**. I fill it in after each match from the round-by-round timeline in the match details screen.

| column | meaning |
|---|---|
| `date` | date played, `YYYY-MM-DD` |
| `match` | match number, counting up from 1 |
| `map` | e.g. `Ascent` |
| `agent` | agent I played |
| `round` | round number in that match |
| `side` | `atk` or `def` |
| `round_won` | `1` if my team won the round, `0` if not |
| `kills` | my kills that round |
| `died` | `1` if I died that round, `0` if I survived |
| `trades_won` | how many times I killed an enemy within ~3 seconds of them killing a teammate |
| `got_traded` | `1` if I died and a teammate killed my killer within ~3 seconds, else `0` |

Example row:

```
2026-11-01,1,Ascent,Jett,1,atk,1,2,0,1,0
```
