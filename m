From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/13] omap4: Add support for i2c init
Date: Mon, 17 May 2010 19:42:46 -0700
Message-ID: <20100518024246.21705.71913.stgit@baageli.muru.com>
References: <20100518023707.21705.26205.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58527 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975Ab0ERCmu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 22:42:50 -0400
In-Reply-To: <20100518023707.21705.26205.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Add support for i2c init for omap4.

This patch is based on and earlier patch by
Santosh Shilimkar <santosh.shilimkar@ti.com>.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/i2c.c |   33 ++++++++++++++++++++++++++-------
 1 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 484a4f0..4281bb6 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -35,6 +35,7 @@
 #define OMAP2_I2C_BASE1		0x48070000
 #define OMAP2_I2C_BASE2		0x48072000
 #define OMAP2_I2C_BASE3		0x48060000
+#define OMAP4_I2C_BASE4		0x48350000
 
 static const char name[] = "i2c_omap";
 
@@ -51,11 +52,14 @@ static const char name[] = "i2c_omap";
 
 static struct resource i2c_resources[][2] = {
 	{ I2C_RESOURCE_BUILDER(0, 0) },
-#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_24XX_I2C2_IRQ) },
+#if	defined(CONFIG_ARCH_OMAP2PLUS)
+	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, 0) },
 #endif
-#if	defined(CONFIG_ARCH_OMAP3)
-	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, INT_34XX_I2C3_IRQ) },
+#if	defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, 0) },
+#endif
+#if	defined(CONFIG_ARCH_OMAP4)
+	{ I2C_RESOURCE_BUILDER(OMAP4_I2C_BASE4, 0) },
 #endif
 };
 
@@ -73,12 +77,15 @@ static struct resource i2c_resources[][2] = {
 static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
 static struct platform_device omap_i2c_devices[] = {
 	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
-#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if	defined(CONFIG_ARCH_OMAP2PLUS)
 	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
 #endif
-#if	defined(CONFIG_ARCH_OMAP3)
+#if	defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
 #endif
+#if	defined(CONFIG_ARCH_OMAP4)
+	I2C_DEV_BUILDER(4, i2c_resources[3], &i2c_rate[3]),
+#endif
 };
 
 #define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
@@ -93,6 +100,8 @@ static int __init omap_i2c_nr_ports(void)
 		ports = 2;
 	else if (cpu_is_omap34xx())
 		ports = 3;
+	else if (cpu_is_omap44xx())
+		ports = 4;
 
 	return ports;
 }
@@ -104,6 +113,13 @@ static resource_size_t omap2_i2c_irq[3] __initdata = {
 	INT_34XX_I2C3_IRQ,
 };
 
+static resource_size_t omap4_i2c_irq[4] __initdata = {
+	OMAP44XX_IRQ_I2C1,
+	OMAP44XX_IRQ_I2C2,
+	OMAP44XX_IRQ_I2C3,
+	OMAP44XX_IRQ_I2C4,
+};
+
 static inline int omap1_i2c_add_bus(struct platform_device *pdev, int bus_id)
 {
 	struct resource *res;
@@ -124,7 +140,10 @@ static inline int omap2_i2c_add_bus(struct platform_device *pdev, int bus_id)
 
 	res = pdev->resource;
 
-	irq = omap2_i2c_irq;
+	if (!cpu_is_omap44xx())
+		irq = omap2_i2c_irq;
+	else
+		irq = omap4_i2c_irq;
 
 	if (bus_id == 1) {
 		res[0].start = OMAP2_I2C_BASE1;

