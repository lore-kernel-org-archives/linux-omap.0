From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: [PATCH] ASoC: omap-dmic: Use devm_snd_soc_register_component
Date: Sun,  6 Jul 2014 12:20:14 +0530
Message-ID: <1404629414-3263-1-git-send-email-badarkhe.manish@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:40001 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbaGFGuk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Jul 2014 02:50:40 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so3751683pad.7
        for <linux-omap@vger.kernel.org>; Sat, 05 Jul 2014 23:50:40 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, badarkhe.manish@gmail.com

Replaced snd_soc_register_component with its devres equivalent,
devm_snd_soc_register_component.

Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>
---
:100644 100644 6925d71... 011e30e... M	sound/soc/omap/omap-dmic.c
 sound/soc/omap/omap-dmic.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 6925d71..011e30e 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -490,7 +490,7 @@ static int asoc_dmic_probe(struct platform_device *pdev)
 	}
 
 
-	ret = snd_soc_register_component(&pdev->dev, &omap_dmic_component,
+	ret = devm_snd_soc_register_component(&pdev->dev, &omap_dmic_component,
 					 &omap_dmic_dai, 1);
 	if (ret)
 		goto err_put_clk;
@@ -510,7 +510,6 @@ static int asoc_dmic_remove(struct platform_device *pdev)
 {
 	struct omap_dmic *dmic = platform_get_drvdata(pdev);
 
-	snd_soc_unregister_component(&pdev->dev);
 	clk_put(dmic->fclk);
 
 	return 0;
-- 
1.7.10.4

