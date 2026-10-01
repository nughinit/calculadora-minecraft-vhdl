--------------------------------------------------------------------------------
-- Arquivo   : half_adder.vhd
-- Entidade  : half_adder
-- Descricao : Somador completo de 1 bit sem carry-in (half adder / meio somador).
--             Soma dois bits A e B e produz dois bits de saida:
--               S : bit de soma (digito da posicao atual)
--               C : bit de carry ("vai-um" para a proxima posicao)
--
-- Tabela-verdade:
--
--     A | B || C | S      (C S lidos juntos formam o resultado em binario)
--    ---+---++---+---
--     0 | 0 || 0 | 0      0 + 0 = 0
--     0 | 1 || 0 | 1      0 + 1 = 1
--     1 | 0 || 0 | 1      1 + 0 = 1
--     1 | 1 || 1 | 0      1 + 1 = 2 = "10" em binario
--
-- Equacoes booleanas (lendo as colunas da tabela):
--     S = A xor B    -> S vale 1 quando as entradas sao DIFERENTES
--     C = A and B    -> C vale 1 somente quando as DUAS entradas valem 1
--
-- Circuito: uma porta XOR e uma porta AND ligadas as mesmas entradas A e B.
--
-- Observacao: o half adder nao tem entrada de carry-in, por isso nao pode ser
-- encadeado para somar numeros de varios bits. Para isso e necessario o
-- full adder (A, B e Cin), que e construido a partir de dois half adders.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;  -- fornece o tipo std_logic e os operadores logicos

entity half_adder is
  port (
    A : in  std_logic;  -- primeiro operando (1 bit)
    B : in  std_logic;  -- segundo operando  (1 bit)
    S : out std_logic;  -- soma: A xor B
    C : out std_logic   -- carry: A and B
  );
end entity half_adder;

architecture rtl of half_adder is
begin
  -- Logica puramente combinacional: as saidas dependem apenas das entradas
  -- atuais, sem clock e sem memoria. Cada atribuicao concorrente abaixo vira
  -- uma porta logica independente em hardware, todas operando em paralelo.

  S <= A xor B;  -- porta XOR: bit de soma
  C <= A and B;  -- porta AND: bit de carry
end architecture rtl;
