From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 3/3] ARM: OMAP: Add method to register additional I2C busses on the command line
Date: Mon,  9 Feb 2009 09:59:57 +0200
Message-ID: <1234166397-4038-3-git-send-email-jarkko.nikula@nokia.com>
References: <1234114369-11399-1-git-send-email-jhnikula@gmail.com>
 <1234166397-4038-1-git-send-email-jarkko.nikula@nokia.com>
 <1234166397-4038-2-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50108 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667AbZBIH74 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 02:59:56 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n197xPDB026905
	for <linux-omap@vger.kernel.org>; Mon, 9 Feb 2009 09:59:53 +0200
In-Reply-To: <1234166397-4038-2-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

This patch extends command line option "i2c_bus=bus_id,clkrate" so that
it allow to register additional I2C busses that are not registered with
omap_register_i2c_bus from board initialization code.

Purpose of this is to register additional board busses which are routed
to external connectors only without any on board I2C devices.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/i2c.c |   73 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index aa70e43..a303071 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -98,6 +98,8 @@ static const int omap34xx_pins[][2] = {
 static const int omap34xx_pins[][2] = {};
 #endif
 
+#define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
+
 static void __init omap_i2c_mux_pins(int bus)
 {
 	int scl, sda;
@@ -133,6 +135,31 @@ static int __init omap_i2c_nr_ports(void)
 	return ports;
 }
 
+static int __init omap_i2c_add_bus(int bus_id)
+{
+	struct platform_device *pdev;
+	struct resource *res;
+	resource_size_t base, irq;
+
+	pdev = &omap_i2c_devices[bus_id - 1];
+	if (bus_id == 1) {
+		res = pdev->resource;
+		if (cpu_class_is_omap1()) {
+			base = OMAP1_I2C_BASE;
+			irq = INT_I2C;
+		} else {
+			base = OMAP2_I2C_BASE1;
+			irq = INT_24XX_I2C1_IRQ;
+		}
+		res[0].start = base;
+		res[0].end = base + OMAP_I2C_SIZE;
+		res[1].start = irq;
+	}
+
+	omap_i2c_mux_pins(bus_id - 1);
+	return platform_device_register(pdev);
+}
+
 /**
  * omap_i2c_bus_setup - Process command line options for the I2C bus speed
  * @str: String of options
@@ -154,11 +181,33 @@ static int __init omap_i2c_bus_setup(char *str)
 	if (ints[0] < 2 || ints[1] < 1 || ints[1] > ports)
 		return 0;
 	i2c_rate[ints[1] - 1] = ints[2];
+	i2c_rate[ints[1] - 1] |= OMAP_I2C_CMDLINE_SETUP;
 
 	return 1;
 }
 __setup("i2c_bus=", omap_i2c_bus_setup);
 
+/*
+ * Register busses defined in command line but that are not registered with
+ * omap_register_i2c_bus from board initialization code.
+ */
+static int __init omap_register_i2c_bus_cmdline(void)
+{
+	int i, err = 0;
+
+	for (i = 0; i < ARRAY_SIZE(i2c_rate); i++)
+		if (i2c_rate[i] & OMAP_I2C_CMDLINE_SETUP) {
+			i2c_rate[i] &= ~OMAP_I2C_CMDLINE_SETUP;
+			err = omap_i2c_add_bus(i + 1);
+			if (err)
+				goto out;
+		}
+
+out:
+	return err;
+}
+subsys_initcall(omap_register_i2c_bus_cmdline);
+
 /**
  * omap_register_i2c_bus - register I2C bus with device descriptors
  * @bus_id: bus id counting from number 1
@@ -173,9 +222,6 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 			  unsigned len)
 {
 	int err;
-	struct platform_device *pdev;
-	struct resource *res;
-	resource_size_t base, irq;
 
 	BUG_ON(bus_id < 1 || bus_id > omap_i2c_nr_ports());
 
@@ -185,24 +231,9 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 			return err;
 	}
 
-	pdev = &omap_i2c_devices[bus_id - 1];
-	if (i2c_rate[bus_id - 1] == 0)
+	if (!i2c_rate[bus_id - 1])
 		i2c_rate[bus_id - 1] = clkrate;
+	i2c_rate[bus_id - 1] &= ~OMAP_I2C_CMDLINE_SETUP;
 
-	if (bus_id == 1) {
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
-	}
-
-	omap_i2c_mux_pins(bus_id - 1);
-	return platform_device_register(pdev);
+	return omap_i2c_add_bus(bus_id);
 }
-- 
1.5.6.5

