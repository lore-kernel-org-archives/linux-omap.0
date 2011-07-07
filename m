From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/3] OMAP: McPDM: Convert McPDM device to omap_device
Date: Thu, 7 Jul 2011 15:27:51 +0300
Message-ID: <1310041672-18634-3-git-send-email-peter.ujfalusi@ti.com>
References: <1310041672-18634-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39819 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755976Ab1GGM2K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jul 2011 08:28:10 -0400
In-Reply-To: <1310041672-18634-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>, Benoit Coussoni <b-cousson@ti.com>

McPDM device is converted to omap device.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Jorge Eduardo Candelaria
Signed-off-by: Margarita Olaya Cabrera
Signed-off-by: Liam Girdwood <lrg@ti.com>
Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
---
 arch/arm/mach-omap2/devices.c |   33 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/devices.c  |   36 ------------------------------------
 2 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 5b8ca68..d94e845 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -329,6 +329,38 @@ static void omap_init_audio(void)
 static inline void omap_init_audio(void) {}
 #endif
 
+#if defined(CONFIG_SND_OMAP_SOC_MCPDM) || \
+		defined(CONFIG_SND_OMAP_SOC_MCPDM_MODULE)
+
+static struct omap_device_pm_latency omap_mcpdm_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+static void omap_init_mcpdm(void)
+{
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+
+	oh = omap_hwmod_lookup("mcpdm");
+	if (!oh) {
+		printk(KERN_ERR "Could not look up mcpdm hw_mod\n");
+		return;
+	}
+
+	od = omap_device_build("omap-mcpdm", -1, oh, NULL, 0,
+				omap_mcpdm_latency,
+				ARRAY_SIZE(omap_mcpdm_latency), 0);
+	if (IS_ERR(od))
+		printk(KERN_ERR "Could not build omap_device for omap-mcpdm-dai\n");
+}
+#else
+static inline void omap_init_mcpdm(void) {}
+#endif
+
 #if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
 
 #include <plat/mcspi.h>
@@ -682,6 +714,7 @@ static int __init omap2_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */
 	omap_init_audio();
+	omap_init_mcpdm();
 	omap_init_camera();
 	omap_init_mbox();
 	omap_init_mcspi();
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index ea28f98..40eca9b 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -74,41 +74,6 @@ void omap_mcbsp_register_board_cfg(struct resource *res, int res_count,
 
 /*-------------------------------------------------------------------------*/
 
-#if defined(CONFIG_SND_OMAP_SOC_MCPDM) || \
-		defined(CONFIG_SND_OMAP_SOC_MCPDM_MODULE)
-
-static struct resource mcpdm_resources[] = {
-	{
-		.name		= "mcpdm_mem",
-		.start		= OMAP44XX_MCPDM_BASE,
-		.end		= OMAP44XX_MCPDM_BASE + SZ_4K,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.name		= "mcpdm_irq",
-		.start		= OMAP44XX_IRQ_MCPDM,
-		.end		= OMAP44XX_IRQ_MCPDM,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device omap_mcpdm_device = {
-	.name		= "omap-mcpdm",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(mcpdm_resources),
-	.resource	= mcpdm_resources,
-};
-
-static void omap_init_mcpdm(void)
-{
-	(void) platform_device_register(&omap_mcpdm_device);
-}
-#else
-static inline void omap_init_mcpdm(void) {}
-#endif
-
-/*-------------------------------------------------------------------------*/
-
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
 	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
@@ -291,7 +256,6 @@ static int __init omap_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */
 	omap_init_rng();
-	omap_init_mcpdm();
 	omap_init_uwire();
 	return 0;
 }
-- 
1.7.6

