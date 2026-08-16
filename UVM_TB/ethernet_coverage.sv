`include "uvm_macros.svh"

import uvm_pkg::*;
import ethernet_pkg::*;

class ethernet_coverage extends uvm_subscriber #(ethernet_transaction);

    `uvm_component_utils(ethernet_coverage)

    //----------------------------------------------------------
    // Transaction Handle
    //----------------------------------------------------------

    ethernet_transaction tr;

    //----------------------------------------------------------
    // Functional Coverage
    //----------------------------------------------------------

    covergroup ethernet_cg;

        option.per_instance = 1;
        option.name = "Ethernet_Functional_Coverage";

    //------------------------------------------------------
    // Sync Header Coverage
    //------------------------------------------------------

    cp_sync_header : coverpoint tr.encoded_data[65:64]
    {
        bins data_hdr    = {2'b01};
        bins control_hdr = {2'b10};

        illegal_bins invalid = default;
    }


    //------------------------------------------------------
    // TXC Pattern Coverage
    //------------------------------------------------------

    cp_txc : coverpoint tr.txc
    {
        bins data  = {8'h00};

        bins start = {8'h01};

        bins term0 = {8'hFF};
        bins term1 = {8'hFE};
        bins term2 = {8'hFC};
        bins term3 = {8'hF8};
        bins term4 = {8'hF0};
        bins term5 = {8'hE0};
        bins term6 = {8'hC0};
        bins term7 = {8'h80};

        bins invalid = default;
    }


    //------------------------------------------------------
    // VALID_IN Coverage
    //------------------------------------------------------

    cp_valid_in : coverpoint tr.valid_in
    {
        bins low  = {0};
        bins high = {1};
    }


    //------------------------------------------------------
    // VALID_OUT Coverage
    //------------------------------------------------------

    cp_valid_out : coverpoint tr.valid_out
    {
        bins low  = {0};
        bins high = {1};
    }


    //------------------------------------------------------
    // Decode Error Coverage
    //------------------------------------------------------

    cp_decode_error : coverpoint tr.decode_error
    {
        bins no_error = {0};
        bins error    = {1};
    }


    //------------------------------------------------------
    // Encoded Block Type Coverage
    //------------------------------------------------------

    cp_block_type : coverpoint tr.encoded_data[63:56]
    {
        bins idle_blk  = {IDLE_BLOCK_TYPE};

        bins start_blk = {START_BLOCK_TYPE};

        bins term0_blk = {TERM0_BLOCK_TYPE};
        bins term1_blk = {TERM1_BLOCK_TYPE};
        bins term2_blk = {TERM2_BLOCK_TYPE};
        bins term3_blk = {TERM3_BLOCK_TYPE};
        bins term4_blk = {TERM4_BLOCK_TYPE};
        bins term5_blk = {TERM5_BLOCK_TYPE};
        bins term6_blk = {TERM6_BLOCK_TYPE};
        bins term7_blk = {TERM7_BLOCK_TYPE};

        bins fault_blk = {FAULT_BLOCK_TYPE};

        bins data_blk = default iff (tr.encoded_data[65:64] == 2'b01);
    }

    //------------------------------------------------------
    // End Covergroup
    //------------------------------------------------------

    endgroup


    //------------------------------------------------------
    // Constructor
    //------------------------------------------------------

    function new(string name = "ethernet_coverage",
                 uvm_component parent = null);

        super.new(name, parent);

        ethernet_cg = new();

    endfunction


    //------------------------------------------------------
    // Write Method
    //------------------------------------------------------

    virtual function void write(ethernet_transaction t);

        tr = t;

        ethernet_cg.sample();

    endfunction


        //------------------------------------------------------
    // Report Phase
    //------------------------------------------------------

//     function void report_phase(uvm_phase phase);

//         string report;

//         super.report_phase(phase);

//         report = "\n";

//         report = {report,
// "===============================================================\n"};

//         report = {report,
// "              ETHERNET FUNCTIONAL COVERAGE\n"};

//         report = {report,
// "===============================================================\n"};

//         report = {report,
//         $sformatf("Overall Functional Coverage : %0.2f %%\n",
//                   ethernet_cg.get_inst_coverage())};

//         report = {report,
// "==============================================================="};

//         `uvm_info(get_type_name(), report, UVM_NONE)

//     endfunction

endclass