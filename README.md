# Half Adder em VHDL

Somador de 1 bit (meio somador) em VHDL, com testbench auto-verificável.
Projeto didático: mostra como a álgebra booleana vira hardware.

## O que o circuito faz

Soma dois bits `A` e `B` e produz duas saídas:

- `S` (soma): o dígito da posição atual
- `C` (carry): o "vai-um" para a próxima posição

| A | B | C | S |
|---|---|---|---|
| 0 | 0 | 0 | 0 |
| 0 | 1 | 0 | 1 |
| 1 | 0 | 0 | 1 |
| 1 | 1 | 1 | 0 |

Equações: `S = A xor B` e `C = A and B`.

## Arquivos

| Arquivo | Descrição |
|---|---|
| `half_adder.vhd` | Entidade e arquitetura do half adder |
| `tb_half_adder.vhd` | Testbench com as 4 combinações de entrada |
| `Makefile` | Atalhos para simular com GHDL |

## Como rodar

### Opção 1: no navegador (sem instalar nada)

1. Abra [EDA Playground](https://www.edaplayground.com).
2. Em *Testbench + Design*, escolha VHDL, cole `tb_half_adder.vhd` no painel do testbench e `half_adder.vhd` no painel do design.
3. Escolha o simulador **GHDL**, marque *Open EPWave after run* e clique em *Run*.

### Opção 2: localmente com GHDL + GTKWave

Instale o [GHDL](https://github.com/ghdl/ghdl) e, opcionalmente, o [GTKWave](https://gtkwave.sourceforge.net). Depois:

```
make         # simula e mostra "TESTE OK" ou os erros
make wave    # simula e abre as formas de onda
make clean   # limpa os arquivos gerados
```

Ou manualmente:

```
ghdl -a --std=08 half_adder.vhd tb_half_adder.vhd
ghdl -e --std=08 tb_half_adder
ghdl -r --std=08 tb_half_adder --wave=saida.ghw
gtkwave saida.ghw
```

Saída esperada: `TESTE OK: as 4 combinacoes foram verificadas`.

### Logisim

Monte uma porta XOR e uma porta AND ligadas às mesmas entradas `A` e `B`. A saída do XOR é `S` e a do AND é `C`.

## Próximos passos

- Full adder (adiciona a entrada `Cin`, construído com dois half adders)
- Somador ripple-carry de N bits e análise do atraso de propagação do carry
- MUX, FSM e datapath
