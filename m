From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm, omap2, sram: On HS/EMU devices, only 64K internal
 SRAM is available.
Date: Wed, 14 Oct 2015 16:54:54 -0700
Message-ID: <20151014235453.GD10033@atomide.com>
References: <1444715655-30077-1-git-send-email-hs@denx.de>
 <20151014174920.GE10113@atomide.com>
 <20151014222022.GL10113@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151014222022.GL10113@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Schocher <hs@denx.de>
Cc: Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Georg.Soffel@bosch-si.com, Ayoub Zaki <Ayoub.Zaki@bosch-si.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [151014 15:27]:
> * Tony Lindgren <tony@atomide.com> [151014 10:56]:
> > * Heiko Schocher <hs@denx.de> [151012 22:58]:
> > > Of this, secure content (including PPA) uses initial
> > > portion of the SRAM. This chunk is not (and shouldn't
> > > be) accessible from the public code.
> > > 
> > > The minimum size of this chunk (0x350) is used in this
> > > patch. Available size is rounded off to 63K.
> > > 
> > > Both values would require a change if size of secure
> > > content grows beyond 0x350.
> > 
> > Makes sense to me. And something similar is needed at least for
> > dm814x to get rid of the imprecise abort during boot with
> > commit bbeb92095159 ("ARM: 8422/1: enable imprecise aborts during
> > early kernel startup") applied.
> >
> > Is this needed as a fix to the -rc cycle, or can this wait for
> > v4.4?
> 
> Actually I think we may have a regression somwhere. If you look
> at commit 8b9a2810b02e ("ARM: OMAP4+: Move SRAM data to DT")
> this should all be handled by drivers/misc/sram.c nowadays.
> 
> So for most SoCs, we should completely skip the plat-omap/sram.c
> code.

I wonder if the following is enough to fix the issue for you?

This fixes the dm814x imprecise external abort issue on dm814x.

Regards,

Tony

8< -----------------
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 14 Oct 2015 16:09:29 -0700
Subject: [PATCH] ARM: OMAP2+: Fix imprecise external abort caused by bogus
 SRAM init

Some omaps are producing imprecise external aborts because we are
wrongly trying to init SRAM for device tree based booting. Only
omap3 is still using the legacy SRAM code, so we need to make it
omap3 specific. Otherwise we can get errors like this on at least
dm814x:

Unhandled fault: imprecise external abort (0xc06) at 0xc08b156c
pgd = c0004000
[c08b156c] *pgd=8080040e(bad)
Internal error: : c06 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.3.0-rc5-00001-g3b6348b #1672
Hardware name: Generic ti814x (Flattened Device Tree)
task: ee08ed40 ti: ee090000 task.ti: ee090000
PC is at omap_rev+0x0/0x10
LR is at omap_sram_init+0xf8/0x3e0
pc : [<c00259c8>]    lr : [<c08b12e0>]    psr: 60000013
sp : ee091eb0  ip : f004a800  fp : 00000099
r10: c08f1858  r9 : 00000000  r8 : c08a57c4
r7 : c09d0000  r6 : ee0e8980  r5 : 00000000  r4 : c09d08dc
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : f004a000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 80004019  DAC: 00000051
Process swapper/0 (pid: 1, stack limit = 0xee090218)
Stack: (0xee091eb0 to 0xee092000)
1ea0:                                     c08efa48 00000000 00000000 ee0e8980
1ec0: c09d0000 c08aca0c c08efa48 c08faf44 c0904844 c08b581c c08efa48 c091a3b0
1ee0: c091a3b0 c08b5478 c08efa48 c08a57e0 00000000 c00098a4 ee08ed40 c0951e2c
1f00: ee08f280 00000000 ee08ed00 00000004 00000006 00000000 ef7fcb3d c066c6b8
1f20: 00000099 c005eba0 00000001 00000000 c086e2b4 ef7fcb51 00000003 00000003
1f40: c090ab00 c090ac0c c090ac14 00000003 c09d0000 c09d0000 c08f1840 00000000
1f60: c08f1858 c08a2ec4 00000003 00000003 00000000 c08a2594 ffffffff 00000000
1f80: c063a54c 00000000 c063a54c 00000000 00000000 00000000 00000000 00000000
1fa0: 00000000 c063a554 00000000 c000f890 00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
[<c00259c8>] (omap_rev) from [<c08b12e0>] (omap_sram_init+0xf8/0x3e0)
[<c08b12e0>] (omap_sram_init) from [<c08aca0c>] (omap_sdrc_init+0x10/0xb0)
[<c08aca0c>] (omap_sdrc_init) from [<c08b581c>] (pdata_quirks_init+0x18/0x44)
[<c08b581c>] (pdata_quirks_init) from [<c08b5478>] (omap_generic_init+0x10/0x1c)
[<c08b5478>] (omap_generic_init) from [<c08a57e0>] (customize_machine+0x1c/0x40)
[<c08a57e0>] (customize_machine) from [<c00098a4>] (do_one_initcall+0x80/0x1dc)
[<c00098a4>] (do_one_initcall) from [<c08a2ec4>] (kernel_init_freeable+0x218/0x2e8)
[<c08a2ec4>] (kernel_init_freeable) from [<c063a554>] (kernel_init+0x8/0xec)
[<c063a554>] (kernel_init) from [<c000f890>] (ret_from_fork+0x14/0x24)
Code: e3a03000 e5843064 e8bd8010 c0959e3c (e59f3004)

Let's fix the issue by making sure omap_sdrc_init only gets called for
omap3. To do that, we need to have compatible "ti,omap3" in the dts
files. And let's also use "ti,omap3630" instead of "ti,omap36xx" like
we're supposed to.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
@@ -12,7 +12,7 @@
 
 / {
 	model = "LogicPD Zoom DM3730 Torpedo Development Kit";
-	compatible = "logicpd,dm3730-torpedo-devkit", "ti,omap36xx";
+	compatible = "logicpd,dm3730-torpedo-devkit", "ti,omap3630", "ti,omap3";
 
 	gpio_keys {
 		compatible = "gpio-keys";
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "TI OMAP37XX EVM (TMDSEVM3730)";
-	compatible = "ti,omap3-evm-37xx", "ti,omap36xx";
+	compatible = "ti,omap3-evm-37xx", "ti,omap3630", "ti,omap3";
 
 	memory {
 		device_type = "memory";
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -106,6 +106,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 MACHINE_END
 
 static const char *const omap36xx_boards_compat[] __initconst = {
+	"ti,omap3630",
 	"ti,omap36xx",
 	NULL,
 };
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -530,7 +530,14 @@ static void pdata_quirks_check(struct pdata_init *quirks)
 
 void __init pdata_quirks_init(const struct of_device_id *omap_dt_match_table)
 {
-	omap_sdrc_init(NULL, NULL);
+	/*
+	 * We still need this for omap2420 and omap3 PM to work, others are
+	 * using drivers/misc/sram.c already.
+	 */
+	if (of_machine_is_compatible("ti,omap2420") ||
+	    of_machine_is_compatible("ti,omap3"))
+		omap_sdrc_init(NULL, NULL);
+
 	pdata_quirks_check(auxdata_quirks);
 	of_platform_populate(NULL, omap_dt_match_table,
 			     omap_auxdata_lookup, NULL);
