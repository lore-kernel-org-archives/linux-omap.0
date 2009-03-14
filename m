From: David Brownell <david-b@pacbell.net>
Subject: [patch/rfc 2.6.29-rc8-omap-git+] beagle power resource init
Date: Sat, 14 Mar 2009 12:33:08 -0700
Message-ID: <200903141233.08968.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:25313 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751569AbZCNTdM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Mar 2009 15:33:12 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

Update Beagle init so it uses the new power resource hooks
to make sure that various regulators are initially off.
(Example, u-boot enables VAUX3, which isn't even wired up!!)

Also, add VPLL2 to the set of regulators used, and hook it
up to the LCD driver.  VPLL powers the digital video outputs;
for rev B boards, that's DVI only.

Drivers need to use regulator calls to enable these later.
USB and MMC handle this corrrectly (although not yet for
MMCplus cards, with 8-bit data).  The video driver doesn't.

NYET-Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
NOTE: kick in those resource hooks and you won't need that
regulator framework patch to make MMC behave ... but, each
board will need its own patches.

The downside of this patch for Beagle is that it mixes in the
VPLL2 changes ... which is OK unless you're using DVI output;
drivers/video/omap doesn't know how to use the regulators yet.
(Is "vdvi" a good label even for RevC boards?  VPLL2 is not...)

OVERO NOTE:  VAUX2, VAUX3, VMMC1, VMMC2, VPLL1, VPLL2, and VDAC
are among the regulators that are powered up on boot.  I'm told
most of those aren't even wired up...

 arch/arm/mach-omap2/board-omap3beagle.c |   62 +++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 6 deletions(-)

--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -216,6 +216,21 @@ static struct twl4030_gpio_platform_data
 	.setup		= beagle_twl_gpio_setup,
 };
 
+static struct platform_device omap3_beagle_lcd_device = {
+	.name		= "omap3beagle_lcd",
+	.id		= -1,
+};
+
+static struct regulator_consumer_supply beagle_vdac_supply = {
+	.supply		= "vdac",
+	.dev		= &omap3_beagle_lcd_device.dev,
+};
+
+static struct regulator_consumer_supply beagle_vdvi_supply = {
+	.supply		= "vdvi",
+	.dev		= &omap3_beagle_lcd_device.dev,
+};
+
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
 static struct regulator_init_data beagle_vmmc1 = {
 	.constraints = {
@@ -256,6 +271,45 @@ static struct regulator_init_data beagle
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &beagle_vdac_supply,
+};
+
+/* VPLL2 for digital video outputs */
+static struct regulator_init_data beagle_vpll2 = {
+	.constraints = {
+		.name			= "VDVI",
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &beagle_vdvi_supply,
+};
+
+static const struct twl4030_resconfig beagle_resconfig[] = {
+	/* disable regulators that u-boot left enabled; the
+	 * devices' drivers should be managing these.
+	 */
+	{ .resource = RES_VAUX3, },	/* not even connected! */
+	{ .resource = RES_VMMC1, },
+	{ .resource = RES_VSIM, },
+	{ .resource = RES_VPLL2, },
+	{ .resource = RES_VDAC, },
+	{ .resource = RES_VUSB_1V5, },
+	{ .resource = RES_VUSB_1V8, },
+	{ .resource = RES_VUSB_3V1, },
+	{ 0, },
+};
+
+static struct twl4030_power_data beagle_power_data = {
+	.resource_config	= beagle_resconfig,
+	/* REVISIT can't use GENERIC3430_T2SCRIPTS_DATA;
+	 * among other things, it makes reboot fail.
+	 */
 };
 
 static struct twl4030_platform_data beagle_twldata = {
@@ -265,10 +319,11 @@ static struct twl4030_platform_data beag
 	/* platform_data for children goes here */
 	.usb		= &beagle_usb_data,
 	.gpio		= &beagle_gpio_data,
-	.power		= GENERIC3430_T2SCRIPTS_DATA,
+	.power		= &beagle_power_data,
 	.vmmc1		= &beagle_vmmc1,
 	.vsim		= &beagle_vsim,
 	.vdac		= &beagle_vdac,
+	.vpll2		= &beagle_vpll2,
 };
 
 static struct i2c_board_info __initdata beagle_i2c_boardinfo[] = {
@@ -297,11 +352,6 @@ static void __init omap3_beagle_init_irq
 	omap_gpio_init();
 }
 
-static struct platform_device omap3_beagle_lcd_device = {
-	.name		= "omap3beagle_lcd",
-	.id		= -1,
-};
-
 static struct omap_lcd_config omap3_beagle_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
