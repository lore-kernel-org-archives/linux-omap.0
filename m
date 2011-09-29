From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/2] arm: omap4: hsmmc: configure SDMMC1_DR0 properly
Date: Thu, 29 Sep 2011 20:15:00 +0530
Message-ID: <1317307500-5514-3-git-send-email-balajitk@ti.com>
References: <1317307500-5514-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33293 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701Ab1I2Ooe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Sep 2011 10:44:34 -0400
In-Reply-To: <1317307500-5514-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, kishore.kadiyala@ti.com, vishp@ti.com, Balaji T K <balajitk@ti.com>

Fix the typo, instead it should be SDMMC1
USBC1 is not related to MMC1 I/Os

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/mach-omap2/hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 9cc2eb7..1a9bc52 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -495,7 +495,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 			OMAP4_SDMMC1_PUSTRENGTH_GRP1_MASK);
 		reg &= ~(OMAP4_SDMMC1_PUSTRENGTH_GRP2_MASK |
 			OMAP4_SDMMC1_PUSTRENGTH_GRP3_MASK);
-		reg |= (OMAP4_USBC1_DR0_SPEEDCTRL_MASK|
+		reg |= (OMAP4_SDMMC1_DR0_SPEEDCTRL_MASK |
 			OMAP4_SDMMC1_DR1_SPEEDCTRL_MASK |
 			OMAP4_SDMMC1_DR2_SPEEDCTRL_MASK);
 		omap4_ctrl_pad_writel(reg, control_mmc1);
-- 
1.7.0.4

