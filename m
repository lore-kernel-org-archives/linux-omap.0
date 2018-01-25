From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Fix twl4030 and 6040 regression by adding back read and write" to the asoc tree
Date: Thu, 25 Jan 2018 18:50:43 +0000
Message-ID: <E1eembj-0004cF-H1@debutante>
References: <20180125173505.15810-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180125173505.15810-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, linux-omap@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: Fix twl4030 and 6040 regression by adding back read and write

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

>From 8146acff3b80327f2a23710f2674a79a7fa80de3 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 25 Jan 2018 09:35:05 -0800
Subject: [PATCH] ASoC: Fix twl4030 and 6040 regression by adding back read and
 write

Commit 3bb0f7c31b1a ("ASoC: don't use snd_soc_write/read on twl4030")
caused regressions for both twl4030 and twl6040 as it assumes the
ASoC driver is using regmap. As a side effect, this also causes a
considerable increase in idle power consumption omap3 boards using
twl4030 as the PMIC.

This is because the removal of read and write function pointers
causes some of the ASoC IO functions to not do anything. For example,
snd_soc_register_card() calls snd_soc_dapm_new_widgets() that calls
snd_soc_codec_drv_read() that now does nothing.

A long term solution suggested by Mark Brown <broonie@kernel.org>
is to make the twl drivers use regmap by adding a call to
snd_soc_codec_set_regmap(). This however needs more consideration
as currently the driver internal reads do caching and we would have
both regmap access and internal read/write access accessing the same
hardware registers.

So to fix the regression, let's just do a partial revert adding back
the read and write function pointers. Note that other non-regmap
ASoC drivers may need similar patches.

Fixes: 3bb0f7c31b1a ("ASoC: don't use snd_soc_write/read on twl4030")
Fixes: 93a00c467fe9 ("ASoC: don't use snd_soc_write/read on twl6040")
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/twl4030.c | 2 ++
 sound/soc/codecs/twl6040.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 8798182959c1..e4d7f397d361 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2195,6 +2195,8 @@ static int twl4030_soc_remove(struct snd_soc_codec *codec)
 static const struct snd_soc_codec_driver soc_codec_dev_twl4030 = {
 	.probe = twl4030_soc_probe,
 	.remove = twl4030_soc_remove,
+	.read = twl4030_read,
+	.write = twl4030_write,
 	.set_bias_level = twl4030_set_bias_level,
 	.idle_bias_off = true,
 
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 3b895b4b451c..573a523ed0b3 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1158,6 +1158,8 @@ static int twl6040_remove(struct snd_soc_codec *codec)
 static const struct snd_soc_codec_driver soc_codec_dev_twl6040 = {
 	.probe = twl6040_probe,
 	.remove = twl6040_remove,
+	.read = twl6040_read,
+	.write = twl6040_write,
 	.set_bias_level = twl6040_set_bias_level,
 	.suspend_bias_off = true,
 	.ignore_pmdown_time = true,
-- 
2.15.1
