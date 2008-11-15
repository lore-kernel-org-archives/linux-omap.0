From: David Brownell <david-b@pacbell.net>
Subject: [patch 3/4] twl:  beagle regulator updates
Date: Sat, 15 Nov 2008 12:41:34 -0800
Message-ID: <200811151241.34304.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:20765 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751782AbYKOUyI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Nov 2008 15:54:08 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Add init data for the LDO regulators used on Beagle boards:

 - VMMC1 is the main MMC1 power
 - VSIM powers MMC1 too:  DAT4-DAT7 pins, for HSMMC cards
 - VDAC for S-Video output

Those regulators need to be hooked up to the MMC1 and FB (?) devices
through the regulator framework.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -28,6 +28,8 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
 
+#include <linux/regulator/machine.h>
+
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -163,6 +165,40 @@ static struct twl4030_gpio_platform_data
 	.setup		= beagle_twl_gpio_setup,
 };
 
+/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
+static struct regulator_init_data beagle_vmmc1 = {
+	.constraints = {
+		.valid_modes_mask = REGULATOR_MODE_NORMAL
+				| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE
+				| REGULATOR_CHANGE_MODE
+				| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
+static struct regulator_init_data beagle_vsim = {
+	.constraints = {
+		.valid_modes_mask = REGULATOR_MODE_NORMAL
+				| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE
+				| REGULATOR_CHANGE_MODE
+				| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* VDAC for DSS driving S-Video (8 mA unloaded, max 65 mA) */
+static struct regulator_init_data beagle_vdac = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
 static struct twl4030_platform_data beagle_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -171,6 +207,9 @@ static struct twl4030_platform_data beag
 	.usb		= &beagle_usb_data,
 	.gpio		= &beagle_gpio_data,
 	.power		= &generic3430_t2scripts_data,
+	.vmmc1		= &beagle_vmmc1,
+	.vsim		= &beagle_vsim,
+	.vdac		= &beagle_vdac,
 };
 
 static struct i2c_board_info __initdata beagle_i2c_boardinfo[] = {
