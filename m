From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 3/3] ASoC: omap-hdmi-audio: Handle return value of devm_kasprintf
Date: Wed, 20 Sep 2017 15:36:11 +0530
Message-ID: <1505901971-12004-4-git-send-email-arvind.yadav.cs@gmail.com>
References: <1505901971-12004-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505901971-12004-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

devm_kasprintf() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/omap/omap-hdmi-audio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-audio.c
index 3e9cc48..8eeac7c 100644
--- a/sound/soc/omap/omap-hdmi-audio.c
+++ b/sound/soc/omap/omap-hdmi-audio.c
@@ -362,6 +362,9 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 
 	card->name = devm_kasprintf(dev, GFP_KERNEL,
 				    "HDMI %s", dev_name(ad->dssdev));
+	if (!card->name)
+		return -ENOMEM;
+
 	card->owner = THIS_MODULE;
 	card->dai_link =
 		devm_kzalloc(dev, sizeof(*(card->dai_link)), GFP_KERNEL);
-- 
1.9.1
