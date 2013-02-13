From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH] ASoC: omap-dmic: Clean up with devm_request_and_ioremap
Date: Wed, 13 Feb 2013 08:22:07 +0100
Message-ID: <1360740127-4154-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54088 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752328Ab3BMHWY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 02:22:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Clean up dmic code with devm_request_and_ioremap function.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 sound/soc/omap/omap-dmic.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index ba49ccd..77e9e7e 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -493,16 +493,9 @@ static int asoc_dmic_probe(struct platform_device *pdev)
 		goto err_put_clk;
 	}
 
-	if (!devm_request_mem_region(&pdev->dev, res->start,
-				     resource_size(res), pdev->name)) {
-		dev_err(dmic->dev, "memory region already claimed\n");
-		ret = -ENODEV;
-		goto err_put_clk;
-	}
-
-	dmic->io_base = devm_ioremap(&pdev->dev, res->start,
-				     resource_size(res));
+	dmic->io_base = devm_request_and_ioremap(&pdev->dev, res);
 	if (!dmic->io_base) {
+		dev_err(&pdev->dev, "cannot remap\n");
 		ret = -ENOMEM;
 		goto err_put_clk;
 	}
-- 
1.7.10.4

