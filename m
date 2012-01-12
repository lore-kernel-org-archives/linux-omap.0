From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] ARM: OMAP: fix MMC2 loopback clock handling
Date: Thu, 12 Jan 2012 16:26:45 +0200
Message-ID: <1326378405-27632-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56052 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab2ALO1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jan 2012 09:27:00 -0500
Received: by eaal12 with SMTP id l12so657502eaa.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 06:26:59 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grazvydas Ignotas <notasas@gmail.com>

Currently MMC2 setup code can only enable loopback clock and
relies on reset value for boards that need to have it disabled.
This causes a problem with certain bootloaders that always enable
that clock, resulting with unwanted bootloader dependencies.

Fix this by making it disable the clock if board data says so.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
depends on "ARM: OMAP: fix erroneous mmc2 clock change on mmc3 setup"
http://marc.info/?l=linux-omap&m=132416866125291&w=2

 arch/arm/mach-omap2/hsmmc.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 8658bd7..ad0adb5 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -175,11 +175,12 @@ static void hsmmc2_select_input_clk_src(struct omap_mmc_platform_data *mmc)
 {
 	u32 reg;
 
-	if (mmc->slots[0].internal_clock) {
-		reg = omap_ctrl_readl(control_devconf1_offset);
+	reg = omap_ctrl_readl(control_devconf1_offset);
+	if (mmc->slots[0].internal_clock)
 		reg |= OMAP2_MMCSDIO2ADPCLKISEL;
-		omap_ctrl_writel(reg, control_devconf1_offset);
-	}
+	else
+		reg &= ~OMAP2_MMCSDIO2ADPCLKISEL;
+	omap_ctrl_writel(reg, control_devconf1_offset);
 }
 
 static void hsmmc2_before_set_reg(struct device *dev, int slot,
-- 
1.7.0.4

