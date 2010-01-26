From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/14] omap2/3: Fix powerdomain init for multiomap
Date: Tue, 26 Jan 2010 12:13:06 -0800
Message-ID: <20100126201306.15382.7409.stgit@baageli.muru.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61150 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab0AZUMr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 15:12:47 -0500
In-Reply-To: <20100126200646.15382.52167.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Otherwise we'll an error when booting a kernel with both
CONFIG_ARCH_OMAP2 and CONFIG_ARCH_OMAP3 compiled in:

Unhandled fault: imprecise external abort (0xc06) at 0x00000000
...

Note that the same problem may still exist when trying to boot
a kernel with 2420 and 2430 both compiled in. We currently cannot
test this as the clock framework needs updating to support booting
2420 and 2430 compiled in.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c           |   13 +++++++++----
 arch/arm/mach-omap2/powerdomains.h |   23 +++++++++++++++++------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index ee13ca9..96e9ea8 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -320,21 +320,26 @@ static int __init _omap2_init_reprogram_sdrc(void)
 void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 				 struct omap_sdrc_params *sdrc_cs1)
 {
+	struct powerdomain **pwrdm = NULL;
 	struct omap_hwmod **hwmods = NULL;
 
-	if (cpu_is_omap2420())
+	if (cpu_is_omap2420()) {
+		pwrdm = powerdomains_omap2;
 		hwmods = omap2420_hwmods;
-	else if (cpu_is_omap2430())
+	} else if (cpu_is_omap2430()) {
+		pwrdm = powerdomains_omap2;
 		hwmods = omap2430_hwmods;
-	else if (cpu_is_omap34xx())
+	} else if (cpu_is_omap34xx()) {
+		pwrdm = powerdomains_omap3;
 		hwmods = omap34xx_hwmods;
+	}
 
 #ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
 	/* The OPP tables have to be registered before a clk init */
 	omap_hwmod_init(hwmods);
 	omap2_mux_init();
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
-	pwrdm_init(powerdomains_omap);
+	pwrdm_init(pwrdm);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 #endif
 	omap2_clk_init();
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
index d5d753c..6fe7d0c 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -152,22 +152,33 @@ static struct powerdomain wkup_pwrdm = {
 
 
 /* As powerdomains are added or removed above, this list must also be changed */
-static struct powerdomain *powerdomains_omap[] __initdata = {
+
+#ifdef CONFIG_ARCH_OMAP2
+static struct powerdomain *powerdomains_omap2[] __initdata = {
 
 	&gfx_pwrdm,
 	&wkup_pwrdm,
 
-#ifdef CONFIG_ARCH_OMAP2
 	&dsp_pwrdm,
 	&mpu_24xx_pwrdm,
 	&core_24xx_pwrdm,
-#endif
 
 #ifdef CONFIG_ARCH_OMAP2430
 	&mdm_pwrdm,
 #endif
 
+	NULL
+};
+#else
+#define powerdomains_omap2		NULL
+#endif
+
 #ifdef CONFIG_ARCH_OMAP3
+static struct powerdomain *powerdomains_omap3[] __initdata = {
+
+	&gfx_pwrdm,
+	&wkup_pwrdm,
+
 	&iva2_pwrdm,
 	&mpu_34xx_pwrdm,
 	&neon_pwrdm,
@@ -184,10 +195,10 @@ static struct powerdomain *powerdomains_omap[] __initdata = {
 	&dpll3_pwrdm,
 	&dpll4_pwrdm,
 	&dpll5_pwrdm,
-#endif
-
 	NULL
 };
-
+#else
+#define powerdomains_omap3		NULL
+#endif
 
 #endif

