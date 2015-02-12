From: Kiran Padwal <kiran.padwal@smartplayin.com>
Subject: [PATCH] ASoC: omap-hdmi-audio: Add missing error check for devm_kzalloc
Date: Thu, 12 Feb 2015 14:38:02 +0530
Message-ID: <1423732082-23815-1-git-send-email-kiran.padwal@smartplayin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kiran Padwal <kiran.padwal21@gmail.com>, Kiran Padwal <kiran.padwal@smartplayin.com>
List-Id: linux-omap@vger.kernel.org

This patch add a missing check on the return value of devm_kzalloc,
which would cause a NULL pointer dereference in a OOM situation.

Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
---
 sound/soc/omap/omap-hdmi-audio.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-audio.c
index ccfb41c..f7eb42a 100644
--- a/sound/soc/omap/omap-hdmi-audio.c
+++ b/sound/soc/omap/omap-hdmi-audio.c
@@ -352,6 +352,9 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 		return ret;
 
 	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+
 	card->name = devm_kasprintf(dev, GFP_KERNEL,
 				    "HDMI %s", dev_name(ad->dssdev));
 	card->owner = THIS_MODULE;
-- 
1.7.9.5
