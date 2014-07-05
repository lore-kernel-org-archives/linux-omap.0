From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: [PATCH] ASoC: omap-mcbsp: Use devm_snd_soc_register_component
Date: Sat,  5 Jul 2014 10:39:39 +0530
Message-ID: <1404536979-5318-1-git-send-email-badarkhe.manish@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:57378 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbaGEFJt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Jul 2014 01:09:49 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so2695394pdj.36
        for <linux-omap@vger.kernel.org>; Fri, 04 Jul 2014 22:09:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, badarkhe.manish@gmail.com

Replaced snd_soc_register_component with its devres equivalent,
devm_snd_soc_register_component.

Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>
---
:100644 100644 efe2cd6... bfc8f8e... M	sound/soc/omap/omap-mcbsp.c
 sound/soc/omap/omap-mcbsp.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index efe2cd6..bfc8f8e 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -805,7 +805,7 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = snd_soc_register_component(&pdev->dev, &omap_mcbsp_component,
+	ret = devm_snd_soc_register_component(&pdev->dev, &omap_mcbsp_component,
 					 &omap_mcbsp_dai, 1);
 	if (ret)
 		return ret;
@@ -817,8 +817,6 @@ static int asoc_mcbsp_remove(struct platform_device *pdev)
 {
 	struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
 
-	snd_soc_unregister_component(&pdev->dev);
-
 	if (mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(mcbsp->id);
 
-- 
1.7.10.4

