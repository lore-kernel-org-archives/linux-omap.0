From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/4] ARM: OMAP: Move set_globals initialization to
 happen in init_early
Date: Wed, 5 Oct 2011 18:36:56 -0700
Message-ID: <20111006013656.GG6324@atomide.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
 <20111005014044.GZ6324@atomide.com>
 <alpine.LFD.2.02.1110042150190.9106@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59849 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751906Ab1JFBg7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 21:36:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1110042150190.9106@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Nicolas Pitre <nico@fluxnic.net> [111004 18:17]:
> On Tue, 4 Oct 2011, Tony Lindgren wrote:
> 
> > Otherwise we can't do generic map_io as we currently rely on
> > static mappings that work only because of arch_ioremap.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> That's great.
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Here's an updated version with all the early ioremap
access converted to use L3/L4_IO_ADDRESS macros. Some
of this may not be needed after generic map_io, but until
then we can't use ioremap until in init_early after the
SoC detection is done.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 4 Oct 2011 18:17:41 -0700
Subject: [PATCH] ARM: OMAP: Move set_globals initialization to happen in init_early

Otherwise we can't do generic map_io as we currently rely on
static mappings that work only because of arch_ioremap.

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index 981ca00..b0a16d2 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -37,7 +37,6 @@ static void __init ti8168_evm_init(void)
 
 static void __init ti8168_evm_map_io(void)
 {
-	omap2_set_globals_ti816x();
 	omapti816x_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index de61f15..110e5b9 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -45,11 +45,11 @@ static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
 static struct omap_globals omap242x_globals = {
 	.class	= OMAP242X_CLASS,
 	.tap	= OMAP2_L4_IO_ADDRESS(0x48014000),
-	.sdrc	= OMAP2420_SDRC_BASE,
-	.sms	= OMAP2420_SMS_BASE,
-	.ctrl	= OMAP242X_CTRL_BASE,
-	.prm	= OMAP2420_PRM_BASE,
-	.cm	= OMAP2420_CM_BASE,
+	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE),
+	.sms	= OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE),
+	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE),
+	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE),
+	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE),
 };
 
 void __init omap2_set_globals_242x(void)
@@ -59,7 +59,6 @@ void __init omap2_set_globals_242x(void)
 
 void __init omap242x_map_io(void)
 {
-	omap2_set_globals_242x();
 	omap242x_map_common_io();
 }
 #endif
@@ -69,11 +68,11 @@ void __init omap242x_map_io(void)
 static struct omap_globals omap243x_globals = {
 	.class	= OMAP243X_CLASS,
 	.tap	= OMAP2_L4_IO_ADDRESS(0x4900a000),
-	.sdrc	= OMAP243X_SDRC_BASE,
-	.sms	= OMAP243X_SMS_BASE,
-	.ctrl	= OMAP243X_CTRL_BASE,
-	.prm	= OMAP2430_PRM_BASE,
-	.cm	= OMAP2430_CM_BASE,
+	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE),
+	.sms	= OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE),
+	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
+	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE),
+	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE),
 };
 
 void __init omap2_set_globals_243x(void)
@@ -83,7 +82,6 @@ void __init omap2_set_globals_243x(void)
 
 void __init omap243x_map_io(void)
 {
-	omap2_set_globals_243x();
 	omap243x_map_common_io();
 }
 #endif
@@ -93,11 +91,11 @@ void __init omap243x_map_io(void)
 static struct omap_globals omap3_globals = {
 	.class	= OMAP343X_CLASS,
 	.tap	= OMAP2_L4_IO_ADDRESS(0x4830A000),
-	.sdrc	= OMAP343X_SDRC_BASE,
-	.sms	= OMAP343X_SMS_BASE,
-	.ctrl	= OMAP343X_CTRL_BASE,
-	.prm	= OMAP3430_PRM_BASE,
-	.cm	= OMAP3430_CM_BASE,
+	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
+	.sms	= OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE),
+	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
+	.prm	= OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE),
+	.cm	= OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
 };
 
 void __init omap2_set_globals_3xxx(void)
@@ -107,7 +105,6 @@ void __init omap2_set_globals_3xxx(void)
 
 void __init omap3_map_io(void)
 {
-	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
@@ -122,9 +119,9 @@ void __init omap3_map_io(void)
 static struct omap_globals ti816x_globals = {
 	.class  = OMAP343X_CLASS,
 	.tap    = OMAP2_L4_IO_ADDRESS(TI816X_TAP_BASE),
-	.ctrl   = TI816X_CTRL_BASE,
-	.prm    = TI816X_PRCM_BASE,
-	.cm     = TI816X_PRCM_BASE,
+	.ctrl   = OMAP2_L4_IO_ADDRESS(TI816X_CTRL_BASE),
+	.prm    = OMAP2_L4_IO_ADDRESS(TI816X_PRCM_BASE),
+	.cm     = OMAP2_L4_IO_ADDRESS(TI816X_PRCM_BASE),
 };
 
 void __init omap2_set_globals_ti816x(void)
@@ -137,11 +134,11 @@ void __init omap2_set_globals_ti816x(void)
 static struct omap_globals omap4_globals = {
 	.class	= OMAP443X_CLASS,
 	.tap	= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
-	.ctrl	= OMAP443X_SCM_BASE,
-	.ctrl_pad	= OMAP443X_CTRL_BASE,
-	.prm	= OMAP4430_PRM_BASE,
-	.cm	= OMAP4430_CM_BASE,
-	.cm2	= OMAP4430_CM2_BASE,
+	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
+	.ctrl_pad	= OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE),
+	.prm	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
+	.cm	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
+	.cm2	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE),
 };
 
 void __init omap2_set_globals_443x(void)
