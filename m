From: Himangi Saraogi <himangi774@gmail.com>
Subject: [PATCH] ASoC: omap-dmic: Use devm_clk_get
Date: Fri, 11 Jul 2014 09:44:06 +0530
Message-ID: <20140711041406.GA4207@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-Id: linux-omap@vger.kernel.org

This patch introduces the use of managed interfaces like devm_clk_get
and does away with the clk_puts in the probe and remove functions. A
label is also done away with.

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
---
This is a follow up to ASoC: omap-dmic: use managed interfaces which
failed to apply as the other devm_ functions were introduced by a patch
ASoC: omap-dmic: Use devm_snd_soc_register_component.

 sound/soc/omap/omap-dmic.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index f125eb9..0f34e28 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -466,7 +466,7 @@ static int asoc_dmic_probe(struct platform_device *pdev)
 
 	mutex_init(&dmic->mutex);
 
-	dmic->fclk = clk_get(dmic->dev, "fck");
+	dmic->fclk = devm_clk_get(dmic->dev, "fck");
 	if (IS_ERR(dmic->fclk)) {
 		dev_err(dmic->dev, "cant get fck\n");
 		return -ENODEV;
@@ -475,8 +475,7 @@ static int asoc_dmic_probe(struct platform_device *pdev)
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
 	if (!res) {
 		dev_err(dmic->dev, "invalid dma memory resource\n");
-		ret = -ENODEV;
-		goto err_put_clk;
+		return -ENODEV;
 	}
 	dmic->dma_data.addr = res->start + OMAP_DMIC_DATA_REG;
 
@@ -484,34 +483,19 @@ static int asoc_dmic_probe(struct platform_device *pdev)
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
 	dmic->io_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(dmic->io_base)) {
-		ret = PTR_ERR(dmic->io_base);
-		goto err_put_clk;
-	}
+	if (IS_ERR(dmic->io_base))
+		return PTR_ERR(dmic->io_base);
 
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &omap_dmic_component,
 					      &omap_dmic_dai, 1);
 	if (ret)
-		goto err_put_clk;
+		return ret;
 
 	ret = omap_pcm_platform_register(&pdev->dev);
 	if (ret)
-		goto err_put_clk;
-
-	return 0;
-
-err_put_clk:
-	clk_put(dmic->fclk);
-	return ret;
-}
-
-static int asoc_dmic_remove(struct platform_device *pdev)
-{
-	struct omap_dmic *dmic = platform_get_drvdata(pdev);
-
-	clk_put(dmic->fclk);
+		return ret;
 
 	return 0;
 }
@@ -529,7 +513,6 @@ static struct platform_driver asoc_dmic_driver = {
 		.of_match_table = omap_dmic_of_match,
 	},
 	.probe = asoc_dmic_probe,
-	.remove = asoc_dmic_remove,
 };
 
 module_platform_driver(asoc_dmic_driver);
-- 
1.9.1
