From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 2/4] omap3beagle: Instantiate VDD1 and VDD2 regulators
Date: Fri, 8 Jul 2011 18:56:26 +0300
Message-ID: <1310140588-26078-3-git-send-email-t-kristo@ti.com>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37430 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416Ab1GHP5K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 11:57:10 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lrg@ti.com, broonie@opensource.wolfsonmicro.com, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Thomas Petazzoni <t-petazzoni@ti.com>

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Instantiate the VDD1 and VDD2 regulators and connect them to their
respective consumers: mpu.0 for VDD1 and l3_main.0 for VDD2.

TODO:

 * As these instantiations will be identical for all OMAP3 boards,
   find a way of sharing them throughout the different OMAP3 boards.

Signed-off-by: Thomas Petazzoni <t-petazzoni@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   35 +++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 78cf5f2..6d3a266 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -24,6 +24,7 @@
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 #include <linux/opp.h>
+#include <linux/regulator/driver.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -400,6 +401,38 @@ static struct regulator_init_data beagle_vpll2 = {
 	.consumer_supplies	= beagle_vdvi_supplies,
 };
 
+static struct regulator_consumer_supply beagle_vdd1_supply =
+	REGULATOR_SUPPLY("vcc", "mpu.0");
+
+static struct regulator_consumer_supply beagle_vdd2_supply =
+	REGULATOR_SUPPLY("vcc", "l3_main.0");
+
+static struct regulator_init_data beagle_vdd1 = {
+	.constraints = {
+		.name			= "VDD1",
+		.min_uV			= 600000,
+		.max_uV			= 1450000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &beagle_vdd1_supply,
+};
+
+static struct regulator_init_data beagle_vdd2 = {
+	.constraints = {
+		.name			= "VDD2",
+		.min_uV			= 600000,
+		.max_uV			= 1450000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &beagle_vdd2_supply,
+};
+
 static struct twl4030_usb_data beagle_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
@@ -423,6 +456,8 @@ static struct twl4030_platform_data beagle_twldata = {
 	.vsim		= &beagle_vsim,
 	.vdac		= &beagle_vdac,
 	.vpll2		= &beagle_vpll2,
+	.vdd1           = &beagle_vdd1,
+	.vdd2           = &beagle_vdd2,
 };
 
 static struct i2c_board_info __initdata beagle_i2c_eeprom[] = {
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

