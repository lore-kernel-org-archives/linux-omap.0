From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 3/3] omap3: cm-t35: add support for baseboard ehternet
Date: Wed, 11 Nov 2009 13:19:32 +0200
Message-ID: <569daf1053bd9a1c01de3d5f6a93029028d448b6.1257937910.git.mike@compulab.co.il>
References: <cover.1257937910.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:54098 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757356AbZKKLZy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Nov 2009 06:25:54 -0500
Received: from [62.90.235.247] (helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1N8BKq-00070h-1v
	for linux-omap@vger.kernel.org; Wed, 11 Nov 2009 05:26:00 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 819E09A0358
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 13:19:34 +0200 (IST)
In-Reply-To: <cover.1257937910.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Rapoport <mike@compulab.co.il>

Default CM-T35 baseboard (SB-T35) utilizes SMSC9220 Ethernet chip.
Enable it.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |   67 ++++++++++++++++++++++++++----------
 1 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 0a46c0e..22c4529 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -52,6 +52,8 @@
 
 #define CM_T35_SMSC911X_CS	5
 #define CM_T35_SMSC911X_GPIO	163
+#define SB_T35_SMSC911X_CS	4
+#define SB_T35_SMSC911X_GPIO	65
 
 #define NAND_BLOCK_SIZE		SZ_128K
 #define GPMC_CS0_BASE		0x60
@@ -60,9 +62,15 @@
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <linux/smsc911x.h>
 
+static struct smsc911x_platform_config cm_t35_smsc911x_config = {
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
+	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+};
+
 static struct resource cm_t35_smsc911x_resources[] = {
 	{
-		.name	= "smsc911x-memory",
 		.flags	= IORESOURCE_MEM,
 	},
 	{
@@ -72,13 +80,6 @@ static struct resource cm_t35_smsc911x_resources[] = {
 	},
 };
 
-static struct smsc911x_platform_config cm_t35_smsc911x_config = {
-	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
-	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
-	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
-	.phy_interface	= PHY_INTERFACE_MODE_MII,
-};
-
 static struct platform_device cm_t35_smsc911x_device = {
 	.name		= "smsc911x",
 	.id		= 0,
@@ -89,30 +90,60 @@ static struct platform_device cm_t35_smsc911x_device = {
 	},
 };
 
-static void __init cm_t35_init_smsc911x(void)
+static struct resource sb_t35_smsc911x_resources[] = {
+	{
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= OMAP_GPIO_IRQ(SB_T35_SMSC911X_GPIO),
+		.end	= OMAP_GPIO_IRQ(SB_T35_SMSC911X_GPIO),
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
+	},
+};
+
+static struct platform_device sb_t35_smsc911x_device = {
+	.name		= "smsc911x",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(sb_t35_smsc911x_resources),
+	.resource	= sb_t35_smsc911x_resources,
+	.dev		= {
+		.platform_data = &cm_t35_smsc911x_config,
+	},
+};
+
+static void __init cm_t35_init_smsc911x(struct platform_device *dev,
+					int cs, int irq_gpio)
 {
 	unsigned long cs_mem_base;
 
-	if (gpmc_cs_request(CM_T35_SMSC911X_CS, SZ_16M, &cs_mem_base) < 0) {
+	if (gpmc_cs_request(cs, SZ_16M, &cs_mem_base) < 0) {
 		pr_err("CM-T35: Failed request for GPMC mem for smsc911x\n");
 		return;
 	}
 
-	cm_t35_smsc911x_resources[0].start = cs_mem_base + 0x0;
-	cm_t35_smsc911x_resources[0].end   = cs_mem_base + 0xff;
+	dev->resource[0].start = cs_mem_base + 0x0;
+	dev->resource[0].end   = cs_mem_base + 0xff;
 
-	if ((gpio_request(CM_T35_SMSC911X_GPIO, "CM ETH IRQ") == 0) &&
-	    (gpio_direction_input(CM_T35_SMSC911X_GPIO) == 0)) {
-		gpio_export(CM_T35_SMSC911X_GPIO, 0);
+	if ((gpio_request(irq_gpio, "ETH IRQ") == 0) &&
+	    (gpio_direction_input(irq_gpio) == 0)) {
+		gpio_export(irq_gpio, 0);
 	} else {
 		pr_err("CM-T35: could not obtain gpio for SMSC911X IRQ\n");
 		return;
 	}
 
-	platform_device_register(&cm_t35_smsc911x_device);
+	platform_device_register(dev);
+}
+
+static void __init cm_t35_init_ethernet(void)
+{
+	cm_t35_init_smsc911x(&cm_t35_smsc911x_device,
+			     CM_T35_SMSC911X_CS, CM_T35_SMSC911X_GPIO);
+	cm_t35_init_smsc911x(&sb_t35_smsc911x_device,
+			     SB_T35_SMSC911X_CS, SB_T35_SMSC911X_GPIO);
 }
 #else
-static inline void __init cm_t35_init_smsc911x(void) { return; }
+static inline void __init cm_t35_init_ethernet(void) { return; }
 #endif
 
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
@@ -457,7 +488,7 @@ static void __init cm_t35_init(void)
 	cm_t35_init_i2c();
 	cm_t35_init_nand();
 	cm_t35_init_ads7846();
-	cm_t35_init_smsc911x();
+	cm_t35_init_ethernet();
 	cm_t35_init_led();
 
 	usb_musb_init();
-- 
1.6.0.6

