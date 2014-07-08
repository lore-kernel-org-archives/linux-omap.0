From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: [PATCH V2] ASoC: omap-mcbsp: Use devm_snd_soc_register_component
Date: Tue,  8 Jul 2014 21:55:23 +0530
Message-ID: <1404836723-4779-1-git-send-email-badarkhe.manish@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:53664 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbaGHQ0U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2014 12:26:20 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so7540363pdi.9
        for <linux-omap@vger.kernel.org>; Tue, 08 Jul 2014 09:26:20 -0700 (PDT)
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

:100644 100644 efe2cd6... bd3ef2a... M	sound/soc/omap/omap-mcbsp.c
 sound/soc/omap/omap-mcbsp.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index efe2cd6..bd3ef2a 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -805,8 +805,9 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = snd_soc_register_component(&pdev->dev, &omap_mcbsp_component,
-					 &omap_mcbsp_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &omap_mcbsp_component,
+					      &omap_mcbsp_dai, 1);
 	if (ret)
 		return ret;
 
@@ -817,8 +818,6 @@ static int asoc_mcbsp_remove(struct platform_device *pdev)
 {
 	struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
 
-	snd_soc_unregister_component(&pdev->dev);
-
 	if (mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(mcbsp->id);
 
-- 
1.7.10.4

