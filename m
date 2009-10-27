From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH]Set omap3630 MMC1 I/O speed to 52Mhz
Date: Wed, 28 Oct 2009 04:52:05 +0530 (IST)
Message-ID: <36146.192.168.10.89.1256685725.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45038 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755442AbZJ0XWD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Oct 2009 19:22:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org

>From 43454c1812043ca6b21d2594e63c93b6250a9882 Mon Sep 17 00:00:00 2001
From: Madhu <madhu.cr@ti.com>
Date: Tue, 27 Oct 2009 17:44:09 -0400
Subject: [PATCH]Set omap3630 MMC1 I/O speed to 52Mhz

The speed ctrl bit for MMC I/O is part of CONTROL_PROG_IO1 register
in omap3630.This patch sets it up accordingly.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c         |   11 +++++++++--
 arch/arm/plat-omap/include/plat/control.h |    4 ++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 7bef170..1940591 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -213,7 +213,7 @@ static int twl4030_mmc_get_context_loss(struct device *dev)
 static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
 {
-	u32 reg;
+	u32 reg, prog_io;
 	int ret = 0;
 	struct twl_mmc_controller *c = &hsmmc[0];
 	struct omap_mmc_platform_data *mmc = dev->platform_data;
@@ -245,7 +245,14 @@ static int twl_mmc1_set_power(struct device *dev, int
slot, int power_on,
 		}

 		reg = omap_ctrl_readl(control_pbias_offset);
-		reg |= OMAP2_PBIASSPEEDCTRL0;
+		if (cpu_is_omap3630()) {
+			/* Set MMC I/O to 52Mhz */
+			prog_io = omap_ctrl_readl(OMAP34XX_CONTROL_PROG_IO1);
+			prog_io |= OMAP3630_PRG_SDMMC1_SPEEDCTRL;
+			omap_ctrl_writel(prog_io, OMAP34XX_CONTROL_PROG_IO1);
+		} else {
+			reg |= OMAP2_PBIASSPEEDCTRL0;
+		}
 		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
 		omap_ctrl_writel(reg, control_pbias_offset);

diff --git a/arch/arm/plat-omap/include/plat/control.h
b/arch/arm/plat-omap/include/plat/control.h
index fdb6300..47368bc 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -146,6 +146,7 @@
 #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
 #define OMAP343X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x02b0)
 #define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02b4)
+#define OMAP34XX_CONTROL_PROG_IO1	(OMAP2_CONTROL_GENERAL + 0x01D8)

 /* 34xx D2D idle-related pins, handled by PM core */
 #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
@@ -196,6 +197,9 @@
 #define OMAP2_PBIASLITEPWRDNZ0		(1 << 1)
 #define OMAP2_PBIASLITEVMODE0		(1 << 0)

+/* CONTROL_PROG_IO1 bits */
+#define OMAP3630_PRG_SDMMC1_SPEEDCTRL	(1 << 20)
+
 /* CONTROL_IVA2_BOOTMOD bits */
 #define OMAP3_IVA2_BOOTMOD_SHIFT	0
 #define OMAP3_IVA2_BOOTMOD_MASK		(0xf << 0)
-- 
1.6.0.4



