library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Output_Ports is
	port
	(
		address, data_in	: in  std_logic_vector(7 downto 0);
		clock, reset, writen	: in  std_logic;
		port_out_xx	: out std_logic_vector(7 downto 0)
	);
end Output_Ports;


architecture ARCHOutput_Ports of Output_Ports is

	-- Declarations (optional)
	signal port_out_00, port_out_01 : std_logic_vector(7 downto 0);

begin

	-- port_out_00 description : ADDRESS x"E0"
	U3 : process (clock, reset)
		begin
			if (reset = '0') then
				port_out_00 <= x"00";
			elsif (clock'event and clock='1') then
				if (address = x"E0" and writen = '1') then
					port_out_00 <= data_in;
				end if;
			end if;
		end process;

	-- port_out_01 description : ADDRESS x"E1"
	U4 : process (clock, reset)
		begin
			if (reset = '0') then
				port_out_01 <= x"00";
			elsif (clock'event and clock='1') then
				if (address = x"E1" and writen = '1') then
					port_out_01 <= data_in;
				end if;
			end if;
	end process;
	
	port_out_xx <= port_out_00 or port_out_01;

end ARCHOutput_Ports;

