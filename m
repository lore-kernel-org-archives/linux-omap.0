From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 6/7] ARM: omap2: gpmc-onenand: Replace pr_err() with dev_err()
Date: Sat,  9 Feb 2013 13:38:15 -0300
Message-ID: <1360427896-12004-7-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:36643 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358Ab3BIQic (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 11:38:32 -0500
In-Reply-To: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 0ee5317..4771945 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -359,6 +359,7 @@ static int gpmc_onenand_setup(void __iomem *onenand_base, int *freq_ptr)
 void gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 {
 	int err;
+	struct device *dev = &gpmc_onenand_device.dev;
 
 	gpmc_onenand_data = _onenand_data;
 	gpmc_onenand_data->onenand_setup = gpmc_onenand_setup;
@@ -379,8 +380,8 @@ void gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 	err = gpmc_cs_request(gpmc_onenand_data->cs, ONENAND_IO_SIZE,
 				(unsigned long *)&gpmc_onenand_resource.start);
 	if (err < 0) {
-		pr_err("%s: Cannot request GPMC CS %d, error %d\n",
-		       __func__, gpmc_onenand_data->cs, err);
+		dev_err(dev, "Cannot request GPMC CS %d, error %d\n",
+			gpmc_onenand_data->cs, err);
 		return;
 	}
 
@@ -388,7 +389,7 @@ void gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 							ONENAND_IO_SIZE - 1;
 
 	if (platform_device_register(&gpmc_onenand_device) < 0) {
-		pr_err("%s: Unable to register OneNAND device\n", __func__);
+		dev_err(dev, "Unable to register OneNAND device\n");
 		gpmc_cs_free(gpmc_onenand_data->cs);
 		return;
 	}
-- 
1.7.8.6

