From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ARM: OMAP: Add command line option for I2C bus speed
Date: Sun, 25 Jan 2009 16:19:55 +0200
Message-ID: <20090125161955.27a57d4e.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f10.google.com ([209.85.219.10]:53715 "EHLO
	mail-ew0-f10.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064AbZAYOS3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Jan 2009 09:18:29 -0500
Received: by ewy3 with SMTP id 3so472097ewy.13
        for <linux-omap@vger.kernel.org>; Sun, 25 Jan 2009 06:18:26 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

This patch adds a new command line option "i2c_rate=bus_id,clkrate" into
I2C bus registration helper. Purpose of the option is to override the
default board specific bus speed which is supplied by the
omap_register_i2c_bus.

The default bus speed is typically set to speed of slowest I2C chip on the
bus and overriding allow to use some experimental configurations or updated
chip versions without any kernel modifications.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/i2c.c |   52 ++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 467531e..0724fbd 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -119,14 +119,9 @@ static void __init omap_i2c_mux_pins(int bus)
 	omap_cfg_reg(scl);
 }
 
-int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
-			  struct i2c_board_info const *info,
-			  unsigned len)
+static int __init omap_i2c_nr_ports(void)
 {
-	int ports, err;
-	struct platform_device *pdev;
-	struct resource *res;
-	resource_size_t base, irq;
+	int ports = 0;
 
 	if (cpu_class_is_omap1())
 		ports = 1;
@@ -135,7 +130,45 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 	else if (cpu_is_omap34xx())
 		ports = 3;
 
-	BUG_ON(bus_id < 1 || bus_id > ports);
+	return ports;
+}
+
+/**
+ * omap_i2c_rate_setup - Process command line options for the I2C bus speed
+ * @str: String of options
+ *
+ * This function allow to override the default I2C bus speed for given I2C
+ * bus with a command line option.
+ *
+ * Format: i2c_rate=bus_id,clkrate
+ *
+ * Returns 1 on success, 0 otherwise.
+ */
+static int __init omap_i2c_rate_setup(char *str)
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
+__setup("i2c_rate=", omap_i2c_rate_setup);
+
+int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
+			  struct i2c_board_info const *info,
+			  unsigned len)
+{
+	int err;
+	struct platform_device *pdev;
+	struct resource *res;
+	resource_size_t base, irq;
+
+	BUG_ON(bus_id < 1 || bus_id > omap_i2c_nr_ports());
 
 	if (info) {
 		err = i2c_register_board_info(bus_id, info, len);
@@ -144,7 +177,8 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 	}
 
 	pdev = &omap_i2c_devices[bus_id - 1];
-	*(u32 *)pdev->dev.platform_data = clkrate;
+	if (i2c_rate[bus_id - 1] == 0)
+		i2c_rate[bus_id - 1] = clkrate;
 
 	if (bus_id == 1) {
 		res = pdev->resource;
-- 
1.5.6.5

