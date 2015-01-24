From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Add dm816x hwmod support
Date: Fri, 23 Jan 2015 16:14:50 -0800
Message-ID: <20150124001450.GA28663@atomide.com>
References: <1421191355-12835-1-git-send-email-tony@atomide.com>
 <1421191355-12835-3-git-send-email-tony@atomide.com>
 <20150114194301.GR2419@atomide.com>
 <20150117163144.GQ18552@atomide.com>
 <20150121043436.GP7718@atomide.com>
 <alpine.DEB.2.02.1501230918390.5450@utopia.booyaka.com>
 <alpine.DEB.2.02.1501231757400.5450@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp6.ore.mailhop.org ([54.149.35.133]:44624 "EHLO
	smtp6.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbbAXASI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2015 19:18:08 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1501231757400.5450@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aida Mynzhasova <aida.mynzhasova@skitlab.ru>, Brian Hutchinson <b.hutchman@gmail.com>

* Paul Walmsley <paul@pwsan.com> [150123 10:24]:
> Hi Tony 
> 
> thought about this some more overnight...
> 
> On Fri, 23 Jan 2015, Paul Walmsley wrote:
> 
> > On Tue, 20 Jan 2015, Tony Lindgren wrote:
> 
> > > +/* L3 Interconnect entries */
> > > +static struct omap_hwmod dm816x_l3_s_hwmod = {
> > > +	.name		= "l3_s",
> > 
> > Would suggest naming this l3_slow
> > 
> > > +	.clkdm_name	= "alwon_l3s_clkdm",
> > > +	.class		= &l3_hwmod_class,
> > > +	.flags		= HWMOD_NO_IDLEST,
> > > +};
> > > +
> > > +static struct omap_hwmod __used dm816x_l3_med_hwmod = {
> > 
> > Hmm, why __used for this -- maybe just add it to the hwmod list at the 
> > bottom?
> > 
> > > +	.name		= "l3_med",
> > > +	.clkdm_name	= "alwon_l3_med_clkdm",
> > > +	.class		= &l3_hwmod_class,
> > > +	.flags		= HWMOD_NO_IDLEST,
> > > +};
> > > +
> > > +static struct omap_hwmod __used dm816x_l3_fast_hwmod = {
> > 
> > Same __used comment as above.

Yes good point I've added them now.
 
> Looking at the TRM CLKSTCTRL registers for the various L3 buses, it 
> occurred to me that if we wanted to portray this accurately, we'd 
> probably need separate hwmods for the ALWON and DEFAULT branches of the L3 
> as well.  So there would be six in total: 
> {alwon,default}_l3_{slow,med,fast}.  
> 
> It looks like it's possible to roughly figure out which targets are 
> associated with which variant of the L3 by looking at the CLKACTIVITY 
> bits.  So for example, it looks like most of the L3 Slow targets are on 
> ALWON_L3_SLOW according to Table 18-136 "CM_ALWON_L3_SLOW_CLKSTCTRL 
> Register Field descriptions", with the exception of USB, which appears to 
> be on DEFAULT_L3_SLOW according to Table 18-80 
> "CM_DEFAULT_L3_SLOW_CLKSTCTRL Register Field Descriptions".

OK I think I got that done too now.
 
> Anyway, I'm sorry to put you through this, reverse-engineering this stuff 
> isn't very pleasant :-(  After reflecting on the matter, I would be OK to 
> ack the merge of the original L3-related hwmod data that you proposed, 
> with two changes:
> 
> - dropping the __used and adding the two hwmods to the list at the bottom, 
> assuming that the system still boots in that configuration (i.e., if it 
> doesn't cause problems with the clockdomain programming, since it might 
> appear that there are no devices/clocks active in those clockdomains)
> 
> - adding a comment noting that there probably should be six L3 hwmods as 
> described above, but that this is left for future work

Oh we're so close to the merge window that we're cutting special deals? :)

I think I got all that done now, except I did not add the missing domains
for the devices that are not yet listed.
 
> It would still be cool if you could doublecheck the SYSC/SYSS data for the 
> other IP blocks that are listed below.
> 
> > > +	.name		= "l3_fast",
> > > +	.clkdm_name	= "alwon_l3_fast_clkdm",
> > > +	.class		= &l3_hwmod_class,
> > > +	.flags		= HWMOD_NO_IDLEST,
> > > +};
> 
> See below, I screwed up the review comment ordering here...
> 
> > > +
> > > +/*
> > > + * L4 standard peripherals, see TRM table 1-12 for devices using this.
> > > + * Devices using this have 125MHz SYSCLK5 clock.
> > > + */
> > > +static struct omap_hwmod dm816x_l4_ls_hwmod = {
> > > +	.name		= "l4_ls",
> > > +	.clkdm_name	= "alwon_l3s_clkdm",
> > > +	.class		= &l4_hwmod_class,
> > > +	.flags		= HWMOD_NO_IDLEST,
> > 
> > Section 18.7.17.46 "CM_ALWON_L3_CLKCTRL Register" lists an IDLEST bitfield 
> > for this.
> 
> Well I meant for this comment to be attached to the l3_fast hwmod.  But 
> thinking about it further, I think this IDLEST is actually associated with 
> the L3 configuration *register target*, rather than the L3 itself.  This 
> appears to be located at 0x44000000, according to the memory map in 
> Section 1.5.1.  Register targets are usually what the IDLEST bits are 
> intended to protect.  So I think it's OK to keep HWMOD_NO_IDLEST for the 
> l3_fast hwmod, and then later to add a separate hwmod for the L3 config 
> space.
> 
> What I meant to write was:
> 
> Section 18.7.17.48 "CM_ALWON_L4LS_CLKCTRL Register" lists an IDLEST   
> bitfield for this.
> 
> > > +};
> > > +
> > > +/*
> > > + * L4 high-speed peripherals. For devices using this, please see the TRM
> > > + * "Table 1-13. L4 High-Speed Peripheral Memory Map". On dm816x, only
> > > + * EMAC, MDIO and SATA use this.
> > > + */
> > > +static struct omap_hwmod dm816x_l4_hs_hwmod = {
> > > +	.name		= "l4_hs",
> > > +	.clkdm_name	= "alwon_l3_med_clkdm",
> > > +	.class		= &l4_hwmod_class,
> > > +	.flags		= HWMOD_NO_IDLEST,
> > 
> > Section 18.7.17.47 "CM_ALWON_L4HS_CLKCTRL Register" lists an IDLEST 
> > bitfield for this.

Hmm so I've kept them for dm816x_*_l3_*_hwmod but removed them for the
dm816x_l4_*_hwmod. Can you please check if that's now to your liking?

> [ ... ]
> 
> > The 816x TRM is pretty crappy when it comes to integration documentation, 
> > so it's not so easy to figure out what IP blocks are connected to which 
> > initiators.  (Maybe it doesn't even matter that much in the long run; I 
> > doubt anyone is going to spend much time on PM or DMA path hacking for 
> > these DM816x chips.)  Anyway, I think it's pretty safe to assume that any 
> > IP block with a 128-bit or 64-bit initiator port onto the interconnect 
> > probably isn't connected to the L3 Slow interconnect.  So looking at 
> > Figure 1-75 "L3 Interconnect Block Diagram" and Section 1.11.2.2 "L3 Port 
> > Mapping" this includes the MPU L3 port, HDVICP2-{0,1,2} initiator ports, 
> > IOMMU, DSP, TPTC, TPCC, VPSS M0/M1 ports, SGX, Media Controller, expansion 
> > slot 0 initiator, EMIF0/1, and PCIe.    Similarly I'd assume that anything 
> > with a 128-bit target port off of the interconnect is on the L3 Fast: DMM 
> > T0/T1, HDVICP-{0,1,2} target ports, DSP SDMA, expansion slot 0 target.

Seems the table 1-73 is the best documentation for that by looking at the
clock rates 125, 250 or 500MHz.
  
> > One should be able to cross-check these in two ways: first, by clocking, 
> > by looking at Table 1-73 "System Clock Domains" and Figure 1-68 "Detailed 
> > Clock Architecture".  The L3 Fast is driven by SYSCLK4, so anything with 
> > an interface clock of SYSCLK4 is probably hanging off the L3 Fast.  A 
> > SYSCLK5 interface clock probably means either L3 Medium or L4 HS.  
> > SYSCLK6 interface clocks likely mean either L3 Slow or L4 LS.
> > 
> > The other way to cross-check these is by the address ranges in Section 1.5 
> > "Memory Map".   This looks primarily useful for L4 HS/L4 LS...
> 
> Well also as I mentioned above, one can doublecheck with the CLKSTCTRL 
> registers too, at least for some of the IP blocks...
> 
> > Glancing at Table 1-73, it looks to me like a reasonable rule of thumb 
> > would be that anything with a 128-bit interconnect port is probably on L3 
> > Fast, anything with a 64-bit interconnect port is probably on L3 Medium, 
> > and anything with a 32-bit port on the L3 is probably on L3 Slow.

Probably the clock rate in that table is even a better reference :)
 
