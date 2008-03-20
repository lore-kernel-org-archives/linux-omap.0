From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 1/1] PLAT: OMAP: Add device configuration to support second
 HSMMC slot on OMAP 2430 and 3430 boards.
Date: Thu, 20 Mar 2008 10:25:01 -0400
Message-ID: <47E273BD.9080705@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47285 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515AbYCTO2e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 10:28:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

From: Jarkko Lavinen <jarkko.lavinen@nokia.com>

This patch adds device configuration to provide second HSMMC slot support
on OMAP 2430 and 3430 boards.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 arch/arm/plat-omap/devices.c |   39 ++++++++++++++++++++++++++++++---------
 1 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index ec9a999..3ac2b9b 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -155,13 +155,29 @@ static inline void omap_init_kp(void) {}
 	|| defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#define OMAP_MMC_NAME		"hsmmc-omap"
+
 #define	OMAP_MMC1_BASE		0x4809c000
+#define OMAP_MMC1_END		OMAP_MMC1_BASE + 0x1fc
 #define OMAP_MMC1_INT		INT_24XX_MMC_IRQ
+
+#define OMAP_MMC2_BASE		0x480b4000
+#define OMAP_MMC2_END		OMAP_MMC2_BASE + 0x1fc
+#define OMAP_MMC2_INT		INT_24XX_MMC_IRQ
+
 #else
+
+#define OMAP_MMC_NAME		"mmci-omap"
+
 #define	OMAP_MMC1_BASE		0xfffb7800
+#define OMAP_MMC1_END		OMAP_MMC1_BASE + 0x7f
 #define OMAP_MMC1_INT		INT_MMC
-#endif
+
 #define	OMAP_MMC2_BASE		0xfffb7c00	/* omap16xx only */
+#define OMAP_MMC2_END		OMAP_MMC2_BASE + 0x7f
+#define OMAP_MMC2_INT		INT_1610_MMC2
+
+#endif
 
 static struct omap_mmc_platform_data mmc1_data;
 
@@ -170,7 +186,7 @@ static u64 mmc1_dmamask = 0xffffffff;
 static struct resource mmc1_resources[] = {
 	{
 		.start		= OMAP_MMC1_BASE,
-		.end		= OMAP_MMC1_BASE + 0x7f,
+		.end		= OMAP_MMC1_END,
 		.flags		= IORESOURCE_MEM,
 	},
 	{
@@ -180,7 +196,7 @@ static struct resource mmc1_resources[] = {
 };
 
 static struct platform_device mmc_omap_device1 = {
-	.name		= "mmci-omap",
+	.name		= OMAP_MMC_NAME,
 	.id		= 1,
 	.dev = {
 		.dma_mask	= &mmc1_dmamask,
@@ -190,7 +206,8 @@ static struct platform_device mmc_omap_device1 = {
 	.resource	= mmc1_resources,
 };
 
-#ifdef	CONFIG_ARCH_OMAP16XX
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) \
+	|| defined(CONFIG_ARCH_OMAP34XX)
 
 static struct omap_mmc_platform_data mmc2_data;
 
@@ -200,17 +217,17 @@ static u64 mmc2_dmamask = 0xffffffff;
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
 
 static struct platform_device mmc_omap_device2 = {
-	.name		= "mmci-omap",
+	.name		= OMAP_MMC_NAME,
 	.id		= 2,
 	.dev = {
 		.dma_mask	= &mmc2_dmamask,
@@ -235,8 +252,11 @@ static void __init omap_init_mmc(void)
 	mmc = &mmc_conf->mmc[0];
 
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
-		if (mmc->enabled)
+		mmc = &mmc_conf->mmc[1];
+		if (mmc->enabled) {
 			(void) platform_device_register(&mmc_omap_device1);
+			(void) platform_device_register(&mmc_omap_device2);
+		}
 		return;
 	}
 
@@ -329,7 +349,8 @@ void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info)
 	case 1:
 		mmc1_data = *info;
 		break;
-#ifdef CONFIG_ARCH_OMAP16XX
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) \
+	       || defined(CONFIG_ARCH_OMAP34XX)
 	case 2:
 		mmc2_data = *info;
 		break;
-- 1.5.3.GIT