@@ -153,7 +150,6 @@ void __init omap2_set_globals_443x(void)
 
 void __init omap4_map_io(void)
 {
-	omap2_set_globals_443x();
 	omap44xx_map_common_io();
 }
 #endif
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index aab884f..e34d27f 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -149,17 +149,11 @@ static struct omap3_control_regs control_context;
 
 void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
 {
-	/* Static mapping, never released */
-	if (omap2_globals->ctrl) {
-		omap2_ctrl_base = ioremap(omap2_globals->ctrl, SZ_4K);
-		WARN_ON(!omap2_ctrl_base);
-	}
+	if (omap2_globals->ctrl)
+		omap2_ctrl_base = omap2_globals->ctrl;
 
-	/* Static mapping, never released */
-	if (omap2_globals->ctrl_pad) {
-		omap4_ctrl_pad_base = ioremap(omap2_globals->ctrl_pad, SZ_4K);
-		WARN_ON(!omap4_ctrl_pad_base);
-	}
+	if (omap2_globals->ctrl_pad)
+		omap4_ctrl_pad_base = omap2_globals->ctrl_pad;
 }
 
 void __iomem *omap_ctrl_base_get(void)
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b42bbb8..d5caac3 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -44,6 +44,7 @@
 #include "clockdomain.h"
 #include <plat/omap_hwmod.h>
 #include <plat/multi.h>
+#include <plat/common.h>
 
 /*
  * The machine specific code may provide the extra mapping besides the
@@ -359,6 +360,7 @@ static void __init omap_hwmod_init_postsetup(void)
 
 void __init omap2420_init_early(void)
 {
+	omap2_set_globals_242x();
 	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
 	omap242x_powerdomains_init();
@@ -370,6 +372,7 @@ void __init omap2420_init_early(void)
 
 void __init omap2430_init_early(void)
 {
+	omap2_set_globals_243x();
 	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
 	omap243x_powerdomains_init();
@@ -385,6 +388,7 @@ void __init omap2430_init_early(void)
  */
 void __init omap3_init_early(void)
 {
+	omap2_set_globals_3xxx();
 	omap_common_init_early();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
@@ -416,11 +420,19 @@ void __init am35xx_init_early(void)
 
 void __init ti816x_init_early(void)
 {
-	omap3_init_early();
+	omap2_set_globals_ti816x();
+	omap_common_init_early();
+	omap3xxx_voltagedomains_init();
+	omap3xxx_powerdomains_init();
+	omap3xxx_clockdomains_init();
+	omap3xxx_hwmod_init();
+	omap_hwmod_init_postsetup();
+	omap3xxx_clk_init();
 }
 
 void __init omap4430_init_early(void)
 {
+	omap2_set_globals_443x();
 	omap_common_init_early();
 	omap44xx_voltagedomains_init();
 	omap44xx_powerdomains_init();
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index ce65e93..11e25a4 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -102,8 +102,11 @@ void __init smp_init_cpus(void)
 {
 	unsigned int i, ncores;
 
-	/* Never released */
-	scu_base = ioremap(OMAP44XX_SCU_BASE, SZ_256);
+	/*
+	 * Currently we can't call ioremap here because
+	 * SoC detection won't work until after init_early.
+	 */
+	scu_base =  OMAP2_L4_IO_ADDRESS(OMAP44XX_SCU_BASE);
 	BUG_ON(!scu_base);
 
 	ncores = scu_get_core_count(scu_base);
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 2e40a5c..8db5f03 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -151,17 +151,10 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
 
 void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 {
-	/* Static mapping, never released */
-	if (omap2_globals->prm) {
-		prm_base = ioremap(omap2_globals->prm, SZ_8K);
-		WARN_ON(!prm_base);
-	}
-	if (omap2_globals->cm) {
-		cm_base = ioremap(omap2_globals->cm, SZ_8K);
-		WARN_ON(!cm_base);
-	}
-	if (omap2_globals->cm2) {
-		cm2_base = ioremap(omap2_globals->cm2, SZ_8K);
-		WARN_ON(!cm2_base);
-	}
+	if (omap2_globals->prm)
+		prm_base = omap2_globals->prm;
+	if (omap2_globals->cm)
+		cm_base = omap2_globals->cm;
+	if (omap2_globals->cm2)
+		cm2_base = omap2_globals->cm2;
 }
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index da6f3a6..8f27828 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -117,15 +117,10 @@ int omap2_sdrc_get_params(unsigned long r,
 
 void __init omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
 {
-	/* Static mapping, never released */
-	if (omap2_globals->sdrc) {
-		omap2_sdrc_base = ioremap(omap2_globals->sdrc, SZ_64K);
-		WARN_ON(!omap2_sdrc_base);
-	}
-	if (omap2_globals->sms) {
-		omap2_sms_base = ioremap(omap2_globals->sms, SZ_64K);
-		WARN_ON(!omap2_sms_base);
-	}
+	if (omap2_globals->sdrc)
+		omap2_sdrc_base = omap2_globals->sdrc;
+	if (omap2_globals->sms)
+		omap2_sms_base = omap2_globals->sms;
 }
 
 /**