> ... but if you agree with my earlier comments about postponing the 
> accurate encoding of the details of the interconnect structure until 
> later, and getting something basic that boots into mainline so we have a 
> platform to regression-test against, I'm OK with putting this step off 
> until later, as long as we have a comment noting that in our docs.

Yeah well it works for basic usage for clocks, uarts, i2c, mmc, Ethernet,
edma, gpmc and spi so it's easy for people to add more support as needed.
 
> Anyway, if you can doublecheck the SYSC/SYSS data for accuracy, then the 
> rest is
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> and we'll try to proceed incrementally with the rest of it.

OK let's hope I got all the things you mentioned fixed up. Updated
patch below.

Regards,

Tony

8< -----------------------------------
>From 60452e7ea6554314283438a441943d05d626bfec Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 23 Jan 2015 07:52:46 -0800
Subject: [PATCH] ARM: OMAP2+: Add dm816x hwmod support

Add minimal hwmod support that works at least on dm8168. This
is based on the code in the earlier TI CDP tree, and an earlier
patch by Aida Mynzhasova <aida.mynzhasova@skitlab.ru>.

I've set up things to work pretty much the same way as for
am33xx. We are basically using cm33xx.c with a different set
of clocks and clockdomains.

This code is based on the TI81XX-LINUX-PSP-04.04.00.02 patches
published at:

