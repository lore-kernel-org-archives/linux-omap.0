From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc2-omap1-git 7/7] 3430SDP regulator updates
Date: Tue, 20 Jan 2009 02:54:08 -0800
Message-ID: <200901200254.08217.david-b@pacbell.net>
References: <200901200244.36238.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:44274 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756730AbZATLBW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Jan 2009 06:01:22 -0500
In-Reply-To: <200901200244.36238.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

For OMAP3430 SDP, link regulators to the appropriate MMC host adapters.

Note that when MMC1 is used in 8 bit mode (e.g. for an MMCplus card
or CE-ATA device), DAT4..DAT7 I/O uses a separate supply (VSIM).
But MMC_BUS_WIDTH_8 support isn't merged into the MMC framework.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-3430sdp.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -332,6 +332,18 @@ static struct twl4030_hsmmc_info mmc[] =
 	{}	/* Terminator */
 };
 
+static struct regulator_consumer_supply sdp3430_vmmc1_supply = {
+	.supply			= "vmmc",
+};
+
+static struct regulator_consumer_supply sdp3430_vsim_supply = {
+	.supply			= "vmmc_dat4..7",
+};
+
+static struct regulator_consumer_supply sdp3430_vmmc2_supply = {
+	.supply			= "vmmc",
+};
+
 static int sdp3430_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
@@ -342,6 +354,13 @@ static int sdp3430_twl_gpio_setup(struct
 	mmc[1].gpio_cd = gpio + 1;
 	twl4030_mmc_init(mmc);
 
+	/* link regulators to MMC adapters ... we "know" the
+	 * regulators will be set up only *after* we return.
+	 */
+	sdp3430_vmmc1_supply.dev = mmc[0].dev;
+	sdp3430_vsim_supply.dev = mmc[0].dev;
+	sdp3430_vmmc2_supply.dev = mmc[1].dev;
+
 	/* gpio + 7 is "sub_lcd_en_bkl" (output/PWM1) */
 	gpio_request(gpio + 7, "sub_lcd_en_bkl");
 	gpio_direction_output(gpio + 7, 0);
@@ -517,6 +536,8 @@ static struct regulator_init_data sdp343
 				| REGULATOR_CHANGE_MODE
 				| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &sdp3430_vmmc1_supply,
 };
 
 /* VMMC2 for MMC2 card */
@@ -530,6 +551,8 @@ static struct regulator_init_data sdp343
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &sdp3430_vmmc2_supply,
 };
 
 /* VSIM for OMAP VDD_MMC1A (i/o for DAT4..DAT7) */
@@ -541,6 +564,8 @@ static struct regulator_init_data sdp343
 				| REGULATOR_CHANGE_MODE
 				| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &sdp3430_vsim_supply,
 };
 
 /* VDAC for DSS driving S-Video */
