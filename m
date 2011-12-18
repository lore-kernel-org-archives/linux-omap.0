From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] ARM: OMAP: fix erroneous mmc2 clock change on mmc3 setup
Date: Sun, 18 Dec 2011 02:35:47 +0200
Message-ID: <1324168547-26569-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35461 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab1LRAfx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Dec 2011 19:35:53 -0500
Received: by eekc4 with SMTP id c4so4308943eek.19
        for <linux-omap@vger.kernel.org>; Sat, 17 Dec 2011 16:35:51 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>

hsmmc23_before_set_reg() can set MMCSDIO2ADPCLKISEL bit, which
enables internal clock for MMC2. Currently this function is also called
by code handling MMC3, and if .internal_clock is set in platform data
(by default it currently is), it will set MMCSDIO2ADPCLKISEL for MMC2
instead of MMC3 (MMC3 doesn't have such bit so nothing actually needs to
be done). This breaks 2nd SD slot on pandora.

Fix this by changing hsmmc23_before_set_reg() to only handle MMC2.
Note that this removes .remux() call for MMC3, but no board currently
needs it and it's also not called for MMC4 and MMC5.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
applies both on mainline and hsmmc branch.

 arch/arm/mach-omap2/hsmmc.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index f4a1020..d90ac08 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -171,7 +171,7 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
 	}
 }
 
-static void hsmmc23_before_set_reg(struct device *dev, int slot,
+static void hsmmc2_before_set_reg(struct device *dev, int slot,
 				   int power_on, int vdd)
 {
 	struct omap_mmc_platform_data *mmc = dev->platform_data;
@@ -378,14 +378,13 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 			c->caps &= ~MMC_CAP_8_BIT_DATA;
 			c->caps |= MMC_CAP_4_BIT_DATA;
 		}
-		/* FALLTHROUGH */
-	case 3:
 		if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
 			/* off-chip level shifting, or none */
-			mmc->slots[0].before_set_reg = hsmmc23_before_set_reg;
+			mmc->slots[0].before_set_reg = hsmmc2_before_set_reg;
 			mmc->slots[0].after_set_reg = NULL;
 		}
 		break;
+	case 3:
 	case 4:
 	case 5:
 		mmc->slots[0].before_set_reg = NULL;
-- 
1.7.0.4

