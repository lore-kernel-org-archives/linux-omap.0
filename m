From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc2-omap1-git 4/7] minor overo init update
Date: Tue, 20 Jan 2009 02:51:07 -0800
Message-ID: <200901200251.07929.david-b@pacbell.net>
References: <200901200244.36238.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:44268 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756763AbZATLBU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Jan 2009 06:01:20 -0500
In-Reply-To: <200901200244.36238.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

Overo init update:  configure the VMMC regulator, which seems
to be the only one (other than VDD1 and VIO) used.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-overo.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -27,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/regulator/machine.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
@@ -156,12 +157,25 @@ static struct twl4030_usb_data overo_usb
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
+static struct regulator_init_data overo_vmmc1 = {
+	.constraints = {
+		.valid_modes_mask = REGULATOR_MODE_NORMAL
+				| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE
+				| REGULATOR_CHANGE_MODE
+				| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* mmc2 (WLAN) and Bluetooth don't use twl4030 regulators */
+
 static struct twl4030_platform_data overo_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 	.gpio		= &overo_gpio_data,
 	.usb		= &overo_usb_data,
 	.power		= GENERIC3430_T2SCRIPTS_DATA,
+	.vmmc1		= &overo_vmmc1,
 };
 
 static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
