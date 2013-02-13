From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH] ASoC: omap-mcpdm: Clean up with devm_* function
Date: Wed, 13 Feb 2013 08:21:54 +0100
Message-ID: <1360740114-4117-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41455 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab3BMHWN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 02:22:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Clean up McPDM driver with devm_ function.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 sound/soc/omap/omap-mcpdm.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 5ca11bd..079f277 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -369,7 +369,7 @@ static int omap_mcpdm_probe(struct snd_soc_dai *dai)
 	pm_runtime_get_sync(mcpdm->dev);
 	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, 0x00);
 
-	ret = request_irq(mcpdm->irq, omap_mcpdm_irq_handler,
+	ret = devm_request_irq(mcpdm->dev, mcpdm->irq, omap_mcpdm_irq_handler,
 				0, "McPDM", (void *)mcpdm);
 
 	pm_runtime_put_sync(mcpdm->dev);
@@ -389,7 +389,6 @@ static int omap_mcpdm_remove(struct snd_soc_dai *dai)
 {
 	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
 
-	free_irq(mcpdm->irq, (void *)mcpdm);
 	pm_runtime_disable(mcpdm->dev);
 
 	return 0;
@@ -465,14 +464,11 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)
 	if (res == NULL)
 		return -ENOMEM;
 
-	if (!devm_request_mem_region(&pdev->dev, res->start,
-				     resource_size(res), "McPDM"))
-		return -EBUSY;
-
-	mcpdm->io_base = devm_ioremap(&pdev->dev, res->start,
-				      resource_size(res));
-	if (!mcpdm->io_base)
+	mcpdm->io_base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!mcpdm->io_base) {
+		dev_err(&pdev->dev, "cannot remap\n");
 		return -ENOMEM;
+	}
 
 	mcpdm->irq = platform_get_irq(pdev, 0);
 	if (mcpdm->irq < 0)
-- 
1.7.10.4

