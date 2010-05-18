From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/13] omap: Fix i2c platform init code for omap4
Date: Mon, 17 May 2010 19:42:43 -0700
Message-ID: <20100518024243.21705.45209.stgit@baageli.muru.com>
References: <20100518023707.21705.26205.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58871 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954Ab0ERCmp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 22:42:45 -0400
In-Reply-To: <20100518023707.21705.26205.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Add separate omap_i2c_add_bus functions for mach-omap1
and mach-omap2. Make the mach-omap2 init set the interrupt
dynamically to support.

This is needed to add support for omap4 in a way that
works with multi-omap builds. This will eventually get
fixed with the omap hwmods.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/i2c.c |   61 ++++++++++++++++++++++++++++++++--------------
 1 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 624e262..484a4f0 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -97,35 +97,58 @@ static int __init omap_i2c_nr_ports(void)
 	return ports;
 }
 
-static int __init omap_i2c_add_bus(int bus_id)
+/* Shared between omap2 and 3 */
+static resource_size_t omap2_i2c_irq[3] __initdata = {
+	INT_24XX_I2C1_IRQ,
+	INT_24XX_I2C2_IRQ,
+	INT_34XX_I2C3_IRQ,
+};
+
+static inline int omap1_i2c_add_bus(struct platform_device *pdev, int bus_id)
 {
-	struct platform_device *pdev;
 	struct resource *res;
-	resource_size_t base, irq;
 
-	pdev = &omap_i2c_devices[bus_id - 1];
+	res = pdev->resource;
+	res[0].start = OMAP1_I2C_BASE;
+	res[0].end = res[0].start + OMAP_I2C_SIZE;
+	res[1].start = INT_I2C;
+	omap1_i2c_mux_pins(bus_id);
+
+	return platform_device_register(pdev);
+}
+
+static inline int omap2_i2c_add_bus(struct platform_device *pdev, int bus_id)
+{
+	struct resource *res;
+	resource_size_t *irq;
+
+	res = pdev->resource;
+
+	irq = omap2_i2c_irq;
+
 	if (bus_id == 1) {
-		res = pdev->resource;
-		if (cpu_class_is_omap1()) {
-			base = OMAP1_I2C_BASE;
-			irq = INT_I2C;
-		} else {
-			base = OMAP2_I2C_BASE1;
-			irq = INT_24XX_I2C1_IRQ;
-		}
-		res[0].start = base;
-		res[0].end = base + OMAP_I2C_SIZE;
-		res[1].start = irq;
+		res[0].start = OMAP2_I2C_BASE1;
+		res[0].end = res[0].start + OMAP_I2C_SIZE;
 	}
 
-	if (cpu_class_is_omap1())
-		omap1_i2c_mux_pins(bus_id);
-	if (cpu_class_is_omap2())
-		omap2_i2c_mux_pins(bus_id);
+	res[1].start = irq[bus_id - 1];
+	omap2_i2c_mux_pins(bus_id);
 
 	return platform_device_register(pdev);
 }
 
+static int __init omap_i2c_add_bus(int bus_id)
+{
+	struct platform_device *pdev;
+
+	pdev = &omap_i2c_devices[bus_id - 1];
+
+	if (cpu_class_is_omap1())
+		return omap1_i2c_add_bus(pdev, bus_id);
+	else
+		return omap2_i2c_add_bus(pdev, bus_id);
+}
+
 /**
  * omap_i2c_bus_setup - Process command line options for the I2C bus speed
  * @str: String of options

