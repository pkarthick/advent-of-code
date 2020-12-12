import strutils
import sequtils
import sugar

let input="""LLLLL.LLLL.LLLLLLLLL.LLLLLL.LLLLLLL.LLLLLL.LLLLLLLLLL.LLLLLLLL.LLLLLL.LLLLLLLLLLL.LLLLLLLLLLLLLLLL
LLLLLLLLLL.LLL.LLLLL.LLLLLL.LLLLLLL.LLLLL.LLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLL..LLLLL.LLLLLLLLLLLLLLLL
LL.LLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLL.LLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLL.LLLLLLLLL.LLLLLL
LLLLLLLLLLLLLLLLLLLLLLLLLLL.LLL.LLLLLLLLLLL.LLLLLLLL..LLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
LLLLL.LLLLLLLLLLLLLL.LLL.LL.LLLL.LLL.LLLLLL.LLLLL.LLLLLLLLLLLL.LLLL.LLLLLLLLLLLLL.LLLLLLLLL.LLLLLL
LLLLL.LLLL..LLLLLLLL.LLLLLLLLLLL.LLLLLLL.LLLLLLLLLLLL.LLLLL.LL.LLLL.LLLLLL.LLLLLL.LLLLLLLLL.LLLLLL
.......L...L.L...L......L..LLL..L.............L..L....L.LL.......LL......L..LL..L..L.L.LL..L.L....
LLLLL..LLL.LLLLLLLLL.LLLLLL.LLLLLLL.LLLLLLL..LLLLLLLL.LLLLLLLL.LLLL.LLLLLL.LLLLLL.LLLLLLLLLLLL.LLL
LLLLLLLLLL.LLLLLLLLL.LLLLLL..LLLLLL.LLLLLLL.LLL..LL.LLLLLLLLLL.LLLL.LLLLLLLLLLLLL.LL.LLLLLL.LLLLLL
L.LLL.LLLLLLLLLLLLLLLLLLLLL.LLLLLL..LLLLLLL.LLLLLLLL..LLLLLLLL.LLLL.LLL.LL.LLLLLL.L.LLLLL.L.LLLLLL
LLLLL.LLLL.LLLLLLLLL.LLLLLLLLLLLLLL.LLL.LLLLLLLLLLLLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLLLLLL.LLLLLL
LLLLLLLLLL.LLLLLLLLLLLLLLLL.LLL.LLLLLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLL.LLLLLL
LLLLL.LLLL.LLLLLLLLL.LLLLLL.LLLLLLL.LLLLL.L.LLLLLLL.L.LLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLL.LLLLLL
.....LL..L....LL.L....L....L.....L.L...L......LLL..L.L....L..LLL...L.L..L.L..LL...L..L.L.....L.L.L
LLLLL.LLL..LLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLL.LLL.LLLLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLLLLLL.LLLLLL
LLLLL.LLLL.LLLL.LL.L.LLLLLL.LLLLLLL.LLLLLLL.LLLLLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLLLL.LLLLLLLLL.LLLLLL
LLLLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLL.LLLLL.LLLLLLL.LLLLLL.LLL.LL.LLLLLLLLLLLLLLLL
LLLLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLL.LL.LLLL.LLLLLL.LL.LLLLLLLL.LLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLLLLL
.LLLL.LLLL.LLLLLLLLL.L.LLL..LLLLLLL.LLLLLLLLLLLLL.LLL.LLLLLLLLLLLLL.LLLL.LLL.LLLL.LLLLLLLLL.LLLLLL
LLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLL...LLLLLL.LL.LLLLLL.LLL.LLLL.LLLLLLLLLLL.LLLLLL.LLLLLLLLL.LLLLLL
.......L.L...L..L..L.LL.LL.L....L.L..LL..L.L.L.LL...LLL...LLLL..LLLL.......L...L....LL.....L.LL...
LLLLL.LLLL.LLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLL.LLLLLLLLL.LLLLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLL
LLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLL.LLLLL.LLLLLL.LLLLLLLLLLLLLLLL
LLLLLLLLLL.LLLLLLLLL.LL.LLL.LLLLL.L.LLLLLLLLLLLLLLLLL.LLLLLLLL.LLLL.LLLLLLLLL.LLL.LLLLLLLLL.LLLLLL
LLLLL.LLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLL.LLL.LLLLLLLLL.LLLLLLLL.LL.LLLLLLLL.LLLLLLLLLLLLLLLL.LLLLLL
LLLLL..LLL.LLLLLLLLLLLLLLLL.LLLLLLL.LLLLLLL.LLLLLL.LL.LLLLLLLLLLLLL.LLLLLL.LLLLLL.LLLLLLLLL.LLLLLL
L...LL.LL.L....LL..L.L..L..L.L.LL.L.....L..LL.......L..LLL..L...LL......LL..LL..L.L.LL..LL.L......
LLLLL.LLLL.LLLLLLLLLLLLLLLL.LLL.LLL.LLLLLLL.LLLLLLLLL.LLLLLLLL.LLLLLLLLLLL.LLLLLLLLLLLLLLLL.LLLLLL
LLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLL..LLLLL.LLLLLLLLL.LLLLLL
LLLLL.LLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLLLL.LLLLLLLLL.LLLLLL
LLLLL.LLLLLLLLLLLLLL.LLLL.L.LLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLL.LLLLLLLL..LLLLLL
.LLLL..L...L..LL...L...L.L.L..LLL.L....L..L..L.....L.L..............LL.L....L..L......LL..LL..L...
LLLLL.LLLL.LLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLL.LL.LLLLLLLLLLLLLLL.LLLLLLLLLLL.LLLLLL.LLLLLLLLL.LLLLLL
LLLLL.LLLLLLLLLLL.LL..LLLLLLLLLLLLL.LLLLLLLLLLLLLLLLL.LLLLLLLL.LLL.LLLLLLL.LLLLLLLLLLLLLLLLLLLLLLL
LLLLL.LLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLL.LLLLLL
LLLLL.LLLLLLLL.LLLLLLLLLLLL.LLLLLLL.LLLLLLLLLLLLLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLL.LLLLLL
LLLLLLLLLL.LLLLLLLLLLLLLLLL.LLLLLLL.LLLLLLL.LLLLL.LLL.LLLLLLLL.LLLL.L.LLLLLLLLLLL.LLLLLLLLLLLLLLLL
LLLLL.L.LLLLLLLLLLLLLLL.LLL.LLLLLLL.LLLLLLLLLLLLLLLLL.LLLLLLLL.LLLL.LLLLLLLLLLLLL.LLLLLLLLLL.LLLLL
LLLLL.LLLL.LL.LLLLLL.LLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLL..LLLLLLLLL.L.LLLLLLLLLLLLLLL.LLLLLLL
L.LLL.LL.L.L...L.L....L.....L.....LL..........LL...L..L.L....L..L.L....L.L.LL.L.......LL.....L.L..
LLLLL.LLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLL.L.LLLLLLL.LLLLLLLL.LLLL.LLLLLL..LLLLL.LLLLLLLLL.LLLLLL
LLLLL.LLLL.LLLLLLLLLLLLLLLLLLL.LLLL.LLLLL.L.LLLLLLLLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLLL.LL.LLLLLL
LLLL..LLLL.LLLLLLLLL.LLLLLL.LLL.LLL.LLLLLL..LLLLLLLLL.LLLLLLLL.LLLL.LLLLLLLLLLLLL.LLLLLLLLL.LLLLLL
LLLLLLLLLLLLLLLLL.LL.LLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLLL.LL.LLLLLLLLLLLLLLL.LLLLLLL.LLLLLLLL
LLLLL.LLLL.LLLLLLLLL.LLLLLL.L.LLLLL.LLLLLLL.LLLLLLLLL.LLLLLLLL.LLLL.LLLLLLL.LLLLL.LLLLLLLLL.LLLLLL
...L.......LL....L......L...L..L.L..L...L.L.....LLLL.L...L.....L...L.....LL...........L..L...L...L
LLLLLLLLLLLL.LLLLLLL.LLLLLL.LLL.LLL.LLLLLLL.LLLLLLLLL.LLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLL.LLL
LLLLL.LLLL.LLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLL.LLLLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL
LLLLL.LLLLLLLLLLLLLL.LLLLLL.L.LLLLL.LLLLLLLLLLLLLL.LL.LLLLLLLL.LLLL.LLLLLL.LLLLLL.LLLLLLL.LLLLLLLL
LLLLL.LLLL.LLL.LLLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLL.LLLLLLL.LLLLLLLLLLLLLLLL
LLLL...LLL.LLLLLLLLL.LLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLL
LLLLL.LLLL.LLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLL.LLLLLLLLL.LLLLLL.LLLL.L.LLLLLL.LLLLLLLLLLLLLLLL.LLLLLL
.LLLL.LLLL.LLLLLLLLL.LLLLLL.LLLLL.L.LLLLLLLLLLLLLLLLL..LLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLLLL.L.LLLLLL
........L.L..LL.....L..L.L...L..LL.LL..L.L..L...........L.L...LLLL.L..L..........L..L....L..LL...L
LLLLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLLL.LLLLLLLLLLLL.LLLLL.LLLLLLLLL.LLLLLL
LLLLL.LLLLLLLLLLLLLL.LLLLLL.LLLLL.L.LLLLLLLLLLLLLLLLL.LLLLLLLL.LLLL.LL.LLL.LLLLLL.LLLLLLLLL.LLLLLL
LLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLL.LLLLLLL.LLLLLLLLLLLLLLLLLL.LLLL.LLLLLL.LLLLLL.LLLLLLLLL.LLL.LL
LLLLL.LLLLLLLLLLLLLL.LLLLLL.LLLLLLL.LL.LLLL.LLLL...LLLLLLLLLLL.LLLLLLLLLLL.LLLLLLLLLLLLLLLL.LLLL.L
LLLLL.LLLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLL.LLLL.LLLLLL.LLLLLL.LLLLLLLLL.LLLLLL
LLLLLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLL.LLLLLLLLLL.LL.LL.LLLLLLLLLL.LLLLLLLLLLLLLLLL
.L.....LL......LLLLLL....L..LL...L.L..LLL.L..............L..LLL.L..L.L........LLLL....L..L..L.....
LLLLL.LLLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLL.LLLL.LL.LLL.LLLLLL.LLLLLLLLLLLLLLLL
LLLLL.LLLLLLLLLLLLLL.LLL.LL.LLLLLLL.LLLLLLL..LLLLLLLLLLLL.LLLL.LLLLLLLLLLL.LLLLLL.LLLLLLLLL.LLLLLL
LLLLL.LLLL.LLLLL.LLL.LLLLLLLLLLLLLL.LLLLLLL.LLLLLLLLLLLLLLLLLL.LLLL.LLLLLL.LLLLLL.LLLLLLLLL.LLLLLL
LLLLL.LLLL.LLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLL.LLLL.L.LLLL.LLLLLL.LLLLLLLLL.LLLL.L
LLLLL.LLLLLLLLLLLLLLLLLLLLL.LLLLLLL..LLLLLL.L.LLLLLLLLLLLLLLLL.LLLL.LL.LLLLLLLLLL.LLLLLLLLL.LLLLLL
LLLLL.LLLL.LLLLLLLLL.LLLLLL.L.LLLLLLLLLLLL..LLLLLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLLLL.LLLLLLLLL.LLLLLL
...L.LLLL....LL....LL.L...LLLL.LL......L....L.L.L.L........LLLL.LL....L.L..L.L....LL..L....L......
LLLLL.LLLL.LLLLLLLL..LLLLLL.LLLLLLL.LLLLLLLL.LLLLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLLLL.LLLLLLLLL.LLLLLL
LLLLLLLLLL.LLL.LLLLL.LLL.LLL.LLLLLL.LLLLLLL.LLLLLLLLL.LLLLLLLL.LLLL.LLLLLL.LLLLLL.LLLLLLLLLLLLLLLL
LLLLL.LLLL.LLLLLLLLL.LLLLLL.LLLLLLL.LLLLLLLLLLLL.LLLLLLLLLLLL..LLLL.LL.LLLLLLLLLL.LLLLLLLLL.LLLLLL
LLLLL.LLLLLLLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLLLLLL.LLLLL.LLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLLL.LLLLLL
....LLL...LL.........L.....LL...L.L...LL......L...LL..L.L.....L..L....L.L.....L.L...L..LL...L.L...
LLLLLLLL.L.LLLLLLLLL.LLLLLL.LLLLLLL.LLLLLLL.LLL.LLLLL.LLLLLLLL.LLLL.LLLLLLLLLLLLL.LLLLLL.LL..LLLLL
LLLLL.LLLLLLLLLLLLLL.LLLLLL.LLLLLLL.LLLLLLL.LLLLLLLLLLLLLLLLLL.LLLL.LL.LLL.LLLLL.LLLLLLLLLLLLLLLLL
LLLLL.LLLL.LLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLL.LLLLLLLLL.LLLLLLLL.LLLL.LLLLLLLLLL.LL.LLLLLLLLL.LLLLLL
LLLL..LLLL.L.LLLLL.L.L.LLLLLLLLLLLL.LLLLLLL.LLLLLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLL.LLLLLLLLL.LLLLLL
LLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLL.LLLLLL.L.LLLLLLLL.L.LLLLLLLLLLL.LLLLLL.LLLLLL.LLLLLLLLLLLLLL.L
LLLLLLLLL.LLLLLLLLLL.LLLLLL.LLLLLLL.LLLLLLL.L.LLLLLLL.LLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLL..LLLLL
...LL...LL.L.....L.L.LL......L..L.L...L.L..L..L..........L...L.....L...L......L..LLL...L.L..LLL...
LLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLL.LLLLLLL.LLLLLLLLL.LLLLLLLL.LLLL.LLLLLL.LLLLLL.LLLLLLLLL.LLLLLL
LLLLL..LLL.LLLLLLLLL.LLLLLL.LLLLLLL.LLLLLLL.LLLLLLLL..LLLLLLLLLLLLL.LLLLLLLLLLLLL.LLLLLLLLL..LLLLL
LLLLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLLLLLL.L.LLLLLLLLL.LLLLLLLLLLLLL.LLLLLLLLL.LLL.LLLLLLLLL.LLLLLL
LLLLL.LLLL.LLLLLLL..LLLLLLL.LLLLLLLLLL.LLLL.LLLLLLLLL.LLLLLLLL.LLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLL
LLLLLLLLLLLLLLLLLLLL.LLLLL..LLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLL.LLLL.LL.LLLLLLLLLL.LLLLLLLLL.LLLLLL
....L....L.....LLLLL...L.L...LL...L.LL.........L.L.L..L..LL.....L..LLL..L.L......LL.L.LLLL..L..LLL
LLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLL.LLLLLLLLLLLLLLL.LLLLLL.LLLLLLLL.L.L.LLLLLLLLL.LLLLLLLLL.LLLLLL
LLLLL.LLLL.LLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLL.LLLLLLLLLL.LLLLLLLLL.LL.LLLLLLLLLLLLL.LLLLLLLL..LLLLLL
LLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLL.LLLLLLL.LLLLLLLLLLLLLLLLLL.LLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLLLLL
LLLLL.LL.LLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLL.LLLLL.LLLLL.LLLLLL..LLLLLLLLLLLLLLLL..LLLLLL
LLLLL.L.LL.LLLL.LLLL.LLLLLL..LLLLLL.LLLLLLLLLLL.LLLLLLLLLLL.LLLLLLL.LLLLLL.LLLLLL.LLLLLLLLLLLLLLLL
LLLLL.LLLL.LLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLL.LLLLLLLL..LLLLLLLL.LLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLL
LLLLL.LLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLL..LLLL.LLLLLL.LLLLLLLLLLLLLLLL.LLLLLL
LLLLL.LLLL.LLLLLLLLLLLLL.LLL.LLLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLL.LLLLLL
LLLLL.LLLL.LLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLL.L.LLLLLLL.LL.LLLLLLL.LL.LLLLLL.LLLLLL.LLLLLLLLL..LLLLL
LLL.L.LLLL.LLLLLLLLL.LLLLLL..LLLLLL.LLLLLLL.LLLLLLLLL.LLLLLLLL.LLLL.LLLLLLL.LLLLL.LLLLLLLLL.LLLLLL
L.LLL.LLLLLLLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLL.LLLL.LLLL..LLLLLLLLLLLLLLLLLL.LLL.LLLLLL"""

