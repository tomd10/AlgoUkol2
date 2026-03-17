# Algoritmizace - úkol 2
## Autor: Tomáš Chabada
## Zadání:
Je dána matice celých čísel velikosti R x S (R řádků, S sloupců). Řádky matice si očíslujeme od 1 do R, sloupce očíslujeme od 1 do S. Chceme nalézt takovou podmatici (souvislý obdélníkový výřez), aby součet všech jejích prvků byl maximální. Výstupem algoritmu bude tedy čtveřice čísel r1, r2, s1, s2, která v tomto pořadí určují první a poslední řádek, resp. první a poslední sloupec nalezené podmatice. Stačí určit jedno libovolné řešení, pokud jich existuje více. Navrhněte postup, jak správně vyřešit úlohu s co nejlepší časovou složitostí vzhledem k hodnotám R, S. Algoritmus popište, zdůvodněte jeho správnost a odvoďte jeho asymptotickou složitost.

## Úvaha
Matici budeme reprezentovat jako 2D pole. Nejprve implementujeme řešení hrubou silou a pomocí něj ověříme ostatní algoritmy.

# Algoritmus 1 (hrubá síla)
Projdeme postupně všechny možné podmatice zadané matice, pro každou spočteme součet a porovnáme s dočasným nejlepším maximem. Nejlepší maximum inicializujeme na hodnotu levého horního prvku v matici.
Možností, kde může podmatice začít (tj. kde je její levý horní roh) je obecně RS. Možných délek podmatice je až R, možných šířek je až S. Posčítat prvky každé podmatice je práce řádově RS.
**Prostorová složitost** je O(RS) (máme jen matici ze zadání a pár proměnných s konstantní délkou).
**Časová složitost** je O(R^3 S^3), zdůvodnění viz. výše.

# Algoritmus 2 (prefix + hrubá síla)
Předpočteme si pole prefixových součtů řádků (tj. prvek v matici prefixových součtů na pozici (i, j) bude obsahovat součet (i, 0) + (i, 1) + ... + (i, j)). Díky tomu můžeme sečíst podmatici v čase řádově R (pro součet celého řádku stačí jen odečíst hodnoty na konci a před začátkem sčítaného řádku; "před" prvním prvkem v řádku je vždy nulu). Hrubou silou z předchozího algoritmu ozkoušíme všechny možné podmatice. 
**Prostorová složitost** je O(RS) (máme jen matici ze zadání a matici prefixových součtů stejné délky, plus pár proměnných s konstantní délkou).
**Časová složitost** je O(R^2 S^3). Složitost je stejná jako v algoritmu 1, až na nižší exponent u R (rychlejší součet podmatice díky předpočtu).

# Algoritmus 3 (Kadane)
Optimální řešení úlohy je Kadane algoritmus. V základní verzi se používá pro nalezení podpole s nejvyšším součtem (tj. 1D verze) v lineárním čase. Procházíme nejprve všechny možné začátky a konce sloupců podmatice (tj. možné hodnoty S1 a S2). Poté přičítáme úseky řádků v tomto rozsahu do součtového pole ("komprese") a po každém přičteném řádku hledáme v tomto poli rozsah s největším součtem pomocí Kadane. Kadane vrátí součet (ten porovnáme s dočasným maximem, ukládáme v případě vyššího součtu) a začátek a konec tohoto úseku (odpovídá hledaným hodnotám R1 a R2).
**Prostorová složitost** je O(RS) (máme jen matici ze zadání a pomocné pole délky R).
**Časová složitost** je O(RS^2). Možných kombinací hodnot S1, S2 je obecně S^2 (zkoušíme všechny) a pro každou kombinaci sčítáme řádky (R) a hledáme největší součet pomocí Kadane.