http://downloads.ti.com/dsps/dsps_public_sw/psp/LinuxPSP/TI81XX_04_04/04_04_00_02/index_FDS.html

Cc: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
Cc: Brian Hutchinson <b.hutchman@gmail.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -121,6 +121,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-prcm-4-5-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-prcm-4-5-common)
 obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-prcm-4-5-common)
 am33xx-43xx-prcm-common			+= prm33xx.o cm33xx.o
+obj-$(CONFIG_SOC_TI81XX)		+= $(am33xx-43xx-prcm-common)
 obj-$(CONFIG_SOC_AM33XX)		+= $(am33xx-43xx-prcm-common)
 obj-$(CONFIG_SOC_AM43XX)		+= $(omap-prcm-4-5-common) \
 					   $(am33xx-43xx-prcm-common)
@@ -225,6 +226,7 @@ obj-$(CONFIG_SOC_AM33XX)		+= omap_hwmod_33xx_43xx_ipblock_data.o
 obj-$(CONFIG_SOC_AM43XX)		+= omap_hwmod_43xx_data.o
 obj-$(CONFIG_SOC_AM43XX)		+= omap_hwmod_33xx_43xx_interconnect_data.o
 obj-$(CONFIG_SOC_AM43XX)		+= omap_hwmod_33xx_43xx_ipblock_data.o
+obj-$(CONFIG_SOC_TI81XX)		+= omap_hwmod_81xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= omap_hwmod_54xx_data.o
 obj-$(CONFIG_SOC_DRA7XX)		+= omap_hwmod_7xx_data.o
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -545,10 +545,12 @@ void __init ti814x_init_early(void)
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE), NULL);
 	omap3xxx_check_revision();
 	ti81xx_check_features();
+	am33xx_prm_init();
+	am33xx_cm_init();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
 	ti81xx_clockdomains_init();
-	omap3xxx_hwmod_init();
+	ti81xx_hwmod_init();
 	omap_hwmod_init_postsetup();
 	if (of_have_populated_dt())
 		omap_clk_soc_init = ti81xx_dt_clk_init;
@@ -564,10 +566,12 @@ void __init ti816x_init_early(void)
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE), NULL);
 	omap3xxx_check_revision();
 	ti81xx_check_features();
+	am33xx_prm_init();
+	am33xx_cm_init();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
 	ti81xx_clockdomains_init();
-	omap3xxx_hwmod_init();
+	ti81xx_hwmod_init();
 	omap_hwmod_init_postsetup();
 	if (of_have_populated_dt())
 		omap_clk_soc_init = ti81xx_dt_clk_init;
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3916,7 +3916,7 @@ void __init omap_hwmod_init(void)
 		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
 		soc_ops.init_clkdm = _init_clkdm;
