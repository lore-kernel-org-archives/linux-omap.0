From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: [PATCH V2] ASoC: omap-hdmi: Use devm_snd_soc_register_component
Date: Tue,  8 Jul 2014 22:17:23 +0530
Message-ID: <1404838043-5095-1-git-send-email-badarkhe.manish@gmail.com>
References: <n>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:55837 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664AbaGHQrk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2014 12:47:40 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so7614965pac.39
        for <linux-omap@vger.kernel.org>; Tue, 08 Jul 2014 09:47:40 -0700 (PDT)
In-Reply-To: <n>
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

:100644 100644 eb9c392... 8dcd7f7... M	sound/soc/omap/omap-hdmi.c
 sound/soc/omap/omap-hdmi.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index eb9c392..8dcd7f7 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -322,8 +322,9 @@ static int omap_hdmi_probe(struct platform_device *pdev)
 	}
 
 	dev_set_drvdata(&pdev->dev, hdmi_data);
-	ret = snd_soc_register_component(&pdev->dev, &omap_hdmi_component,
-					 &omap_hdmi_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &omap_hdmi_component,
+					      &omap_hdmi_dai, 1);
 
 	if (ret)
 		return ret;
@@ -335,8 +336,6 @@ static int omap_hdmi_remove(struct platform_device *pdev)
 {
 	struct hdmi_priv *hdmi_data = dev_get_drvdata(&pdev->dev);
 
-	snd_soc_unregister_component(&pdev->dev);
-
 	if (hdmi_data == NULL) {
 		dev_err(&pdev->dev, "cannot obtain HDMi data\n");
 		return -ENODEV;
-- 
1.7.10.4

