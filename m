From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v2] omap4: pandaboard: fix up mmc card detect logic
Date: Tue, 19 Oct 2010 09:50:25 -0500
Message-ID: <1287499825-24988-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34313 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791Ab0JSOum (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 10:50:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: l-a <linux-arm-kernel@lists.infradead.org>, "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, Samuel Ortiz <sameo@linux.intel.com>

From: Menon, Nishanth <nm@ti.com>

For MMC1 Controller, card detect interrupt source is
twl6030 which is non-gpio. The card detect call back function provides
card present/absent status by reading MMC Control register present
on twl6030. This functionality was introduced in mfd tree on
track to kernel.org

Sync pandaboard to the same and make mmc work.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>

Acked-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Tested-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
v2: reposting to l-a, l-o
Depends on 
http://git.kernel.org/?p=linux/kernel/git/sameo/mfd-2.6.git;a=commitdiff;h=1bf5197061a4aec99e9fd4f92d4a543310f83585;hp=0c9b33e5a23e2053165c9e30ffff3b3a3cf1b2b8
Discussion:
http://marc.info/?t=128714921300007&r=1&w=2

 arch/arm/mach-omap2/board-omap4panda.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 702f2a6..1ecd0a6 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -160,10 +160,19 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 				struct platform_device, dev);
 	struct omap_mmc_platform_data *pdata = dev->platform_data;
 
+	if (!pdata) {
+		dev_err(dev, "%s: NULL platform data\n", __func__);
+		return -EINVAL;
+	}
 	/* Setting MMC1 Card detect Irq */
-	if (pdev->id == 0)
-		pdata->slots[0].card_detect_irq = TWL6030_IRQ_BASE +
-						MMCDETECT_INTR_OFFSET;
+	if (pdev->id == 0) {
+		ret = twl6030_mmc_card_detect_config();
+		 if (ret)
+			dev_err(dev, "%s: Error card detect config(%d)\n",
+				__func__, ret);
+		 else
+			pdata->slots[0].card_detect = twl6030_mmc_card_detect;
+	}
 	return ret;
 }
 
-- 
1.6.3.3

