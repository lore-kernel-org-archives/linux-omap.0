From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 2/3] ARM: OMAP: Add command line option for I2C bus speed
Date: Mon,  9 Feb 2009 09:59:56 +0200
Message-ID: <1234166397-4038-2-git-send-email-jarkko.nikula@nokia.com>
References: <1234114369-11399-1-git-send-email-jhnikula@gmail.com>
 <1234166397-4038-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50113 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbZBIH75 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 02:59:57 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n197xQbf026926
	for <linux-omap@vger.kernel.org>; Mon, 9 Feb 2009 09:59:54 +0200
In-Reply-To: <1234166397-4038-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

This patch adds a new command line option "i2c_bus=bus_id,clkrate" into
I2C bus registration helper. Purpose of the option is to override the
default board specific bus speed which is supplied by the
omap_register_i2c_bus.

The default bus speed is typically set to speed of slowest I2C chip on the
bus and overriding allow to use some experimental configurations or updated
chip versions without any kernel modifications.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/i2c.c |   54 +++++++++++++++++++++++++++++++++++++--------
 1 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 3e95954..aa70e43 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -119,6 +119,46 @@ static void __init omap_i2c_mux_pins(int bus)
 	omap_cfg_reg(scl);
 }
 
+static int __init omap_i2c_nr_ports(void)
+{
+	int ports = 0;
+
+	if (cpu_class_is_omap1())
+		ports = 1;
+	else if (cpu_is_omap24xx())
+		ports = 2;
+	else if (cpu_is_omap34xx())
+		ports = 3;
+
+	return ports;
+}
+
+/**
+ * omap_i2c_bus_setup - Process command line options for the I2C bus speed
+ * @str: String of options
+ *
+ * This function allow to override the default I2C bus speed for given I2C
+ * bus with a command line option.
+ *
+ * Format: i2c_bus=bus_id,clkrate (in kHz)
+ *
+ * Returns 1 on success, 0 otherwise.
+ */
+static int __init omap_i2c_bus_setup(char *str)
+{
+	int ports;
+	int ints[3];
+
+	ports = omap_i2c_nr_ports();
+	get_options(str, 3, ints);
+	if (ints[0] < 2 || ints[1] < 1 || ints[1] > ports)
+		return 0;
+	i2c_rate[ints[1] - 1] = ints[2];
+
+	return 1;
+}
+__setup("i2c_bus=", omap_i2c_bus_setup);
+
 /**
  * omap_register_i2c_bus - register I2C bus with device descriptors
  * @bus_id: bus id counting from number 1
@@ -132,19 +172,12 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 			  struct i2c_board_info const *info,
 			  unsigned len)
 {
-	int ports, err;
+	int err;
 	struct platform_device *pdev;
 	struct resource *res;
 	resource_size_t base, irq;
 
-	if (cpu_class_is_omap1())
-		ports = 1;
-	else if (cpu_is_omap24xx())
-		ports = 2;
-	else if (cpu_is_omap34xx())
-		ports = 3;
-
-	BUG_ON(bus_id < 1 || bus_id > ports);
+	BUG_ON(bus_id < 1 || bus_id > omap_i2c_nr_ports());
 
 	if (info) {
 		err = i2c_register_board_info(bus_id, info, len);
@@ -153,7 +186,8 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 	}
 
 	pdev = &omap_i2c_devices[bus_id - 1];
-	*(u32 *)pdev->dev.platform_data = clkrate;
+	if (i2c_rate[bus_id - 1] == 0)
+		i2c_rate[bus_id - 1] = clkrate;
 
 	if (bus_id == 1) {
 		res = pdev->resource;
-- 
1.5.6.5

