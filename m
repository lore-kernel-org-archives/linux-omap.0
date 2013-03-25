From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] ARM: AM33XX: Add missing .clkdm_name to clkdiv32k_ick clock
Date: Mon, 25 Mar 2013 17:07:23 +0530
Message-ID: <1364211443-27536-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45300 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756296Ab3CYLhq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Mar 2013 07:37:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

During common-clock migration, .clkdm_name field got missed
for "clkdiv32k_ick" clock, which leaves "clk_24mhz_clkdm"
unused; so boot process will try to disable the clockdomain
even childs of this clock is enabled, which keeps child modules
in idle mode.

This fixes the kernel crash observed on AM335xEVM-Sk platform,
where clkdiv32_ick clock is being used as a gpio debounce clock
and since clkdiv32k_ick is in idle mode it leads to below crash -

Crash Log:
=============
[    2.598347] Unhandled fault: external abort on non-linefetch (0x1028) at
0xfa1ac150
[    2.606434] Internal error: : 1028 [#1] SMP ARM
[    2.611207] Modules linked in:
[    2.614449] CPU: 0    Not tainted  (3.8.4-01382-g1f449cd-dirty #4)
[    2.620973] PC is at _set_gpio_debounce+0x60/0x104
[    2.626025] LR is at clk_enable+0x30/0x3c
[    2.630249] pc : [<c02e2850>]    lr : [<c0449ad8>]    psr: 60000193
[    2.630249] sp : cf053df8  ip : 00000001  fp : cf19e000
[    2.642308] r10: cdc56800  r9 : cf19e010  r8 : cf0b8410
[    2.647802] r7 : 00000002  r6 : 00000004  r5 : 000000a0  r4 : cf0b8410
[    2.654668] r3 : fa1ac150  r2 : fa1ac000  r1 : 00000000  r0 : 00000000
[    2.661540] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
	Segment kernel
[    2.669324] Control: 10c5387d  Table: 80004019  DAC: 00000017
[    2.675372] Process swapper/0 (pid: 1, stack limit = 0xcf052240)
[    2.681688] Stack: (0xcf053df8 to 0xcf054000)
[    2.686279] 3de0: cf0b846c 20000113
[    2.694892] 3e00: 00001388 c02e2924 00000000 00000002 cf0b848c
	20000113 00001388 c02e0258
[    2.703508] 3e20: cdc57ce8 cdca2784 c00028d8 00000000 cdc56800
	c040ba10 cdc57c50 c08374e0
[    2.712115] 3e40: 00000001 00000028 cdca2784 cdca2740 cdc57c00
	00000000 cdc56800 c040bc58
[    2.720727] 3e60: cf1a0bd0 cf19e010 c08374e0 c0d96ffc c08374e0
	cf19e010 00000000 c08374e0
[    2.729341] 3e80: c076c7b0 c07421c4 00000000 c0331c90 c0331c78
	c033092c cf19e010 c08374e0
[    2.737957] 3ea0: cf19e044 00000000 00000000 c0330bd8 00000000
	cf19e010 c08374e0 c0330c84
[    2.746573] 3ec0: c08374e0 c0330bf0 00000000 c032f2f8 cf0222a8
	cf198a10 c08374e0 c08265c8
[    2.755185] 3ee0: cdbca7c0 c033015c c067d1e0 c08374e0 c08374e0
	c0844600 cf052000 00000000
[    2.763793] 3f00: 00000000 c03311b8 00000000 c0776fb0 c0844600
	cf052000 00000000 00000000
[    2.772393] 3f20: c07421c4 c0008818 0001dd4e 00000000 00000007
	c076c7b0 07753841 00000000
[    2.780998] 3f40: 9a64d806 00000000 9a64d806 00000000 60000113
	c0776fb0 00000007 c0776f90
[    2.789603] 3f60: c0844600 000000af c0793ee8 c07421c4 00000000
	c07428f8 00000007 00000007
[    2.798217] 3f80: c07421c4 00000000 00000000 c0513f0c 00000000
	00000000 00000000 00000000
[    2.806827] 3fa0: 00000000 c0513f14 00000000 c0013490 00000000
	00000000 00000000 00000000
[    2.815447] 3fc0: 00000000 00000000 00000000 00000000 00000000
	00000000 00000000 00000000
[    2.824058] 3fe0: 00000000 00000000 00000000 00000000 00000013
	00000000 eebff7f9 3a5f1b7e
[    2.832668] [<c02e2850>] (_set_gpio_debounce+0x60/0x104) from
	[<c02e2924>] (gpio_debounce+0x30/0x44)
[    2.842272] [<c02e2924>] (gpio_debounce+0x30/0x44) from [<c02e0258>]
	(gpio_set_debounce+0xc4/0xdc)
[    2.851714] [<c02e0258>] (gpio_set_debounce+0xc4/0xdc) from
	[<c040ba10>] (gpio_keys_setup_key+0x190/0x268)
[    2.861871] [<c040ba10>] (gpio_keys_setup_key+0x190/0x268) from
	[<c040bc58>] (gpio_keys_probe+0x170/0x274)
[    2.872046] [<c040bc58>] (gpio_keys_probe+0x170/0x274) from
	[<c0331c90>] (platform_drv_probe+0x18/0x1c)
[    2.881940] [<c0331c90>] (platform_drv_probe+0x18/0x1c) from
	[<c033092c>] (really_probe+0x60/0x1f4)
[    2.891453] [<c033092c>] (really_probe+0x60/0x1f4) from [<c0330bd8>]
	(driver_probe_device+0x30/0x48)
[    2.901064] [<c0330bd8>] (driver_probe_device+0x30/0x48) from
	[<c0330c84>] (__driver_attach+0x94/0x98)
[    2.910858] [<c0330c84>] (__driver_attach+0x94/0x98) from
	[<c032f2f8>] (bus_for_each_dev+0x64/0x88)
[    2.920380] [<c032f2f8>] (bus_for_each_dev+0x64/0x88) from
	[<c033015c>] (bus_add_driver+0xa0/0x240)
[    2.929900] [<c033015c>] (bus_add_driver+0xa0/0x240) from
	[<c03311b8>] (driver_register+0x78/0x144)
[    2.939434] [<c03311b8>] (driver_register+0x78/0x144) from
	[<c0008818>] (do_one_initcall+0x118/0x180)
[    2.949160] [<c0008818>] (do_one_initcall+0x118/0x180) from
	[<c07428f8>] (kernel_init_freeable+0xfc/0x1cc)
[    2.959343] [<c07428f8>] (kernel_init_freeable+0xfc/0x1cc) from
	[<c0513f14>] (kernel_init+0x8/0xe4)
[    2.968867] [<c0513f14>] (kernel_init+0x8/0xe4) from [<c0013490>]
	(ret_from_fork+0x14/0x24)
[    2.977663] Code: e5943108 e5942008 e1d331be e0823003 (e5932000)
	[    2.984092] ---[ end trace d1c5f252789a330b ]---
[    2.989241] Kernel panic - not syncing: Attempted to kill init!
	exitcode=0x0000000b
[    2.989241]

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cclock33xx_data.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index e674e01..b8fd346 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -449,9 +449,29 @@ DEFINE_CLK_GATE(cefuse_fck, "sys_clkin_ck", &sys_clkin_ck, 0x0,
  */
 DEFINE_CLK_FIXED_FACTOR(clkdiv32k_ck, "clk_24mhz", &clk_24mhz, 0x0, 1, 732);

-DEFINE_CLK_GATE(clkdiv32k_ick, "clkdiv32k_ck", &clkdiv32k_ck, 0x0,
-		AM33XX_CM_PER_CLKDIV32K_CLKCTRL, AM33XX_MODULEMODE_SWCTRL_SHIFT,
-		0x0, NULL);
+static struct clk clkdiv32k_ick;
+
+static const char *clkdiv32k_ick_parent_names[] = {
+	"clkdiv32k_ck",
+};
+
+static const struct clk_ops clkdiv32k_ick_ops = {
+	.enable         = &omap2_dflt_clk_enable,
+	.disable        = &omap2_dflt_clk_disable,
+	.is_enabled     = &omap2_dflt_clk_is_enabled,
+	.init           = &omap2_init_clk_clkdm,
+};
+
+static struct clk_hw_omap clkdiv32k_ick_hw = {
+	.hw	= {
+		.clk	= &clkdiv32k_ick,
+	},
+	.enable_reg	= AM33XX_CM_PER_CLKDIV32K_CLKCTRL,
+	.enable_bit	= AM33XX_MODULEMODE_SWCTRL_SHIFT,
+	.clkdm_name	= "clk_24mhz_clkdm",
+};
+
+DEFINE_STRUCT_CLK(clkdiv32k_ick, clkdiv32k_ick_parent_names, clkdiv32k_ick_ops);

 /* "usbotg_fck" is an additional clock and not really a modulemode */
 DEFINE_CLK_GATE(usbotg_fck, "dpll_per_ck", &dpll_per_ck, 0x0,
--
1.7.0.4

