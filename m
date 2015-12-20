From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 2/4] ASoC: omap-hdmi-audio: add NULL test
Date: Sun, 20 Dec 2015 12:15:51 +0100
Message-ID: <1450610153-7746-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1450610153-7746-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450610153-7746-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: kernel-janitors@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add NULL test on call to devm_kzalloc.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x;
identifier fld;
@@

* x = devm_kzalloc(...);
  ... when != x == NULL
  x->fld
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/omap/omap-hdmi-audio.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-audio.c
index 584b237..f83cc2b 100644
--- a/sound/soc/omap/omap-hdmi-audio.c
+++ b/sound/soc/omap/omap-hdmi-audio.c
@@ -368,6 +368,8 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 	card->owner = THIS_MODULE;
 	card->dai_link =
 		devm_kzalloc(dev, sizeof(*(card->dai_link)), GFP_KERNEL);
+	if (!card->dai_link)
+		return -ENOMEM;
 	card->dai_link->name = card->name;
 	card->dai_link->stream_name = card->name;
 	card->dai_link->cpu_dai_name = dev_name(ad->dssdev);
