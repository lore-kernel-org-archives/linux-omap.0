From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/10] omap1: mmc: Add platform init for omap7xx
Date: Wed, 11 Nov 2009 19:02:30 -0800
Message-ID: <20091112030230.5159.72386.stgit@localhost>
References: <20091112025802.5159.97598.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58520 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760033AbZKLDC0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 22:02:26 -0500
In-Reply-To: <20091112025802.5159.97598.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Cory Maccarrone <darkstar6262@gmail.com>

From: Cory Maccarrone <darkstar6262@gmail.com>

The MMC mux pins normally used by omap chips in devices.c
are different from what is needed by omap7xx chips.  This
change adds a conditional around the mux setup code to
enable the correct mux pins.

The omap730 and omap850 both use a different clock for the "fck"
clock of the MMC interface than other omap processors based on the
SOFT_REQ_REG, pin 12.  The "ick" clock is the same as that used
by other omap processors.

* Added the missing clock definition as mmc3_ck to clock.h
* Added the clock definition to omap_clks in clock.c
* Added CK_7XX to the mmci-omap.0 "ick" clock already in clock.c

With these changes, it is now possible to initialize and use MMC
cards with omap730 and omap850 devices.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/clock.c           |    3 ++-
 arch/arm/mach-omap1/clock.h           |   12 ++++++++++++
 arch/arm/mach-omap1/devices.c         |   15 +++++++++++----
 arch/arm/mach-omap1/mux.c             |    5 +++++
 arch/arm/plat-omap/include/plat/mux.h |    5 +++++
 5 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index b4fec9a..7b146c0 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -125,7 +125,8 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"bclk",		&bclk_1510,	CK_1510 | CK_310),
 	CLK(NULL,	"bclk",		&bclk_16xx,	CK_16XX),
 	CLK("mmci-omap.0", "fck",	&mmc1_ck,	CK_16XX | CK_1510 | CK_310),
-	CLK("mmci-omap.0", "ick",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK("mmci-omap.0", "fck",	&mmc3_ck,	CK_7XX),
+	CLK("mmci-omap.0", "ick",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	CLK("mmci-omap.1", "fck",	&mmc2_ck,	CK_16XX),
 	CLK("mmci-omap.1", "ick",	&armper_ck.clk,	CK_16XX),
 	/* Virtual clocks */
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 17f8742..fac921c 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -637,6 +637,18 @@ static struct clk mmc2_ck = {
 	.enable_bit	= 20,
 };
 
+static struct clk mmc3_ck = {
+	.name		= "mmc_ck",
+	.id		= 2,
+	.ops		= &clkops_generic,
+	/* Functional clock is direct from ULPD, interface clock is ARMPER */
+	.parent		= &armper_ck.clk,
+	.rate		= 48000000,
+	.flags		= RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
+	.enable_bit	= 12,
+};
+
 static struct clk virtual_ck_mpu = {
 	.name		= "mpu",
 	.ops		= &clkops_null,
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 6d2f72d..23ded2d 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -108,15 +108,22 @@ static inline void omap1_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			int controller_nr)
 {
 	if (controller_nr == 0) {
-		omap_cfg_reg(MMC_CMD);
-		omap_cfg_reg(MMC_CLK);
-		omap_cfg_reg(MMC_DAT0);
+		if (cpu_is_omap7xx()) {
+			omap_cfg_reg(MMC_7XX_CMD);
+			omap_cfg_reg(MMC_7XX_CLK);
+			omap_cfg_reg(MMC_7XX_DAT0);
+		} else {
+			omap_cfg_reg(MMC_CMD);
+			omap_cfg_reg(MMC_CLK);
+			omap_cfg_reg(MMC_DAT0);
+		}
+
 		if (cpu_is_omap1710()) {
 			omap_cfg_reg(M15_1710_MMC_CLKI);
 			omap_cfg_reg(P19_1710_MMC_CMDDIR);
 			omap_cfg_reg(P20_1710_MMC_DATDIR0);
 		}
-		if (mmc_controller->slots[0].wires == 4) {
+		if (mmc_controller->slots[0].wires == 4 && !cpu_is_omap7xx()) {
 			omap_cfg_reg(MMC_DAT1);
 			/* NOTE: DAT2 can be on W10 (here) or M15 */
 			if (!mmc_controller->slots[0].nomux)
diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 1e6145c..785371e 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -51,6 +51,11 @@ MUX_CFG_7XX("E3_7XX_KBC4",        13,   25,    0,   24,   1, 0)
 MUX_CFG_7XX("AA17_7XX_USB_DM",     2,   21,    0,   20,   0, 0)
 MUX_CFG_7XX("W16_7XX_USB_PU_EN",   2,   25,    0,   24,   0, 0)
 MUX_CFG_7XX("W17_7XX_USB_VBUSI",   2,   29,    0,   28,   0, 0)
+
+/* MMC Pins */
+MUX_CFG_7XX("MMC_7XX_CMD",         2,    9,    0,    8,   1, 0)
+MUX_CFG_7XX("MMC_7XX_CLK",         2,   13,    0,   12,   1, 0)
+MUX_CFG_7XX("MMC_7XX_DAT0",        2,   17,    0,   16,   1, 0)
 };
 #define OMAP7XX_PINS_SZ		ARRAY_SIZE(omap7xx_pins)
 #else
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index f3c1d8a..56e357e 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -219,6 +219,11 @@ enum omap7xx_index {
 	AA17_7XX_USB_DM,
 	W16_7XX_USB_PU_EN,
 	W17_7XX_USB_VBUSI,
+
+	/* MMC */
+	MMC_7XX_CMD,
+	MMC_7XX_CLK,
+	MMC_7XX_DAT0,
 };
 
 enum omap1xxx_index {

