From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc8-omap git] sdp regulator init updates
Date: Fri, 20 Mar 2009 15:33:11 -0700
Message-ID: <200903201533.11456.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n17.bullet.mail.mud.yahoo.com ([68.142.206.144]:23581 "HELO
	n17.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752265AbZCTWdQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2009 18:33:16 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

Hook up VPLL2 regulator on 3430 SDP.  Link that and VDAC to the
framebuffer device, supporting eventual conversion to use the
regulator framework.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Try also to merge this into the mainline queue ...

 arch/arm/mach-omap2/board-3430sdp.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -189,6 +189,8 @@ static int ads7846_vaux_control(int vaux
 {
 	int ret = 0;
 
+	/* FIXME use regulator calls */
+
 #ifdef CONFIG_TWL4030_CORE
 	/* check for return value of ldo_use: if success it returns 0 */
 	if (vaux_cntrl == VAUX_ENABLE) {
@@ -245,6 +247,16 @@ static struct platform_device sdp3430_lc
 	.id		= -1,
 };
 
+static struct regulator_consumer_supply sdp3430_vdac_supply = {
+	.supply		= "vdac",
+	.dev		= &sdp3430_lcd_device.dev,
+};
+
+static struct regulator_consumer_supply sdp3430_vdvi_supply = {
+	.supply		= "vdvi",
+	.dev		= &sdp3430_lcd_device.dev,
+};
+
 static struct platform_device *sdp3430_devices[] __initdata = {
 	&sdp3430_smc91x_device,
 	&sdp3430_lcd_device,
@@ -587,6 +599,23 @@ static struct regulator_init_data sdp343
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &sdp3430_vdac_supply,
+};
+
+/* VPLL2 for digital video outputs */
+static struct regulator_init_data sdp3430_vpll2 = {
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
+	.consumer_supplies	= &sdp3430_vdvi_supply,
 };
 
 static struct twl4030_platform_data sdp3430_twldata = {
@@ -609,6 +638,7 @@ static struct twl4030_platform_data sdp3
 	.vmmc2		= &sdp3430_vmmc2,
 	.vsim		= &sdp3430_vsim,
 	.vdac		= &sdp3430_vdac,
+	.vpll2		= &sdp3430_vpll2,
 };
 
 static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {

