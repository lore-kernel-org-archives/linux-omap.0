From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv3 1/6] ALSA: pcm: Export soc_dpcm_runtime_update
Date: Tue, 25 Jul 2017 17:10:25 +0200
Message-ID: <20170725151030.26863-2-sebastian.reichel@collabora.co.uk>
References: <20170725151030.26863-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725151030.26863-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

Some codecs may need to use this from loadable modules. Without
this patch compilation for this kind of codec will fail with the
following error:

ERROR: "soc_dpcm_runtime_update" [sound/soc/codecs/snd-soc-cpcap.ko]
undefined!

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 sound/soc/soc-pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index dcc5ece08668..4de7d86ea6fb 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2539,6 +2539,8 @@ int soc_dpcm_runtime_update(struct snd_soc_card *card)
 	mutex_unlock(&card->mutex);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(soc_dpcm_runtime_update);
+
 int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
 {
 	struct snd_soc_dpcm *dpcm;
-- 
2.13.2
