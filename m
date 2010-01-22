From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: [PATCHv2 4/6] OMAP4: MCPDM: Register McPDM platform device
Date: Fri, 22 Jan 2010 17:15:31 -0600
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B8C43A8B3@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43862 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755417Ab0AVXPg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 18:15:36 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

Add platform device for McPDM interface in OMAP4 and register
its memory and irq resources.

Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
---
 arch/arm/plat-omap/devices.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 30b5db7..572265c 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -28,6 +28,7 @@
 #include <plat/menelaus.h>
 #include <plat/mcbsp.h>
 #include <plat/dsp_common.h>
+#include <plat/omap44xx.h>
 
 #if	defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
 
@@ -192,6 +193,41 @@ void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 
 /*-------------------------------------------------------------------------*/
 
+#if defined(CONFIG_SND_OMAP_SOC_MCPDM) || \
+		defined(CONFIG_SND_OMAP_SOC_MCPDM_MODULE)
+
+static struct resource mcpdm_resources[] = {
+	{
+		.name		= "mcpdm_mem",
+		.start		= OMAP44XX_MCPDM_BASE,
+		.end		= OMAP44XX_MCPDM_BASE + SZ_4K,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.name		= "mcpdm_irq",
+		.start		= INT_44XX_MCPDM_IRQ,
+		.end		= INT_44XX_MCPDM_IRQ,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device omap_mcpdm_device = {
+	.name		= "omap-mcpdm",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(mcpdm_resources),
+	.resource	= mcpdm_resources,
+};
+
+static void omap_init_mcpdm(void)
+{
+	(void) platform_device_register(&omap_mcpdm_device);
+}
+#else
+static inline void omap_init_mcpdm(void) {}
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
 	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
@@ -385,6 +421,7 @@ static int __init omap_init_devices(void)
 	omap_init_dsp();
 	omap_init_kp();
 	omap_init_rng();
+	omap_init_mcpdm();
 	omap_init_uwire();
 	omap_init_wdt();
 	return 0;
-- 
1.6.0.4