let input1="""L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL"""

var rows = input.splitLines()

proc round(): bool =

    let copy = rows.mapIt(it).toSeq

    proc checkRow(r, c: int): int =
        var count = 0

        for i in countdown(c-1, 0):
            if copy[r][i] == '#':
                inc count
                break
            elif copy[r][i] == 'L':
                break

        for i in c+1..len(copy[0])-1:
            if copy[r][i] == '#':
                inc count
                break
            elif copy[r][i] == 'L':
                break

        return count

    proc checkColumn(r, c: int): int =
        var count = 0

        for i in countdown(r-1, 0):
            if copy[i][c] == '#':
                inc count
                break
            elif copy[i][c] == 'L':
                break

        for i in r+1..len(copy)-1:
            if copy[i][c] == '#':
                inc count
                break
            elif copy[i][c] == 'L':
                break

        return count

    proc checkDiagonals(r, c: int): int =

        var count = 0

        var ri = r
        var ci = c

        while true:
            dec ri
            dec ci
            if ri < 0 or ci < 0: 
                break
            
            if copy[ri][ci] == '#':
                inc count
                break
            elif copy[ri][ci] == 'L':
                break

        ri = r
        ci = c

        while true:
            inc ri
            inc ci
            if ri == len(copy) or ci == len(copy[0]): 
                break
            
            if copy[ri][ci] == '#':
                inc count
                break
            elif copy[ri][ci] == 'L':
                break

        ri = r
        ci = c

        while true:
            dec ri
            inc ci
            if ri < 0 or ci == len(copy[0]): 
                break
            
            if copy[ri][ci] == '#':
                inc count
                break
            elif copy[ri][ci] == 'L':
                break

        ri = r
        ci = c

        while true:
            inc ri
            dec ci
            if ri == len(copy) or ci < 0: 
                break
            
            if copy[ri][ci] == '#':
                inc count
                break
            elif copy[ri][ci] == 'L':
                break

        return count

    proc checkAllDirections(r,c: int) : int =
        checkRow(r,c) + checkColumn(r,c) + checkDiagonals(r,c)

    var changed = false
    for r, row in rows:
        for c, seat in row:
            
            if seat == 'L' and checkAllDirections(r,c) == 0:
                    rows[r][c] = '#'
                    changed = true
            
            elif seat == '#' and checkAllDirections(r,c) >= 5:
                    rows[r][c] = 'L'
                    changed = true

    changed 

while round():
    discard

echo rows.mapIt(it.filterIt(it == '#').len).foldl(a+b)