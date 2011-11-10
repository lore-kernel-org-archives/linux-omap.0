From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix map_io for Amstrad E3
Date: Thu, 10 Nov 2011 15:23:49 -0800
Message-ID: <20111110232349.GY31337@atomide.com>
References: <B8A6ED05-78AC-4140-A9B8-8265F1E9C32F@iki.fi>
 <20111109231900.GS31337@atomide.com>
 <20111109232525.GT31337@atomide.com>
 <20111109233900.GP15294@n2100.arm.linux.org.uk>
 <20D8B951-2E77-42DF-B735-6062994D47D5@iki.fi>
 <20111110000421.GU31337@atomide.com>
 <alpine.DEB.2.00.1111102349170.19713@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17712 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754060Ab1KJXX5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Nov 2011 18:23:57 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1111102349170.19713@dell>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [111110 13:31]:
> --- a/arch/arm/mach-omap1/clock_data.c
> +++ b/arch/arm/mach-omap1/clock_data.c
> @@ -774,14 +774,6 @@ int __init omap1_clk_init(void)
>  	int crystal_type = 0; /* Default 12 MHz */
>  	u32 reg, cpu_mask;
> 
> -#ifdef CONFIG_DEBUG_LL
> -	/*
> -	 * Resets some clocks that may be left on from bootloader,
> -	 * but leaves serial clocks on.
> -	 */
> -	omap_writel(0x3 << 29, MOD_CONF_CTRL_0);
> -#endif
> -
>  	/* USB_REQ_EN will be disabled later if necessary (usb_dc_ck) */
>  	reg = omap_readw(SOFT_REQ_REG) & (1 << 4);
>  	omap_writew(reg, SOFT_REQ_REG);

Hmm that should keep the serial clocks on. What other bit(s) need to
be on in MOD_CONF_CTRL_0 for you in addition to the serial bits?
 
> 2) By using the above hack, I could see the actual crash:
> 
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 3.2.0-rc1-e3 (aaro@dell) (gcc version 4.6.1 (GCC) ) #9 PREEMPT Thu Nov 10 23:48:23 EET 2011
> [    0.000000] CPU: ARM925T [54029252] revision 2 (ARMv4T), cr=0000317f
> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> [    0.000000] Machine: Amstrad E3 (Delta)
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Memory policy: ECC disabled, Data cache writethrough
> [    0.000000] OMAP1510
> [    0.000000]  revision 2 handled as 15xx id: bc058c9b93111a16
> [    0.000000] Clocks: ARM_SYSST: 0x1000 DPLL_CTL: 0x2cb3 ARM_CKCTL: 0x250e
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] kernel BUG at arch/arm/plat-omap/sram.c:226!
> [    0.000000] Internal error: Oops - undefined instruction: 0 [#1] PREEMPT
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0    Not tainted  (3.2.0-rc1-e3 #9)
> [    0.000000] PC is at omap_sram_reprogram_clock+0x28/0x30
> [    0.000000] LR is at omap1_select_table_rate+0x88/0xb4
> [    0.000000] pc : [<c001b0c4>]    lr : [<c0019f54>]    psr: 600000d3
> [    0.000000] sp : c035bf10  ip : c035bf20  fp : c035bf1c
> [    0.000000] r10: c035bfd4  r9 : 54029252  r8 : c03f8120
> [    0.000000] r7 : c0362b50  r6 : 00b71b00  r5 : c03873cc  r4 : c0362b40
> [    0.000000] r3 : 00000000  r2 : c0362b40  r1 : 0000010a  r0 : 00002cb0
> [    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
> [    0.000000] Control: 0000317f  Table: 10004000  DAC: 00000017
> [    0.000000] Process swapper (pid: 0, stack limit = 0xc035a270)
> [    0.000000] Stack: (0xc035bf10 to 0xc035c000)
> [    0.000000] bf00:                                     c035bf3c c035bf20 c0019f54 c001b0ac
> [    0.000000] bf20: 00001000 00002cb3 00000004 c035ed4c c035bf74 c035bf40 c033ea24 c0019edc
> [    0.000000] bf40: c02f526c 00000002 00000015 bc058c9b 93111a16 c035335c 02000000 c035ed4c
> [    0.000000] bf60: c035ed4c c03f8120 c035bf84 c035bf78 c00194c4 c033e8ec c035bfc4 c035bf88
> [    0.000000] bf80: c033bc24 c00194a0 c035bf90 c035bf98 00000000 00000000 00000000 00000000
> [    0.000000] bfa0: 00000001 00000000 c0354678 c035ece4 10004000 103532f4 c035bff4 c035bfc8
> [    0.000000] bfc0: c0338574 c033b598 00000000 00000000 00000000 c035467c 0000317d c035c03c
> [    0.000000] bfe0: c0354678 c035ece4 00000000 c035bff8 10008040 c0338508 00000000 00000000
> [    0.000000] Backtrace:
> [    0.000000] [<c001b09c>] (omap_sram_reprogram_clock+0x0/0x30) from [<c0019f54>] (omap1_select_table_rate+0x88/0xb4)
> [    0.000000] [<c0019ecc>] (omap1_select_table_rate+0x0/0xb4) from [<c033ea24>] (omap1_clk_init+0x148/0x334)
> [    0.000000]  r7:c035ed4c r6:00000004 r5:00002cb3 r4:00001000
> [    0.000000] [<c033e8dc>] (omap1_clk_init+0x0/0x334) from [<c00194c4>] (omap1_init_early+0x34/0x48)
> [    0.000000]  r8:c03f8120 r7:c035ed4c r6:c035ed4c r5:02000000 r4:c035335c
> [    0.000000] [<c0019490>] (omap1_init_early+0x0/0x48) from [<c033bc24>] (setup_arch+0x69c/0x79c)
> [    0.000000] [<c033b588>] (setup_arch+0x0/0x79c) from [<c0338574>] (start_kernel+0x7c/0x2f4)
> [    0.000000] [<c03384f8>] (start_kernel+0x0/0x2f4) from [<10008040>] (0x10008040)
> [    0.000000]  r7:c035ece4 r6:c0354678 r5:c035c03c r4:0000317d
> [    0.000000] Code: 0a000002 e1a0e00f e12fff13 e89da800 (e7f001f2)
> [    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
> 
> The BUG_ON() in omap_sram_reprogram_clock() triggers, because
> it's called before omap_sram_init(). If I comment out the code in
> omap_sram_reprogram_clock(), the board boots up.

Ouch. I guess I have not seen that as omap1_defconfig has by default
CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER=y. To fix the issue you're seeing
we should move some of omap1_clk_init into an arch_initcall that calls
omap1_select_table_rate later on, and then does propagate_rate(&ck_ref).
This way sram is configured when omap_sram_reprogram_clock gets called.

Regards,

Tony
