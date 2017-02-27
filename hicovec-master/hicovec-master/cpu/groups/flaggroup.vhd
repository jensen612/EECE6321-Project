------------------------------------------------------------------
-- PROJECT:      HiCoVec (highly configurable vector processor)
--
-- ENTITY:      flaggroup
--
-- PURPOSE:     status register, flags
--
-- AUTHOR:      harald manske, haraldmanske@gmx.de
--
-- VERSION:     1.0
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity flaggroup is
    port(   -- clock
            clk:     in std_logic;  
            
            -- data inputs
            c_in:   in std_logic;                       --from alu carry_out, to carry_mux data_in_00
            z_in:   in std_logic;                       --from alu zero_out, to zero_mux data_in_00
            
            -- data outputs
            c_out:  out std_logic;                      --generated by carry_flag c_out, to controlunit carry and alu carry_in
            z_out:  out std_logic;                      --generated by zero_flag data_out, to controlunit zero
            
            -- control signals
            load_c: in std_logic;                       --from controlunit load_c, to carry_flag load
            load_z: in std_logic;                       --from controlunit load_z, to zero_flag load
            sel_c:  in std_logic_vector(1 downto 0);    --from controlunit cc5, to carry_mux selector
            sel_z:  in std_logic_vector(1 downto 0)     --from controlunit cc4, to zero_mux selector
         );
end flaggroup;

architecture rtl of flaggroup is 
    component flag
        port(   clk:        in std_logic;
                load:       in std_logic;
                data_in:    in std_logic;
                data_out:   out std_logic
            );
    end component;
    
    component multiplexer4
        generic (
            w : positive
        );
        port (
            selector:    in std_logic_vector(1 downto 0);
            data_in_00:  in std_logic_vector(w-1 downto 0);
            data_in_01:  in std_logic_vector(w-1 downto 0);
            data_in_10:  in std_logic_vector(w-1 downto 0);
            data_in_11:  in std_logic_vector(w-1 downto 0);
            data_out:    out std_logic_vector(w-1 downto 0)
        );
    end component;
    
    for carry_flag: flag use entity work.flag(rtl);
    for zero_flag:  flag use entity work.flag(rtl);
    
    for carry_mux:  multiplexer4 use entity work.multiplexer4(rtl);
    for zero_mux:   multiplexer4 use entity work.multiplexer4(rtl);
    
    signal mux_to_c:    std_logic;
    signal mux_to_z:    std_logic;
    
    begin
        carry_flag: flag port map (
            clk => clk,
            load => load_c,
            data_in => mux_to_c,
            data_out => c_out
        ); 
        
        
        zero_flag: flag port map (
            clk => clk,
            load => load_z,
            data_in => mux_to_z,
            data_out => z_out
        );  
        
        carry_mux: multiplexer4 
            generic map
            (
                w => 1
            )
            port map (
                selector => sel_c,
                data_in_00(0) => c_in,
                data_in_01(0) => '-',
                data_in_10(0) => '0',
                data_in_11(0) => '1',
                data_out(0) => mux_to_c
            );
        
    
        zero_mux: multiplexer4 
            generic map
            (
                w => 1
            )
            port map (
                selector => sel_z,
                data_in_00(0) => z_in,
                data_in_01(0) => '-',
                data_in_10(0) => '0',
                data_in_11(0) => '1',
                data_out(0) => mux_to_z
            );
    
end rtl;
