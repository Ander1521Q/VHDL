library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplexor is
	port
	(
		address, rom_data_out, rw_data_out, port_in_00, port_in_01: in  std_logic_vector(7 downto 0);
		data_out	: out std_logic_vector(7 downto 0)
	);
end Multiplexor;


architecture arch_Multiplexor of Multiplexor is

	-- Declarations (optional)

begin

	MUX1 : process (address, rom_data_out, rw_data_out, port_in_00, port_in_01)
		begin
			if ( (to_integer(unsigned(address)) >= 0) and
					(to_integer(unsigned(address)) <= 127)) then
				data_out <= rom_data_out;
			elsif ( (to_integer(unsigned(address)) >= 128) and
					(to_integer(unsigned(address)) <= 223)) then
				data_out <= rw_data_out;
			elsif (address = x"F0") then data_out <= port_in_00;
			elsif (address = x"F1") then data_out <= port_in_01;
			else data_out <= x"00";
			end if;
	end process;

end arch_Multiplexor;

