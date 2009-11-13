From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/14] omap3630: Set omap3630 MMC1 I/O speed to 52Mhz
Date: Thu, 12 Nov 2009 16:08:58 -0800
Message-ID: <20091113000858.9034.26488.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52486 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590AbZKMAIx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 19:08:53 -0500
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Madhusudhan Chikkature <madhu.cr@ti.com>

From: Madhu <madhu.cr@ti.com>

The speed ctrl bit for MMC I/O is part of CONTROL_PROG_IO1 register
in omap3630.This patch sets it up accordingly.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c         |   11 +++++++++--
 arch/arm/plat-omap/include/plat/control.h |    3 +++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 7bef170..0c3c72d 100644
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
@@ -245,7 +245,14 @@ static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
 		}
 
 		reg = omap_ctrl_readl(control_pbias_offset);
-		reg |= OMAP2_PBIASSPEEDCTRL0;
+		if (cpu_is_omap3630()) {
+			/* Set MMC I/O to 52Mhz */
+			prog_io = omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
+			prog_io |= OMAP3630_PRG_SDMMC1_SPEEDCTRL;
+			omap_ctrl_writel(prog_io, OMAP343X_CONTROL_PROG_IO1);
+		} else {
+			reg |= OMAP2_PBIASSPEEDCTRL0;
+		}
 		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
 		omap_ctrl_writel(reg, control_pbias_offset);
 
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index 79985e4..2ae8843 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -241,6 +241,9 @@
 #define OMAP2_PBIASLITEPWRDNZ0		(1 << 1)
 #define OMAP2_PBIASLITEVMODE0		(1 << 0)
 
+/* CONTROL_PROG_IO1 bits */
+#define OMAP3630_PRG_SDMMC1_SPEEDCTRL	(1 << 20)
+
 /* CONTROL_IVA2_BOOTMOD bits */
 #define OMAP3_IVA2_BOOTMOD_SHIFT	0
 #define OMAP3_IVA2_BOOTMOD_MASK		(0xf << 0)

