From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 25/28] ASoC: omap: drop owner assignment from platform_drivers
Date: Sun, 21 Dec 2014 22:14:46 +0100
Message-ID: <1419196495-9626-26-git-send-email-wsa@the-dreams.de>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

This platform_driver does not need to set an owner, it will be populated by the
driver core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Generated with coccinelle. SmPL file is in the introductory msg. The big
cleanup was pulled in this merge window. This series catches the bits fallen
through. The patches shall go in via the subsystem trees.

 sound/soc/omap/omap-hdmi-audio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-audio.c
index 3f9ac7dbdc80..ccfb41c22e53 100644
--- a/sound/soc/omap/omap-hdmi-audio.c
+++ b/sound/soc/omap/omap-hdmi-audio.c
@@ -393,7 +393,6 @@ static int omap_hdmi_audio_remove(struct platform_device *pdev)
 static struct platform_driver hdmi_audio_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.owner = THIS_MODULE,
 	},
 	.probe = omap_hdmi_audio_probe,
 	.remove = omap_hdmi_audio_remove,
-- 
2.1.3
