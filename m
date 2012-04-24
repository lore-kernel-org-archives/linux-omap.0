From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/7] ARM: OMAP2: Use hwmod to initialize mmc for 2420
Date: Mon, 23 Apr 2012 17:08:35 -0700
Message-ID: <20120424000835.17783.50945.stgit@muffinssi.local>
References: <20120424000607.17783.81686.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64310 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609Ab2DXAIg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 20:08:36 -0400
In-Reply-To: <20120424000607.17783.81686.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This allows us to pass dma request lines in platform data to
MMC driver the same way as we already do for omap2430 and later.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index e433603..a2e839a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -616,7 +616,11 @@ static inline void omap242x_mmc_mux(struct omap_mmc_platform_data
 
 void __init omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
 {
-	char *name = "mmci-omap";
+	struct platform_device *pdev;
+	struct omap_hwmod *oh;
+	int id = 0;
+	char *oh_name = "mmci";
+	char *dev_name = "mmci-omap";
 
 	if (!mmc_data[0]) {
 		pr_err("%s fails: Incomplete platform data\n", __func__);
@@ -624,8 +628,17 @@ void __init omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
 	}
 
 	omap242x_mmc_mux(mmc_data[0]);
-	omap_mmc_add(name, 0, OMAP2_MMC1_BASE, OMAP2420_MMC_SIZE,
-					INT_24XX_MMC_IRQ, mmc_data[0]);
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		return;
+	}
+	pdev = omap_device_build(dev_name, id, oh, mmc_data[0],
+				 sizeof(struct omap_mmc_platform_data), NULL, 0, 0);
+	if (IS_ERR(pdev))
+		WARN(1, "Can'd build omap_device for %s:%s.\n",
+					dev_name, oh->name);
 }
 
 #endif

