From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc2-omap1-git 6/7] beagle regulator updates
Date: Tue, 20 Jan 2009 02:53:10 -0800
Message-ID: <200901200253.10350.david-b@pacbell.net>
References: <200901200244.36238.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:44272 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756770AbZATLBV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Jan 2009 06:01:21 -0500
In-Reply-To: <200901200244.36238.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

For Beagle, link two regulators to the MMC-1 host adapter.

Note:  when MMC1 is used in 8 bit mode (e.g. for an MMCplus card)
DAT4..DAT7 I/O uses a separate supply (VSIM).  But MMC_BUS_WIDTH_8
support isn't yet merged into the MMC framework.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -126,6 +126,14 @@ static struct twl4030_hsmmc_info mmc[] =
 	{}	/* Terminator */
 };
 
+static struct regulator_consumer_supply beagle_vmmc1_supply = {
+	.supply			= "vmmc",
+};
+
+static struct regulator_consumer_supply beagle_vsim_supply = {
+	.supply			= "vmmc_dat4..7",
+};
+
 static struct gpio_led gpio_leds[];
 
 static int beagle_twl_gpio_setup(struct device *dev,
@@ -136,6 +144,10 @@ static int beagle_twl_gpio_setup(struct 
 	mmc[0].gpio_cd = gpio + 0;
 	twl4030_mmc_init(mmc);
 
+	/* link regulators to MMC adapters */
+	beagle_vmmc1_supply.dev = mmc[0].dev;
+	beagle_vsim_supply.dev = mmc[0].dev;
+
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
 	 */
@@ -173,6 +185,8 @@ static struct regulator_init_data beagle
 				| REGULATOR_CHANGE_MODE
 				| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &beagle_vmmc1_supply,
 };
 
 /* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
@@ -184,6 +198,8 @@ static struct regulator_init_data beagle
 				| REGULATOR_CHANGE_MODE
 				| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &beagle_vsim_supply,
 };
 
 /* VDAC for DSS driving S-Video (8 mA unloaded, max 65 mA) */
