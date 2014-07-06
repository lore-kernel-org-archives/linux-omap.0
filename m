From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: [PATCH] ASoC: omap-hdmi: Use devm_snd_soc_register_component
Date: Sun,  6 Jul 2014 12:19:43 +0530
Message-ID: <1404629383-3225-1-git-send-email-badarkhe.manish@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:37008 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaGFGt6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Jul 2014 02:49:58 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so3786217pac.11
        for <linux-omap@vger.kernel.org>; Sat, 05 Jul 2014 23:49:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, badarkhe.manish@gmail.com

Replaced snd_soc_register_component with its devres equivalent,
devm_snd_soc_register_component.

Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>
---
:100644 100644 eb9c392... 1dc95b5... M	sound/soc/omap/omap-hdmi.c
 sound/soc/omap/omap-hdmi.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index eb9c392..1dc95b5 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -322,7 +322,7 @@ static int omap_hdmi_probe(struct platform_device *pdev)
 	}
 
 	dev_set_drvdata(&pdev->dev, hdmi_data);
-	ret = snd_soc_register_component(&pdev->dev, &omap_hdmi_component,
+	ret = devm_snd_soc_register_component(&pdev->dev, &omap_hdmi_component,
 					 &omap_hdmi_dai, 1);
 
 	if (ret)
@@ -335,8 +335,6 @@ static int omap_hdmi_remove(struct platform_device *pdev)
 {
 	struct hdmi_priv *hdmi_data = dev_get_drvdata(&pdev->dev);
 
-	snd_soc_unregister_component(&pdev->dev);
-
 	if (hdmi_data == NULL) {
 		dev_err(&pdev->dev, "cannot obtain HDMi data\n");
 		return -ENODEV;
-- 
1.7.10.4

