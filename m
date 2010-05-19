From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/13] omap4: Add support for i2c init
Date: Tue, 18 May 2010 17:16:12 -0700
Message-ID: <20100519001612.GZ5818@atomide.com>
References: <20100518023707.21705.26205.stgit@baageli.muru.com>
 <20100518024246.21705.71913.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d01dLTUuW90fS44H"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63447 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab0ESAQP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 20:16:15 -0400
Content-Disposition: inline
In-Reply-To: <20100518024246.21705.71913.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100517 19:37]:
> Add support for i2c init for omap4.

Below is this one rebased to apply on current for-next.

Regards,

Tony

--d01dLTUuW90fS44H
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap-i2c-omap4.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Tue, 18 May 2010 16:19:16 -0700
Subject: [PATCH] omap4: Add support for i2c init

Add support for i2c init for omap4.

This patch is based on and earlier patch by
Santosh Shilimkar <santosh.shilimkar@ti.com>.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 78d1cea..eec2b49 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -38,6 +38,7 @@
 #define OMAP2_I2C_BASE1		0x48070000
 #define OMAP2_I2C_BASE2		0x48072000
 #define OMAP2_I2C_BASE3		0x48060000
+#define OMAP4_I2C_BASE4		0x48350000
 
 static const char name[] = "i2c_omap";
 
@@ -54,11 +55,14 @@ static const char name[] = "i2c_omap";
 
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
 
@@ -76,12 +80,15 @@ static struct resource i2c_resources[][2] = {
 static struct omap_i2c_bus_platform_data i2c_pdata[ARRAY_SIZE(i2c_resources)];
 static struct platform_device omap_i2c_devices[] = {
 	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_pdata[0]),
-#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if	defined(CONFIG_ARCH_OMAP2PLUS)
 	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_pdata[1]),
 #endif
-#if	defined(CONFIG_ARCH_OMAP3)
+#if	defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_pdata[2]),
 #endif
+#if	defined(CONFIG_ARCH_OMAP4)
+	I2C_DEV_BUILDER(4, i2c_resources[3], &i2c_pdata[3]),
+#endif
 };
 
 #define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
@@ -96,6 +103,8 @@ static int __init omap_i2c_nr_ports(void)
 		ports = 2;
 	else if (cpu_is_omap34xx())
 		ports = 3;
+	else if (cpu_is_omap44xx())
+		ports = 4;
 
 	return ports;
 }
@@ -107,6 +116,13 @@ static resource_size_t omap2_i2c_irq[3] __initdata = {
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
 	struct omap_i2c_bus_platform_data *pd;
@@ -129,7 +145,10 @@ static inline int omap2_i2c_add_bus(struct platform_device *pdev, int bus_id)
 
 	res = pdev->resource;
 
-	irq = omap2_i2c_irq;
+	if (!cpu_is_omap44xx())
+		irq = omap2_i2c_irq;
+	else
+		irq = omap4_i2c_irq;
 
 	if (bus_id == 1) {
 		res[0].start = OMAP2_I2C_BASE1;

--d01dLTUuW90fS44H--
