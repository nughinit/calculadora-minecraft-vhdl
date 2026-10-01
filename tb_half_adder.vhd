--------------------------------------------------------------------------------
-- Arquivo   : tb_half_adder.vhd
-- Entidade  : tb_half_adder
-- Descricao : Testbench do half adder. Aplica as 4 combinacoes possiveis de
--             entrada (00, 01, 10, 11) e verifica automaticamente se S e C
--             correspondem a tabela-verdade. Se algo estiver errado, a
--             simulacao reporta um erro; se tudo estiver certo, imprime
--             "TESTE OK" no final.
--
-- Um testbench nao e sintetizavel (nao vira hardware): ele existe apenas para
-- gerar estimulos e conferir resultados durante a simulacao. Por isso nao tem
-- portas (ports).
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity tb_half_adder is
  -- entidade vazia: o testbench nao tem entradas nem saidas
end entity tb_half_adder;

architecture sim of tb_half_adder is

  -- Sinais internos que ligam o testbench ao circuito sob teste (UUT)
  signal A, B : std_logic := '0';  -- entradas, controladas pelo testbench
  signal S, C : std_logic;         -- saidas, observadas pelo testbench

begin

  -- Instancia o circuito sob teste (Unit Under Test)
  uut : entity work.half_adder
    port map (
      A => A,
      B => B,
      S => S,
      C => C
    );

  -- Processo de estimulo: muda as entradas e confere as saidas
  stimulus : process
  begin
    -- Caso 0 + 0 = 0 (C=0, S=0)
    A <= '0'; B <= '0';
    wait for 10 ns;  -- espera o circuito estabilizar antes de conferir
    assert (S = '0' and C = '0')
      report "FALHA em A=0 B=0: esperado S=0 C=0" severity error;

    -- Caso 0 + 1 = 1 (C=0, S=1)
    A <= '0'; B <= '1';
    wait for 10 ns;
    assert (S = '1' and C = '0')
      report "FALHA em A=0 B=1: esperado S=1 C=0" severity error;

    -- Caso 1 + 0 = 1 (C=0, S=1)
    A <= '1'; B <= '0';
    wait for 10 ns;
    assert (S = '1' and C = '0')
      report "FALHA em A=1 B=0: esperado S=1 C=0" severity error;

    -- Caso 1 + 1 = 2 = "10" (C=1, S=0)
    A <= '1'; B <= '1';
    wait for 10 ns;
    assert (S = '0' and C = '1')
      report "FALHA em A=1 B=1: esperado S=0 C=1" severity error;

    report "TESTE OK: as 4 combinacoes foram verificadas" severity note;

    wait;  -- suspende o processo para sempre, encerrando a simulacao
  end process stimulus;

end architecture sim;
