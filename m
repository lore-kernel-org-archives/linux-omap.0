From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 1/2] HSMMC: Make loopback clock configurable
Date: Thu, 13 Nov 2008 23:40:04 +0200
Message-ID: <1226612405-7175-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:43490 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbYKMVkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 16:40:20 -0500
Received: by gv-out-0910.google.com with SMTP id e6so251796gvc.37
        for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 13:40:18 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>

Some boards use input clock from external pin for MMC/SDIO
modules in OMAP chips. Make that option selectable instead of
forcing loop back clock on everyone.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
This patch applies on previous patch I sent:
"minor mmc-twl4030 cleanups"

 arch/arm/mach-omap2/mmc-twl4030.c |   14 ++++++++------
 arch/arm/mach-omap2/mmc-twl4030.h |    1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index b1fe0f3..0ea6ba6 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -250,8 +250,7 @@ static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
 			omap_ctrl_writel(reg, OMAP243X_CONTROL_DEVCONF1);
 		}
 
-		/* REVISIT: Loop back clock not needed for 2430? */
-		if (!cpu_is_omap2430()) {
+		if (c->mmc->slots[0].internal_clock) {
 			reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
 			reg |= OMAP2_MMCSDIO1ADPCLKISEL;
 			omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
@@ -298,11 +297,13 @@ static int twl_mmc2_set_power(struct device *dev, int slot, int power_on, int vd
 	struct twl_mmc_controller *c = &hsmmc[1];
 
 	if (power_on) {
-		u32 reg;
+		if (c->mmc->slots[0].internal_clock) {
+			u32 reg;
 
-		reg = omap_ctrl_readl(control_devconf1_offset);
-		reg |= OMAP2_MMCSDIO2ADPCLKISEL;
-		omap_ctrl_writel(reg, control_devconf1_offset);
+			reg = omap_ctrl_readl(control_devconf1_offset);
+			reg |= OMAP2_MMCSDIO2ADPCLKISEL;
+			omap_ctrl_writel(reg, control_devconf1_offset);
+		}
 		ret = twl_mmc_set_voltage(c, vdd);
 	} else {
 		ret = twl_mmc_set_voltage(c, 0);
@@ -354,6 +355,7 @@ void __init hsmmc_init(struct twl4030_hsmmc_info *controllers)
 					MMC_VDD_29_30 |
 					MMC_VDD_30_31 | MMC_VDD_31_32;
 		mmc->slots[0].wires = c->wires;
+		mmc->slots[0].internal_clock = !c->ext_clock;
 		mmc->dma_mask = 0xffffffff;
 
 		/* note: twl4030 card detect GPIOs normally switch VMMCx ... */
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
index a2e60fe..e2d58a2 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -11,6 +11,7 @@ struct twl4030_hsmmc_info {
 	u8	wires;		/* 1/4/8 wires */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
+	int	ext_clock:1;	/* use external pin for input clock */
 };
 
 #if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
-- 
1.5.4.3

