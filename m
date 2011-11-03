From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH] ARM: OMAP: Fix build for OMAP3 only builds
Date: Thu, 3 Nov 2011 11:30:02 -0700
Message-ID: <20111103183001.GU31337@atomide.com>
References: <1318421036-1498-1-git-send-email-weber@corscience.de>
 <B85A65D85D7EB246BE421B3FB0FBB5930328C7C406@dbde02.ent.ti.com>
 <4EB1398B.80901@gmail.com>
 <20111102171605.GK31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29090 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756447Ab1KCSaG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 14:30:06 -0400
Content-Disposition: inline
In-Reply-To: <20111102171605.GK31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <thomas.weber.linux@googlemail.com>
Cc: "Nori, Sekhar" <nsekhar@ti.com>, Thomas Weber <weber@corscience.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

* Tony Lindgren <tony@atomide.com> [111102 09:41]:
> * Thomas Weber <thomas.weber.linux@googlemail.com> [111102 04:03]:
> > Am 27.10.2011 07:32, schrieb Nori, Sekhar:
> > > On Wed, Oct 12, 2011 at 17:33:56, Thomas Weber wrote:
> > >> When building for OMAP3 only I get the
> > >> following errors:
...

> > > I was facing the same problem and this patch helped
> > > me get rid of it.
> > > 
> > > Tested-by: Sekhar Nori <nsekhar@ti.com>
> > 
> > Hello Tony,
> > 
> > what is the status of this patch?
> > 
> > There is also another patch fixing the same problem.
> > 
> > [PATCH v2] arm: omap: Fix errors and warnings when building for one board
> 
> Well looks like we got the initial DT changes merged! Only two
> minor patches needed for compile errors that I just posted.
> 
> Will take a look at this and other fixes needed to fixes-part2
> next.

Considering we now have the DT branch merged, I'll apply the earlier
patch from Sanjeev with a minor modification to avoid a build
warning in board-generic.c.

Updated patch below, Sekhar & Thomas, care to ack?

Regards,

Tony


From: Sanjeev Premi <premi@ti.com>
Date: Thu, 13 Oct 2011 21:44:10 +0530
Subject: [PATCH] ARM: OMAP: Fix errors and warnings when building for one board

When customizing omap2plus_defconfig to build for only
one board (omap3evm), I came across these warnings and
errors (filenames truncated):

arch/arm/mach-omap2/board-generic.c:76:20: warning: 'omap4_init' defined but not used
arch/arm/mach-omap2/built-in.o: In function `omap2420_init_early':
arch/arm/mach-omap2/io.c:364: undefined reference to `omap2_set_globals_242x'
arch/arm/mach-omap2/io.c:366: undefined reference to `omap2xxx_voltagedomains_init'
arch/arm/mach-omap2/io.c:367: undefined reference to `omap242x_powerdomains_init'
arch/arm/mach-omap2/io.c:368: undefined reference to `omap242x_clockdomains_init'
arch/arm/mach-omap2/io.c:369: undefined reference to `omap2420_hwmod_init'
arch/arm/mach-omap2/built-in.o: In function `omap2430_init_early':
arch/arm/mach-omap2/io.c:376: undefined reference to `omap2_set_globals_243x'
arch/arm/mach-omap2/io.c:378: undefined reference to `omap2xxx_voltagedomains_init'
arch/arm/mach-omap2/io.c:379: undefined reference to `omap243x_powerdomains_init'
arch/arm/mach-omap2/io.c:380: undefined reference to `omap243x_clockdomains_init'
arch/arm/mach-omap2/io.c:381: undefined reference to `omap2430_hwmod_init'
arch/arm/mach-omap2/built-in.o: In function `omap4430_init_early':
arch/arm/mach-omap2/io.c:436: undefined reference to `omap2_set_globals_443x'
arch/arm/mach-omap2/io.c:438: undefined reference to `omap44xx_voltagedomains_init'
arch/arm/mach-omap2/io.c:439: undefined reference to `omap44xx_powerdomains_init'
arch/arm/mach-omap2/io.c:440: undefined reference to `omap44xx_clockdomains_init'
arch/arm/mach-omap2/io.c:441: undefined reference to `omap44xx_hwmod_init'

This patch fixes them.

Signed-off-by: Sanjeev Premi <premi@ti.com>
[tony@atomide.com: updated to fix warnings for board-generic.c]
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -28,6 +28,7 @@
  * XXX: Still needed to boot until the i2c & twl driver is adapted to
  * device-tree
  */
+#ifdef CONFIG_ARCH_OMAP4
 static struct twl4030_platform_data sdp4430_twldata = {
 	.irq_base	= TWL6030_IRQ_BASE,
 	.irq_end	= TWL6030_IRQ_END,
@@ -37,7 +38,9 @@ static void __init omap4_i2c_init(void)
 {
 	omap4_pmic_init("twl6030", &sdp4430_twldata);
 }
+#endif
 
+#ifdef CONFIG_ARCH_OMAP3
 static struct twl4030_platform_data beagle_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -47,6 +50,7 @@ static void __init omap3_i2c_init(void)
 {
 	omap3_pmic_init("twl4030", &beagle_twldata);
 }
+#endif
 
 static struct of_device_id omap_dt_match_table[] __initdata = {
 	{ .compatible = "simple-bus", },
@@ -72,17 +76,21 @@ static void __init omap_generic_init(void)
 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
 }
 
+#ifdef CONFIG_ARCH_OMAP4
 static void __init omap4_init(void)
 {
 	omap4_i2c_init();
 	omap_generic_init();
 }
+#endif
 
+#ifdef CONFIG_ARCH_OMAP3
 static void __init omap3_init(void)
 {
 	omap3_i2c_init();
 	omap_generic_init();
 }
+#endif
 
 #if defined(CONFIG_SOC_OMAP2420)
 static const char *omap242x_boards_compat[] __initdata = {
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -359,6 +359,7 @@ static void __init omap_hwmod_init_postsetup(void)
 	omap_pm_if_early_init();
 }
 
+#ifdef CONFIG_ARCH_OMAP2
 void __init omap2420_init_early(void)
 {
 	omap2_set_globals_242x();
@@ -382,11 +383,13 @@ void __init omap2430_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap2430_clk_init();
 }
+#endif
 
 /*
  * Currently only board-omap3beagle.c should call this because of the
  * same machine_id for 34xx and 36xx beagle.. Will get fixed with DT.
  */
+#ifdef CONFIG_ARCH_OMAP3
 void __init omap3_init_early(void)
 {
 	omap2_set_globals_3xxx();
@@ -430,7 +433,9 @@ void __init ti816x_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap3xxx_clk_init();
 }
+#endif
 
+#ifdef CONFIG_ARCH_OMAP4
 void __init omap4430_init_early(void)
 {
 	omap2_set_globals_443x();
@@ -442,6 +447,7 @@ void __init omap4430_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap4xxx_clk_init();
 }
+#endif
 
 void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1)
