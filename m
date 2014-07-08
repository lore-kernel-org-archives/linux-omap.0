From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: [PATCH V2] ASoC: omap-dmic: Use devm_snd_soc_register_component
Date: Tue,  8 Jul 2014 22:23:17 +0530
Message-ID: <1404838397-5309-1-git-send-email-badarkhe.manish@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:56474 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbaGHQxd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2014 12:53:33 -0400
Received: by mail-pa0-f44.google.com with SMTP id rd3so7639199pab.17
        for <linux-omap@vger.kernel.org>; Tue, 08 Jul 2014 09:53:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, badarkhe.manish@gmail.com

Replaced snd_soc_register_component with its devres equivalent,
devm_snd_soc_register_component.

Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>
---
Changes since V1:
        Aligned function parameter properly.

:100644 100644 6925d71... f125eb9... M	sound/soc/omap/omap-dmic.c
 sound/soc/omap/omap-dmic.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 6925d71..f125eb9 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -490,8 +490,9 @@ static int asoc_dmic_probe(struct platform_device *pdev)
 	}
 
 
-	ret = snd_soc_register_component(&pdev->dev, &omap_dmic_component,
-					 &omap_dmic_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &omap_dmic_component,
+					      &omap_dmic_dai, 1);
 	if (ret)
 		goto err_put_clk;
 
@@ -510,7 +511,6 @@ static int asoc_dmic_remove(struct platform_device *pdev)
 {
 	struct omap_dmic *dmic = platform_get_drvdata(pdev);
 
-	snd_soc_unregister_component(&pdev->dev);
 	clk_put(dmic->fclk);
 
 	return 0;
-- 
1.7.10.4

