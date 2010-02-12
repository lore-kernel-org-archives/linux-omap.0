From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/19] omap: RX51: Remux to pull eMMC lines down when powering
	off
Date: Thu, 11 Feb 2010 16:51:20 -0800
Message-ID: <20100212005120.24958.80835.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53569 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757718Ab0BLAuj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 19:50:39 -0500
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

From: Adrian Hunter <adrian.hunter@nokia.com>

It has been discovered that, when eMMC is powered off, current
will flow from OMAP eMMC data pull-ups to the eMMC voltage supply.
Configuring pads for OMAP off-mode does not help because eMMC is
powered off independently of OMAP off-mode.  Hence the pads are
now re-configured when eMMC is powered on or off.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   43 +++++++++++++++++++++++++-
 arch/arm/mach-omap2/hsmmc.c                  |    8 +++++
 arch/arm/mach-omap2/hsmmc.h                  |    2 +
 arch/arm/plat-omap/include/plat/mmc.h        |    1 +
 4 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index ab07ca2..4377a4c 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -209,6 +209,46 @@ static struct twl4030_madc_platform_data rx51_madc_data = {
 	.irq_line		= 1,
 };
 
+/* Enable input logic and pull all lines up when eMMC is on. */
+static struct omap_board_mux rx51_mmc2_on_mux[] = {
+	OMAP3_MUX(SDMMC2_CMD, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT0, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT1, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT2, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT3, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT4, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT5, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT6, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT7, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+
+/* Disable input logic and pull all lines down when eMMC is off. */
+static struct omap_board_mux rx51_mmc2_off_mux[] = {
+	OMAP3_MUX(SDMMC2_CMD, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT0, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT1, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT2, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT3, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT4, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT5, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT6, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT7, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+
+/*
+ * Current flows to eMMC when eMMC is off and the data lines are pulled up,
+ * so pull them down. N.B. we pull 8 lines because we are using 8 lines.
+ */
+static void rx51_mmc2_remux(struct device *dev, int slot, int power_on)
+{
+	if (power_on)
+		omap_mux_write_array(rx51_mmc2_on_mux);
+	else
+		omap_mux_write_array(rx51_mmc2_off_mux);
+}
+
 static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "external",
@@ -222,11 +262,12 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "internal",
 		.mmc		= 2,
-		.wires		= 8,
+		.wires		= 8, /* See also rx51_mmc2_remux */
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.nonremovable	= true,
 		.power_saving	= true,
+		.remux		= rx51_mmc2_remux,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index cc7e77f..4a05c37 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -48,6 +48,9 @@ static void hsmmc1_before_set_reg(struct device *dev, int slot,
 	u32 reg, prog_io;
 	struct omap_mmc_platform_data *mmc = dev->platform_data;
 
+	if (mmc->slots[0].remux)
+		mmc->slots[0].remux(dev, slot, power_on);
+
 	/*
 	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
 	 * card with Vcc regulator (from twl4030 or whatever).  OMAP has both
@@ -121,6 +124,9 @@ static void hsmmc23_before_set_reg(struct device *dev, int slot,
 {
 	struct omap_mmc_platform_data *mmc = dev->platform_data;
 
+	if (mmc->slots[0].remux)
+		mmc->slots[0].remux(dev, slot, power_on);
+
 	if (power_on) {
 		/* Only MMC2 supports a CLKIN */
 		if (mmc->slots[0].internal_clock) {
@@ -185,6 +191,8 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		mmc->slots[0].switch_pin = c->gpio_cd;
 		mmc->slots[0].gpio_wp = c->gpio_wp;
 
+		mmc->slots[0].remux = c->remux;
+
 		if (c->cover_only)
 			mmc->slots[0].cover = 1;
 
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index e946b5f..f641f59 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -19,6 +19,8 @@ struct omap2_hsmmc_info {
 	char	*name;		/* or NULL for default */
 	struct device *dev;	/* returned: pointer to mmc adapter */
 	int	ocr_mask;	/* temporary HACK */
+	/* Remux (pad configuation) when powering on/off */
+	void (*remux)(struct device *dev, int slot, int power_on);
 };
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 515701b..8b23d32 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -105,6 +105,7 @@ struct omap_mmc_platform_data {
 		int (*get_ro)(struct device *dev, int slot);
 		int (*set_sleep)(struct device *dev, int slot, int sleep,
 				 int vdd, int cardsleep);
+		void (*remux)(struct device *dev, int slot, int power_on);
 		/* Call back before enabling / disabling regulators */
 		void (*before_set_reg)(struct device *dev, int slot,
 				       int power_on, int vdd);

