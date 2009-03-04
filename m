From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/7] ARM: OMAP: Add command line option for I2C bus speed
Date: Wed, 04 Mar 2009 13:51:05 -0800
Message-ID: <20090304215105.21101.88365.stgit@localhost>
References: <20090304214540.21101.72079.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56773 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516AbZCDVvJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 16:51:09 -0500
In-Reply-To: <20090304214540.21101.72079.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

From: Jarkko Nikula <jarkko.nikula@nokia.com>

This patch adds a new command line option "i2c_bus=bus_id,clkrate" into
I2C bus registration helper. Purpose of the option is to override the
default board specific bus speed which is supplied by the
omap_register_i2c_bus.

The default bus speed is typically set to speed of slowest I2C chip on the
bus and overriding allow to use some experimental configurations or updated
chip versions without any kernel modifications.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/i2c.c |   54 +++++++++++++++++++++++++++++++++++++---------
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

