From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: L3 error handling (was: Re: [4.8.0-rc1] am335x-evm boot failure:
 n_tty_receive_buf_common: "Unable to handle kernel paging request..")
Date: Sat, 10 Sep 2016 16:57:24 +0200
Message-ID: <20160910145724.uotyzyi7qsev3hic@squirrel.local>
References: <CAALWOA_7qGg0WyHPE3biVLka7CdLj8VgsGzf1WMG62Rt-oONkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAALWOA_7qGg0WyHPE3biVLka7CdLj8VgsGzf1WMG62Rt-oONkQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 10, 2016 at 04:46:49PM +0200, Matthijs van Duin wrote:
> It probably doesn't help that the L3 interconnect registers on the
> am335x aren't documented in the TRM. See below for its list of
> components, target IDs, address mapping, and L3 error irq routing
> (obtained by mostly-automated scanning/testing).

Whoops, I forgot something :)

// L3F service network
extern HostAgent   host_l3f;	// 0x440'00'000, id 0x00, no irq
extern TargetAgent ta_hash;	// 0x440'00'200, id 0x02, irq_l3f  9
extern TargetAgent ta_aes1;	// 0x440'00'300, id 0x03, irq_l3f 10
extern TargetAgent ta_ocmc;	// 0x440'00'400, id 0x10, irq_l3f  2
extern TargetAgent ta_aes0;	// 0x440'00'500, id 0x04, irq_l3f 11
extern TargetAgent ta_exp;	// 0x440'00'600, id 0x06, irq_l3f  8
extern TargetAgent ta_edmatc0;	// 0x440'00'700, id 0x07, irq_l3f  3
extern TargetAgent ta_edmatc1;	// 0x440'00'800, id 0x08, irq_l3f  4
extern TargetAgent ta_edmatc2;	// 0x440'00'900, id 0x09, irq_l3f  5
extern TargetAgent ta_l4hs_0;	// 0x440'00'a00, id 0x05, irq_l3f 12
extern TargetAgent ta_edmacc;	// 0x440'00'b00, id 0x0b, irq_l3f  6
extern TargetAgent ta_sgx;	// 0x440'00'c00, id 0x0e, irq_l3f 13
extern TargetAgent ta_l3instr;	// 0x440'00'd00, id 0x1f, irq_l3f  7
extern TargetAgent ta_pcie;	// 0x440'00'e00, id 0x0f, irq_l3f  1
extern TargetAgent ta_emif;	// 0x440'00'f00, id 0x01, irq_l3f  0
extern FlagCombiner irq_l3f;	// 0x440'01'000, 14 × { app, dbg }, irq_top 0
extern FlagCombiner irq_top;	// 0x440'01'100,  2 × { app, dbg }
extern Component stats0;	// 0x440'02'000, size  0x800
extern Component stats1;	// 0x440'03'000, size 0x1000
extern Component stats2;	// 0x440'04'000, size  0x800
extern BwRegulator bwreg0;	// 0x440'05'000

// L3S service network
extern HostAgent   host_l3s;	// 0x448'00'000, id 0x0c, no irq
extern TargetAgent ta_l4ls_0;	// 0x448'00'100, id 0x11, irq_l3s  0
extern TargetAgent ta_l4ls_1;	// 0x448'00'200, id 0x12, irq_l3s  1
extern TargetAgent ta_l4ls_2;	// 0x448'00'300, id 0x13, irq_l3s  2
extern TargetAgent ta_l4ls_3;	// 0x448'00'400, id 0x14, irq_l3s  3
extern TargetAgent ta_adc;	// 0x448'00'500, id 0x0a, irq_l3s 10
extern FlagCombiner irq_l3s;	// 0x448'00'600, 13 × { app, dbg }, irq_top 1
extern TargetAgent ta_gpmc;	// 0x448'00'700, id 0x1e, irq_l3s  7
extern TargetAgent ta_mcasp0;	// 0x448'00'800, id 0x20, irq_l3s  4
extern TargetAgent ta_mcasp1;	// 0x448'00'900, id 0x21, irq_l3s  5
extern TargetAgent ta_mcasp2;	// 0x448'00'a00, id 0x22, irq_l3s  6
extern TargetAgent ta_usb;	// 0x448'00'b00, id 0x27, irq_l3s  9
extern TargetAgent ta_mmc2;	// 0x448'00'c00, id 0x26, irq_l3s 12
extern TargetAgent ta_l4fw;	// 0x448'00'd00, id 0x1b, irq_l3s  8
extern TargetAgent ta_l4wk_0;	// 0x448'00'e00, id 0x0d, irq_l3s 11
extern Component stats3;	// 0x448'04'000, size 0x800

l3ls ports 1-3 are just extrapolation since they aren't reachable from
the cortex-A8, the rest is verified.

I also have a list of initiators needed to identify them from L3 error
logs.  I obtained it from info I found floating around and haven't much
validated it yet:

// L3 initiator ids
enum iid6_t {
	I6_HASS_0	= 0x00,  // Cortex-A8, 128-bit port 0 to RAM
	I6_HASS_1	= 0x01,  // Cortex-A8, 64-bit port 1 to peripherals
	I6_DAP		= 0x04,  // Debug access port (AHB-AP)
	I6_DFT		= 0x05,  // Device functional test / IEEE1500
	I6_PRUSS_0	= 0x0e,  // PRU core 0
	I6_PRUSS_1	= 0x0f,  // PRU core 1
	I6_MEDIALB	= 0x10,  // Media local bus (automotive only)
//	I6_WKUPM3	= 0x14,  // Wakeup-M3 (connects to l4wk, not l3)
	I6_EDMATC0_R	= 0x18,  // EDMA transfer controller 0, read port
	I6_EDMATC0_W	= 0x19,  // EDMA transfer controller 0, write port
	I6_EDMATC1_R	= 0x1a,  // EDMA transfer controller 1, read port
	I6_EDMATC1_W	= 0x1b,  // EDMA transfer controller 1, write port
	I6_EDMATC2_R	= 0x1c,  // EDMA transfer controller 2, read port
	I6_EDMATC2_W	= 0x1d,  // EDMA transfer controller 2, write port
	I6_SGX		= 0x20,  // SGX-530 graphics accelerator
	I6_LCDC		= 0x24,  // LCD controller DMA
	I6_EXP		= 0x2c,  // Expansion (not usable or non-existent)
	I6_ETH		= 0x30,  // Ethernet DMA
	I6_USB_DMA	= 0x34,  // USB subsystem DMA, data
	I6_USB_QMGR	= 0x35,  // USB subsystem DMA, queue manager
//	I6_PCIE		= 0x3a,  // PCIe bridge (non-existent)
	I6_STATCOLL_0	= 0x3c,  // L3 statistics collector 0
	I6_STATCOLL_1	= 0x3d,  // L3 statistics collector 1
	I6_STATCOLL_2	= 0x3e,  // L3 statistics collector 2
	I6_STATCOLL_3	= 0x3f,  // L3 statistics collector 3
};

I don't know yet to which initiator bwreg0 belongs, nor any details for
the statistics collectors.

Matthijs
