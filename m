From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ASoC: Fix twl4030 and 6040 regression by
	adding back read and write
Date: Thu, 25 Jan 2018 09:35:05 -0800
Message-ID: <20180125173505.15810-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

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
---
 sound/soc/codecs/twl4030.c | 2 ++
 sound/soc/codecs/twl6040.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
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
2.16.0
