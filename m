From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: twl6040: make pointer dmic_codec_dev static" to the asoc tree
Date: Mon, 18 Jun 2018 13:00:03 +0100
Message-ID: <E1fUspH-0008WL-AN@debutante>
References: <20180606093504.30255-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606093504.30255-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: twl6040: make pointer dmic_codec_dev static

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 510e419cb85798915c6426c496a164ec6328d1a7 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 6 Jun 2018 10:35:04 +0100
Subject: [PATCH] ASoC: twl6040: make pointer dmic_codec_dev static

The pointer dmic_codec_dev is local to the source and does not need
to be in global scope, so make it static.

Cleans up sparse warning:
warning: symbol 'dmic_codec_dev' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/omap-abe-twl6040.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 15ccbf479c96..d5ae9eb8c756 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -40,7 +40,7 @@ struct abe_twl6040 {
 	int	mclk_freq;	/* MCLK frequency speed for twl6040 */
 };
 
-struct platform_device *dmic_codec_dev;
+static struct platform_device *dmic_codec_dev;
 
 static int omap_abe_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
-- 
2.17.1
