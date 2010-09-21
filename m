From: David Anders <x0132446@ti.com>
Subject: [PATCH 2/4] omap4: pandaboard: Fix the init if CONFIG_MMC_OMAP_HS is not set
Date: Tue, 21 Sep 2010 16:24:02 -0500
Message-ID: <1285104244-32274-3-git-send-email-x0132446@ti.com>
References: <1285104244-32274-1-git-send-email-x0132446@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55749 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756268Ab0IUVYH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 17:24:07 -0400
In-Reply-To: <1285104244-32274-1-git-send-email-x0132446@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jayabharath@ti.com, gadiyar@ti.com, vpasam@ti.com, tony@atomide.com, linux-omap@vger.kernel.org
Cc: David Anders <x0132446@ti.com>

Avoid possible crash if CONFIG_MMC_OMAP_HS is not set.

Signed-off-by: David Anders <x0132446@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 093d13b..697c0bd 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -85,7 +85,14 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 
 static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
 {
-	struct omap_mmc_platform_data *pdata = dev->platform_data;
+	struct omap_mmc_platform_data *pdata;
+
+	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
+	if (!dev) {
+		pr_err("Failed omap4_twl6030_hsmmc_set_late_init\n");
+		return;
+	}
+	pdata = dev->platform_data;
 
 	pdata->init =	omap4_twl6030_hsmmc_late_init;
 }
-- 
1.7.0.4