-	} else if (soc_is_am33xx()) {
+	} else if (cpu_is_ti816x() || soc_is_am33xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
 		soc_ops.wait_target_ready = _omap4_wait_target_ready;
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -748,6 +748,7 @@ extern int omap3xxx_hwmod_init(void);
 extern int omap44xx_hwmod_init(void);
 extern int omap54xx_hwmod_init(void);
 extern int am33xx_hwmod_init(void);
+extern int ti81xx_hwmod_init(void);
 extern int dra7xx_hwmod_init(void);
 int am43xx_hwmod_init(void);
 
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -0,0 +1,1136 @@
+/*
+ * DM81xx hwmod data.
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
+ * Copyright (C) 2013 SKTB SKiT, http://www.skitlab.ru/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/hsmmc-omap.h>
+#include <linux/platform_data/spi-omap2-mcspi.h>
+#include <plat/dmtimer.h>
+
+#include "omap_hwmod_common_data.h"
+#include "cm81xx.h"
+#include "ti81xx.h"
+#include "wd_timer.h"
+
+/*
+ * DM816X hardware modules integration data
+ *
+ * Note: This is incomplete and at present, not generated from h/w database.
+ */
+
+/*
+ * The alwon .clkctrl_offs field is offset from the CM_ALWON, that's
+ * TRM 18.7.17 CM_ALWON device register values minus 0x1400.
+ */
+#define DM816X_DM_ALWON_BASE		0x1400
+#define DM816X_CM_ALWON_MCASP0_CLKCTRL	(0x1540 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_MCASP1_CLKCTRL	(0x1544 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_MCASP2_CLKCTRL	(0x1548 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_MCBSP_CLKCTRL	(0x154c - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_UART_0_CLKCTRL	(0x1550 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_UART_1_CLKCTRL	(0x1554 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_UART_2_CLKCTRL	(0x1558 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_GPIO_0_CLKCTRL	(0x155c - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_GPIO_1_CLKCTRL	(0x1560 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_I2C_0_CLKCTRL	(0x1564 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_I2C_1_CLKCTRL	(0x1568 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_TIMER_1_CLKCTRL	(0x1570 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_TIMER_2_CLKCTRL	(0x1574 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_TIMER_3_CLKCTRL	(0x1578 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_TIMER_4_CLKCTRL	(0x157c - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_TIMER_5_CLKCTRL	(0x1580 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_TIMER_6_CLKCTRL	(0x1584 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_TIMER_7_CLKCTRL	(0x1588 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_WDTIMER_CLKCTRL	(0x158c - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_SPI_CLKCTRL	(0x1590 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_MAILBOX_CLKCTRL	(0x1594 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_SPINBOX_CLKCTRL	(0x1598 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_MMUDATA_CLKCTRL	(0x159c - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_MMUCFG_CLKCTRL	(0x15a8 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_SDIO_CLKCTRL	(0x15b0 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_OCMC_0_CLKCTRL	(0x15b4 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_OCMC_1_CLKCTRL	(0x15b8 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_CONTRL_CLKCTRL	(0x15c4 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_GPMC_CLKCTRL	(0x15d0 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_ETHERNET_0_CLKCTRL (0x15d4 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_ETHERNET_1_CLKCTRL (0x15d8 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_MPU_CLKCTRL	(0x15dc - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_L3_CLKCTRL	(0x15e4 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_L4HS_CLKCTRL	(0x15e8 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_L4LS_CLKCTRL	(0x15ec - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_RTC_CLKCTRL	(0x15f0 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_TPCC_CLKCTRL	(0x15f4 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_TPTC0_CLKCTRL	(0x15f8 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_TPTC1_CLKCTRL	(0x15fc - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_TPTC2_CLKCTRL	(0x1600 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_TPTC3_CLKCTRL	(0x1604 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_SR_0_CLKCTRL	(0x1608 - DM816X_DM_ALWON_BASE)
+#define DM816X_CM_ALWON_SR_1_CLKCTRL	(0x160c - DM816X_DM_ALWON_BASE)
+
+/*
+ * The default .clkctrl_offs field is offset from CM_DEFAULT, that's
+ * TRM 18.7.6 CM_DEFAULT device register values minus 0x500
+ */
+#define DM816X_CM_DEFAULT_OFFSET	0x500
+#define DM816X_CM_DEFAULT_USB_CLKCTRL	(0x558 - DM816X_CM_DEFAULT_OFFSET)
+
+/* L3 Interconnect entries clocked at 125, 250 and 500MHz */
+static struct omap_hwmod dm816x_alwon_l3_slow_hwmod = {
+	.name		= "alwon_l3_slow",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.class		= &l3_hwmod_class,
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+static struct omap_hwmod dm816x_default_l3_slow_hwmod = {
+	.name		= "default_l3_slow",
+	.clkdm_name	= "default_l3_slow_clkdm",
+	.class		= &l3_hwmod_class,
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+static struct omap_hwmod dm816x_alwon_l3_med_hwmod = {
+	.name		= "l3_med",
+	.clkdm_name	= "alwon_l3_med_clkdm",
+	.class		= &l3_hwmod_class,
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+static struct omap_hwmod dm816x_alwon_l3_fast_hwmod = {
+	.name		= "l3_fast",
+	.clkdm_name	= "alwon_l3_fast_clkdm",
+	.class		= &l3_hwmod_class,
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+/*
+ * L4 standard peripherals, see TRM table 1-12 for devices using this.
+ * See TRM table 1-73 for devices using the 125MHz SYSCLK6 clock.
+ */
+static struct omap_hwmod dm816x_l4_ls_hwmod = {
+	.name		= "l4_ls",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.class		= &l4_hwmod_class,
+};
+
+/*
+ * L4 high-speed peripherals. For devices using this, please see the TRM
+ * table 1-13. On dm816x, only EMAC, MDIO and SATA use this. See also TRM
+ * table 1-73 for devices using 250MHz SYSCLK5 clock.
+ */
+static struct omap_hwmod dm816x_l4_hs_hwmod = {
+	.name		= "l4_hs",
+	.clkdm_name	= "alwon_l3_med_clkdm",
+	.class		= &l4_hwmod_class,
+};
+
+/* L3 slow -> L4 ls peripheral interface running at 125MHz */
+static struct omap_hwmod_ocp_if dm816x_alwon_l3_slow__l4_ls = {
+	.master	= &dm816x_alwon_l3_slow_hwmod,
+	.slave	= &dm816x_l4_ls_hwmod,
+	.user	= OCP_USER_MPU,
+};
+
+/* L3 med -> L4 fast peripheral interface running at 250MHz */
+static struct omap_hwmod_ocp_if dm816x_alwon_l3_slow__l4_hs = {
+	.master	= &dm816x_alwon_l3_med_hwmod,
+	.slave	= &dm816x_l4_hs_hwmod,
+	.user	= OCP_USER_MPU,
+};
+
+/* MPU */
+static struct omap_hwmod dm816x_mpu_hwmod = {
+	.name		= "mpu",
+	.clkdm_name	= "alwon_mpu_clkdm",
+	.class		= &mpu_hwmod_class,
+	.flags		= HWMOD_INIT_NO_IDLE,
+	.main_clk	= "mpu_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_MPU_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_ocp_if dm816x_mpu__alwon_l3_slow = {
+	.master		= &dm816x_mpu_hwmod,
+	.slave		= &dm816x_alwon_l3_slow_hwmod,
+	.user		= OCP_USER_MPU,
+};
+
+/* L3 med peripheral interface running at 250MHz */
+static struct omap_hwmod_ocp_if dm816x_mpu__alwon_l3_med = {
+	.master	= &dm816x_mpu_hwmod,
+	.slave	= &dm816x_alwon_l3_med_hwmod,
+	.user	= OCP_USER_MPU,
+};
+
+/* UART common */
+static struct omap_hwmod_class_sysconfig uart_sysc = {
+	.rev_offs	= 0x50,
+	.sysc_offs	= 0x54,
+	.syss_offs	= 0x58,
+	.sysc_flags	= SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+				SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+				SYSS_HAS_RESET_STATUS,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+				MSTANDBY_SMART_WKUP,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class uart_class = {
+	.name = "uart",
+	.sysc = &uart_sysc,
+};
+
+static struct omap_hwmod dm816x_uart1_hwmod = {
+	.name		= "uart1",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "sysclk10_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_UART_0_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.class		= &uart_class,
+	.flags		= DEBUG_TI81XXUART1_FLAGS,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__uart1 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm816x_uart1_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod dm816x_uart2_hwmod = {
+	.name		= "uart2",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "sysclk10_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_UART_1_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.class		= &uart_class,
+	.flags		= DEBUG_TI81XXUART2_FLAGS,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__uart2 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm816x_uart2_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod dm816x_uart3_hwmod = {
+	.name		= "uart3",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "sysclk10_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_UART_2_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.class		= &uart_class,
+	.flags		= DEBUG_TI81XXUART3_FLAGS,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__uart3 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm816x_uart3_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_class_sysconfig wd_timer_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x10,
+	.syss_offs	= 0x14,
+	.sysc_flags	= SYSC_HAS_EMUFREE | SYSC_HAS_SOFTRESET |
+				SYSS_HAS_RESET_STATUS,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class wd_timer_class = {
+	.name		= "wd_timer",
+	.sysc		= &wd_timer_sysc,
+	.pre_shutdown	= &omap2_wd_timer_disable,
+	.reset		= &omap2_wd_timer_reset,
+};
+
+static struct omap_hwmod dm816x_wd_timer_hwmod = {
+	.name		= "wd_timer",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "sysclk18_ck",
+	.flags		= HWMOD_NO_IDLEST,
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_WDTIMER_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.class		= &wd_timer_class,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__wd_timer1 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm816x_wd_timer_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+/* I2C common */
+static struct omap_hwmod_class_sysconfig i2c_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x10,
+	.syss_offs	= 0x90,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE |
+				SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+				SYSC_HAS_AUTOIDLE,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class i2c_class = {
+	.name = "i2c",
+	.sysc = &i2c_sysc,
+};
+
+static struct omap_hwmod dm81xx_i2c1_hwmod = {
+	.name		= "i2c1",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "sysclk10_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_I2C_0_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.class		= &i2c_class,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__i2c1 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm81xx_i2c1_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod dm816x_i2c2_hwmod = {
+	.name		= "i2c2",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "sysclk10_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_I2C_1_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.class		= &i2c_class,
+};
+
+static struct omap_hwmod_class_sysconfig dm81xx_elm_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+				SYSC_HAS_SOFTRESET |
+				SYSS_HAS_RESET_STATUS,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__i2c2 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm816x_i2c2_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_class dm81xx_elm_hwmod_class = {
+	.name = "elm",
+	.sysc = &dm81xx_elm_sysc,
+};
+
+static struct omap_hwmod dm81xx_elm_hwmod = {
+	.name		= "elm",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.class		= &dm81xx_elm_hwmod_class,
+	.main_clk	= "sysclk6_ck",
+};
+
+static struct omap_hwmod_ocp_if dm81xx_l4_ls__elm = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm81xx_elm_hwmod,
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_class_sysconfig dm81xx_gpio_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0114,
+	.sysc_flags	= SYSC_HAS_AUTOIDLE | SYSC_HAS_ENAWAKEUP |
+				SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+				SYSS_HAS_RESET_STATUS,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+				SIDLE_SMART_WKUP,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class dm81xx_gpio_hwmod_class = {
+	.name	= "gpio",
+	.sysc	= &dm81xx_gpio_sysc,
+	.rev	= 2,
+};
+
+static struct omap_gpio_dev_attr gpio_dev_attr = {
+	.bank_width	= 32,
+	.dbck_flag	= true,
+};
+
+static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
+	{ .role = "dbclk", .clk = "sysclk18_ck" },
+};
+
+static struct omap_hwmod dm81xx_gpio1_hwmod = {
+	.name		= "gpio1",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.class		= &dm81xx_gpio_hwmod_class,
+	.main_clk	= "sysclk6_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_GPIO_0_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= gpio1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+};
+
+static struct omap_hwmod_ocp_if dm81xx_l4_ls__gpio1 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm81xx_gpio1_hwmod,
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
+	{ .role = "dbclk", .clk = "sysclk18_ck" },
+};
+
+static struct omap_hwmod dm81xx_gpio2_hwmod = {
+	.name		= "gpio2",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.class		= &dm81xx_gpio_hwmod_class,
+	.main_clk	= "sysclk6_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_GPIO_1_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= gpio2_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio2_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+};
+
+static struct omap_hwmod_ocp_if dm81xx_l4_ls__gpio2 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm81xx_gpio2_hwmod,
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_class_sysconfig dm81xx_gpmc_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x10,
+	.syss_offs	= 0x14,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+				SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class dm81xx_gpmc_hwmod_class = {
+	.name	= "gpmc",
+	.sysc	= &dm81xx_gpmc_sysc,
+};
+
+static struct omap_hwmod dm81xx_gpmc_hwmod = {
+	.name		= "gpmc",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.class		= &dm81xx_gpmc_hwmod_class,
+	.main_clk	= "sysclk6_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_GPMC_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+struct omap_hwmod_ocp_if dm81xx_alwon_l3_slow__gpmc = {
+	.master		= &dm816x_alwon_l3_slow_hwmod,
+	.slave		= &dm81xx_gpmc_hwmod,
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_class_sysconfig dm81xx_usbhsotg_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x10,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
+				SYSC_HAS_SOFTRESET,
+	.idlemodes	= SIDLE_SMART | MSTANDBY_FORCE | MSTANDBY_SMART,
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class dm81xx_usbotg_class = {
+	.name = "usbotg",
+	.sysc = &dm81xx_usbhsotg_sysc,
+};
+
+static struct omap_hwmod dm81xx_usbss_hwmod = {
+	.name		= "usb_otg_hs",
+	.clkdm_name	= "default_l3_slow_clkdm",
+	.main_clk	= "sysclk6_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_DEFAULT_USB_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.class		= &dm81xx_usbotg_class,
+};
+
+static struct omap_hwmod_ocp_if dm81xx_default_l3_slow__usbss = {
+	.master		= &dm816x_default_l3_slow_hwmod,
+	.slave		= &dm81xx_usbss_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_class_sysconfig dm816x_timer_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+				SIDLE_SMART_WKUP,
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class dm816x_timer_hwmod_class = {
+	.name = "timer",
+	.sysc = &dm816x_timer_sysc,
+};
+
+static struct omap_timer_capability_dev_attr capability_alwon_dev_attr = {
+	.timer_capability	= OMAP_TIMER_ALWON,
+};
+
+static struct omap_hwmod dm816x_timer1_hwmod = {
+	.name		= "timer1",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "timer1_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_TIMER_1_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &dm816x_timer_hwmod_class,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__timer1 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm816x_timer1_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod dm816x_timer2_hwmod = {
+	.name		= "timer2",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "timer2_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_TIMER_2_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &dm816x_timer_hwmod_class,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__timer2 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm816x_timer2_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod dm816x_timer3_hwmod = {
+	.name		= "timer3",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "timer3_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_TIMER_3_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &dm816x_timer_hwmod_class,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__timer3 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm816x_timer3_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod dm816x_timer4_hwmod = {
+	.name		= "timer4",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "timer4_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_TIMER_4_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &dm816x_timer_hwmod_class,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__timer4 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm816x_timer4_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod dm816x_timer5_hwmod = {
+	.name		= "timer5",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "timer5_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_TIMER_5_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &dm816x_timer_hwmod_class,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__timer5 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm816x_timer5_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod dm816x_timer6_hwmod = {
+	.name		= "timer6",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "timer6_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_TIMER_6_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &dm816x_timer_hwmod_class,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__timer6 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm816x_timer6_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod dm816x_timer7_hwmod = {
+	.name		= "timer7",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "timer7_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_TIMER_7_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &dm816x_timer_hwmod_class,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__timer7 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm816x_timer7_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+/* EMAC Ethernet */
+static struct omap_hwmod_class_sysconfig dm816x_emac_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x4,
+	.sysc_flags	= SYSC_HAS_SOFTRESET,
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class dm816x_emac_hwmod_class = {
+	.name		= "emac",
+	.sysc		= &dm816x_emac_sysc,
+};
+
+/*
+ * On dm816x the MDIO is within EMAC0. As the MDIO driver is a separate
+ * driver probed before EMAC0, we let MDIO do the clock idling.
+ */
+static struct omap_hwmod dm816x_emac0_hwmod = {
+	.name		= "emac0",
+	.clkdm_name	= "alwon_ethernet_clkdm",
+	.class		= &dm816x_emac_hwmod_class,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_hs__emac0 = {
+	.master		= &dm816x_l4_hs_hwmod,
+	.slave		= &dm816x_emac0_hwmod,
+	.clk		= "sysclk5_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_class dm816x_mdio_hwmod_class = {
+	.name		= "davinci_mdio",
+	.sysc		= &dm816x_emac_sysc,
+};
+
+struct omap_hwmod dm816x_emac0_mdio_hwmod = {
+	.name		= "davinci_mdio",
+	.class		= &dm816x_mdio_hwmod_class,
+	.clkdm_name	= "alwon_ethernet_clkdm",
+	.main_clk	= "sysclk24_ck",
+	.flags		= HWMOD_NO_IDLEST,
+	/*
+	 * REVISIT: This should be moved to the emac0_hwmod
+	 * once we have a better way to handle device slaves.
+	 */
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_ETHERNET_0_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+struct omap_hwmod_ocp_if dm816x_emac0__mdio = {
+	.master		= &dm816x_l4_hs_hwmod,
+	.slave		= &dm816x_emac0_mdio_hwmod,
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod dm816x_emac1_hwmod = {
+	.name		= "emac1",
+	.clkdm_name	= "alwon_ethernet_clkdm",
+	.main_clk	= "sysclk24_ck",
+	.flags		= HWMOD_NO_IDLEST,
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_ETHERNET_1_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.class		= &dm816x_emac_hwmod_class,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_hs__emac1 = {
+	.master		= &dm816x_l4_hs_hwmod,
+	.slave		= &dm816x_emac1_hwmod,
+	.clk		= "sysclk5_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_class_sysconfig dm816x_mmc_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x110,
+	.syss_offs	= 0x114,
+	.sysc_flags	= SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+				SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+				SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class dm816x_mmc_class = {
+	.name = "mmc",
+	.sysc = &dm816x_mmc_sysc,
+};
+
+static struct omap_hwmod_opt_clk dm816x_mmc1_opt_clks[] = {
+	{ .role = "dbck", .clk = "sysclk18_ck", },
+};
+
+static struct omap_hsmmc_dev_attr mmc1_dev_attr = {
+	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
+};
+
+static struct omap_hwmod dm816x_mmc1_hwmod = {
+	.name		= "mmc1",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.opt_clks	= dm816x_mmc1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dm816x_mmc1_opt_clks),
+	.main_clk	= "sysclk10_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_SDIO_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.dev_attr	= &mmc1_dev_attr,
+	.class		= &dm816x_mmc_class,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__mmc1 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm816x_mmc1_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+	.flags		= OMAP_FIREWALL_L4
+};
+
+static struct omap_hwmod_class_sysconfig dm816x_mcspi_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x110,
+	.syss_offs	= 0x114,
+	.sysc_flags	= SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+				SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+				SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class dm816x_mcspi_class = {
+	.name = "mcspi",
+	.sysc = &dm816x_mcspi_sysc,
+	.rev = OMAP3_MCSPI_REV,
+};
+
+static struct omap2_mcspi_dev_attr dm816x_mcspi1_dev_attr = {
+	.num_chipselect = 4,
+};
+
+static struct omap_hwmod dm816x_mcspi1_hwmod = {
+	.name		= "mcspi1",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "sysclk10_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_SPI_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.class		= &dm816x_mcspi_class,
+	.dev_attr	= &dm816x_mcspi1_dev_attr,
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__mcspi1 = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm816x_mcspi1_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_class_sysconfig dm816x_mailbox_sysc = {
+	.rev_offs	= 0x000,
+	.sysc_offs	= 0x010,
+	.syss_offs	= 0x014,
+	.sysc_flags	= SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+				SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class dm816x_mailbox_hwmod_class = {
+	.name = "mailbox",
+	.sysc = &dm816x_mailbox_sysc,
+};
+
+static struct omap_hwmod dm816x_mailbox_hwmod = {
+	.name		= "mailbox",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.class		= &dm816x_mailbox_hwmod_class,
+	.main_clk	= "sysclk6_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM816X_CM_ALWON_MAILBOX_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_ocp_if dm816x_l4_ls__mailbox = {
+	.master		= &dm816x_l4_ls_hwmod,
+	.slave		= &dm816x_mailbox_hwmod,
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_class dm816x_tpcc_hwmod_class = {
+	.name		= "tpcc",
+};
+
+struct omap_hwmod dm816x_tpcc_hwmod = {
+	.name		= "tpcc",
+	.class		= &dm816x_tpcc_hwmod_class,
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "sysclk4_ck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= DM816X_CM_ALWON_TPCC_CLKCTRL,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tpcc = {
+	.master		= &dm816x_alwon_l3_fast_hwmod,
+	.slave		= &dm816x_tpcc_hwmod,
+	.clk		= "sysclk4_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space dm816x_tptc0_addr_space[] = {
+	{
+		.pa_start	= 0x49800000,
+		.pa_end		= 0x49800000 + SZ_8K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ },
+};
+
+static struct omap_hwmod_class dm816x_tptc0_hwmod_class = {
+	.name		= "tptc0",
+};
+
+struct omap_hwmod dm816x_tptc0_hwmod = {
+	.name		= "tptc0",
+	.class		= &dm816x_tptc0_hwmod_class,
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "sysclk4_ck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= DM816X_CM_ALWON_TPTC0_CLKCTRL,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc0 = {
+	.master		= &dm816x_alwon_l3_fast_hwmod,
+	.slave		= &dm816x_tptc0_hwmod,
+	.clk		= "sysclk4_ck",
+	.addr		= dm816x_tptc0_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if dm816x_tptc0__alwon_l3_fast = {
+	.master		= &dm816x_tptc0_hwmod,
+	.slave		= &dm816x_alwon_l3_fast_hwmod,
+	.clk		= "sysclk4_ck",
+	.addr		= dm816x_tptc0_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space dm816x_tptc1_addr_space[] = {
+	{
+		.pa_start	= 0x49900000,
+		.pa_end		= 0x49900000 + SZ_8K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ },
+};
+
+static struct omap_hwmod_class dm816x_tptc1_hwmod_class = {
+	.name		= "tptc1",
+};
+
+struct omap_hwmod dm816x_tptc1_hwmod = {
+	.name		= "tptc1",
+	.class		= &dm816x_tptc1_hwmod_class,
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "sysclk4_ck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= DM816X_CM_ALWON_TPTC1_CLKCTRL,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc1 = {
+	.master		= &dm816x_alwon_l3_fast_hwmod,
+	.slave		= &dm816x_tptc1_hwmod,
+	.clk		= "sysclk4_ck",
+	.addr		= dm816x_tptc1_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if dm816x_tptc1__alwon_l3_fast = {
+	.master		= &dm816x_tptc1_hwmod,
+	.slave		= &dm816x_alwon_l3_fast_hwmod,
+	.clk		= "sysclk4_ck",
+	.addr		= dm816x_tptc1_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space dm816x_tptc2_addr_space[] = {
+	{
+		.pa_start	= 0x49a00000,
+		.pa_end		= 0x49a00000 + SZ_8K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ },
+};
+
+static struct omap_hwmod_class dm816x_tptc2_hwmod_class = {
+	.name		= "tptc2",
+};
+
+struct omap_hwmod dm816x_tptc2_hwmod = {
+	.name		= "tptc2",
+	.class		= &dm816x_tptc2_hwmod_class,
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "sysclk4_ck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= DM816X_CM_ALWON_TPTC2_CLKCTRL,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc2 = {
+	.master		= &dm816x_alwon_l3_fast_hwmod,
+	.slave		= &dm816x_tptc2_hwmod,
+	.clk		= "sysclk4_ck",
+	.addr		= dm816x_tptc2_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if dm816x_tptc2__alwon_l3_fast = {
+	.master		= &dm816x_tptc2_hwmod,
+	.slave		= &dm816x_alwon_l3_fast_hwmod,
+	.clk		= "sysclk4_ck",
+	.addr		= dm816x_tptc2_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space dm816x_tptc3_addr_space[] = {
+	{
+		.pa_start	= 0x49b00000,
+		.pa_end		= 0x49b00000 + SZ_8K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ },
+};
+
+static struct omap_hwmod_class dm816x_tptc3_hwmod_class = {
+	.name		= "tptc3",
+};
+
+struct omap_hwmod dm816x_tptc3_hwmod = {
+	.name		= "tptc3",
+	.class		= &dm816x_tptc3_hwmod_class,
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "sysclk4_ck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= DM816X_CM_ALWON_TPTC3_CLKCTRL,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc3 = {
+	.master		= &dm816x_alwon_l3_fast_hwmod,
+	.slave		= &dm816x_tptc3_hwmod,
+	.clk		= "sysclk4_ck",
+	.addr		= dm816x_tptc3_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if dm816x_tptc3__alwon_l3_fast = {
+	.master		= &dm816x_tptc3_hwmod,
+	.slave		= &dm816x_alwon_l3_fast_hwmod,
+	.clk		= "sysclk4_ck",
+	.addr		= dm816x_tptc3_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if *dm816x_hwmod_ocp_ifs[] __initdata = {
+	&dm816x_mpu__alwon_l3_slow,
+	&dm816x_mpu__alwon_l3_med,
+	&dm816x_alwon_l3_slow__l4_ls,
+	&dm816x_alwon_l3_slow__l4_hs,
+	&dm816x_l4_ls__uart1,
+	&dm816x_l4_ls__uart2,
+	&dm816x_l4_ls__uart3,
+	&dm816x_l4_ls__wd_timer1,
+	&dm816x_l4_ls__i2c1,
+	&dm816x_l4_ls__i2c2,
+	&dm81xx_l4_ls__gpio1,
+	&dm81xx_l4_ls__gpio2,
+	&dm81xx_l4_ls__elm,
+	&dm816x_l4_ls__mmc1,
+	&dm816x_l4_ls__timer1,
+	&dm816x_l4_ls__timer2,
+	&dm816x_l4_ls__timer3,
+	&dm816x_l4_ls__timer4,
+	&dm816x_l4_ls__timer5,
+	&dm816x_l4_ls__timer6,
+	&dm816x_l4_ls__timer7,
+	&dm816x_l4_ls__mcspi1,
+	&dm816x_l4_ls__mailbox,
+	&dm816x_l4_hs__emac0,
+	&dm816x_emac0__mdio,
+	&dm816x_l4_hs__emac1,
+	&dm816x_alwon_l3_fast__tpcc,
+	&dm816x_alwon_l3_fast__tptc0,
+	&dm816x_alwon_l3_fast__tptc1,
+	&dm816x_alwon_l3_fast__tptc2,
+	&dm816x_alwon_l3_fast__tptc3,
+	&dm816x_tptc0__alwon_l3_fast,
+	&dm816x_tptc1__alwon_l3_fast,
+	&dm816x_tptc2__alwon_l3_fast,
+	&dm816x_tptc3__alwon_l3_fast,
+	&dm81xx_alwon_l3_slow__gpmc,
+	&dm81xx_default_l3_slow__usbss,
+	NULL,
+};
+
+int __init ti81xx_hwmod_init(void)
+{
+	omap_hwmod_init();
+	return omap_hwmod_register_links(dm816x_hwmod_ocp_ifs);
+}
