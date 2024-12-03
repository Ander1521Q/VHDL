library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
	port
	(
		address, data_in, port_in_00, port_in_01	: in  std_logic_vector(7 downto 0);
		clock, reset, writen	: in  std_logic;
		data_out, port_out_xx	: buffer std_logic_vector(7 downto 0);
		display1, display2, display3, display4 : out std_logic_vector(6 downto 0)
	);
end memory;


architecture arch_memory of memory is

	signal rom_data_out, rw_data_out, out_data : std_logic_vector(7 downto 0);
	signal hex_msbA, hex_lsbA, hex_msbD, hex_lsbD : std_logic_vector(3 downto 0);
	
	component sync16x8
		port(	address : in  std_logic_vector(7 downto 0);
				clock : in std_logic;
				data_out : out std_logic_vector(7 downto 0)
			);
	end component;
	
	component rw_sync
		port(	address, data_in : in  std_logic_vector(7 downto 0);
				writen, clock 	: in  std_logic;
				data_out : out std_logic_vector(7 downto 0)
			);
	end component;
	
	component Output_Ports
		port(	address, data_in	: in  std_logic_vector(7 downto 0);
				clock, reset, writen	: in  std_logic;
				port_out_xx	: out std_logic_vector(7 downto 0)
			);
	end component;
	
	component Multiplexor
		port(	address, rom_data_out, rw_data_out, port_in_00, port_in_01: in  std_logic_vector(7 downto 0);
				data_out	: out std_logic_vector(7 downto 0)
			);
	end component;
	
	component hex_to_7seg
      port(	hex : in std_logic_vector(3 downto 0);
            seg : out std_logic_vector(6 downto 0)
			);
   end component;

begin

	ROM : sync16x8 port map (address, clock, rom_data_out);
	
	
	RW	: rw_sync port map (address, data_in, writen, clock, rw_data_out);
	

	OUTPUT : Output_Ports port map (address, data_in, clock, reset, writen, port_out_xx);
	

	MUX : Multiplexor port map (address, rom_data_out, rw_data_out, port_in_00, port_in_01, out_data);
	
	
	
   hex_msbA <= address(7 downto 4);  
   hex_lsbA <= address(3 downto 0);  

 
   hex_to_7seg_msb1: hex_to_7seg port map (hex_msbA, display2);

   hex_to_7seg_lsb1: hex_to_7seg port map (hex_lsbA, display1);
	
	

	data_out <= out_data;
   hex_msbD <= data_out(7 downto 4);  
   hex_lsbD <= data_out(3 downto 0);  


   hex_to_7seg_msb2: hex_to_7seg port map (hex_msbD, display4);

   hex_to_7seg_lsb2: hex_to_7seg port map (hex_lsbD, display3);
	
	

end arch_memory;

