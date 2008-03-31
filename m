From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 1/1] PLAT: OMAP: Add device configuration to support second
 HSMMC slot on OMAP 2430 and 3430 boards.
Date: Mon, 31 Mar 2008 16:06:36 -0400
Message-ID: <47F1444C.7070508@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:59992 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbYCaUHO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2008 16:07:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

From: Jarkko Lavinen <jarkko.lavinen@nokia.com>

This patch adds device configuration to provide second HSMMC slot support
on OMAP 2430 and 3430 boards.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>

Change CONFIG_ARCH_OMAP24XX by CONFIG_ARCH_OMAP243X macro when this config
is needed only for 2430 boards.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 arch/arm/plat-omap/devices.c |   35 ++++++++++++++++++++++++++++-------
 1 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index ec9a999..6f07451 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -156,12 +156,24 @@ static inline void omap_init_kp(void) {}
 
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 #define	OMAP_MMC1_BASE		0x4809c000
-#define OMAP_MMC1_INT		INT_24XX_MMC_IRQ
+#define	OMAP_MMC1_END		OMAP_MMC1_BASE + 0x1fc
+#define	OMAP_MMC1_INT		INT_24XX_MMC_IRQ
+
+#define	OMAP_MMC2_BASE		0x480b4000
+#define	OMAP_MMC2_END		OMAP_MMC2_BASE + 0x1fc
+#define	OMAP_MMC2_INT		INT_24XX_MMC2_IRQ
+
 #else
+
 #define	OMAP_MMC1_BASE		0xfffb7800
+#define	OMAP_MMC1_END		OMAP_MMC1_BASE + 0x7f
 #define OMAP_MMC1_INT		INT_MMC
-#endif
+
 #define	OMAP_MMC2_BASE		0xfffb7c00	/* omap16xx only */
+#define	OMAP_MMC2_END		OMAP_MMC2_BASE + 0x7f
+#define	OMAP_MMC2_INT		INT_1610_MMC2
+
+#endif
 
 static struct omap_mmc_platform_data mmc1_data;
 
@@ -170,7 +182,7 @@ static u64 mmc1_dmamask = 0xffffffff;
 static struct resource mmc1_resources[] = {
 	{
 		.start		= OMAP_MMC1_BASE,
-		.end		= OMAP_MMC1_BASE + 0x7f,
+		.end		= OMAP_MMC1_END,
 		.flags		= IORESOURCE_MEM,
 	},
 	{
@@ -190,7 +202,8 @@ static struct platform_device mmc_omap_device1 = {
 	.resource	= mmc1_resources,
 };
 
-#ifdef	CONFIG_ARCH_OMAP16XX
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP243X) || \
+	defined(CONFIG_ARCH_OMAP34XX)
 
 static struct omap_mmc_platform_data mmc2_data;
 
@@ -200,11 +213,11 @@ static u64 mmc2_dmamask = 0xffffffff;
 static struct resource mmc2_resources[] = {
 	{
 		.start		= OMAP_MMC2_BASE,
-		.end		= OMAP_MMC2_BASE + 0x7f,
+		.end		= OMAP_MMC2_END,
 		.flags		= IORESOURCE_MEM,
 	},
 	{
-		.start		= INT_1610_MMC2,
+		.start		= OMAP_MMC2_INT,
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -237,6 +250,13 @@ static void __init omap_init_mmc(void)
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		if (mmc->enabled)
 			(void) platform_device_register(&mmc_omap_device1);
+
+#if defined(CONFIG_ARCH_OMAP243X) || defined(CONFIG_ARCH_OMAP34XX)
+		mmc = &mmc_conf->mmc[1];
+		if (mmc->enabled)
+			(void) platform_device_register(&mmc_omap_device2);
+#endif
+
 		return;
 	}
 
@@ -329,7 +349,8 @@ void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info)
 	case 1:
 		mmc1_data = *info;
 		break;
-#ifdef CONFIG_ARCH_OMAP16XX
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP243X) || \
+	defined(CONFIG_ARCH_OMAP34XX)
 	case 2:
 		mmc2_data = *info;
 		break;
-- 1.5.3.GIT

