From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 01/11] ASoC: codecs: make snd_soc_platform_driver const
Date: Mon, 14 Aug 2017 17:08:40 +0530
Message-ID: <1502710730-18912-2-git-send-email-bhumirks@gmail.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, bardliao@realtek.com, chiou@realtek.com, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, yang.jie@linux.intel.com, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, plai@codeaurora.org, bgoswami@codeaurora.org, krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Make these const as they are either passed as the 2nd argument to the
function devm_snd_soc_register_platform or snd_soc_register_platform,
and the arguments are of type const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/codecs/cs47l24.c    | 2 +-
 sound/soc/codecs/rt5514-spi.c | 2 +-
 sound/soc/codecs/wm5102.c     | 2 +-
 sound/soc/codecs/wm5110.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index d323caa..505dbc9 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1213,7 +1213,7 @@ static struct regmap *cs47l24_get_regmap(struct device *dev)
 	.copy = wm_adsp_compr_copy,
 };
 
-static struct snd_soc_platform_driver cs47l24_compr_platform = {
+static const struct snd_soc_platform_driver cs47l24_compr_platform = {
 	.compr_ops = &cs47l24_compr_ops,
 };
 
diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 640193d..ed6e537 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -272,7 +272,7 @@ static int rt5514_spi_pcm_probe(struct snd_soc_platform *platform)
 	return 0;
 }
 
-static struct snd_soc_platform_driver rt5514_spi_platform = {
+static const struct snd_soc_platform_driver rt5514_spi_platform = {
 	.probe = rt5514_spi_pcm_probe,
 	.ops = &rt5514_spi_pcm_ops,
 };
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 1fe358e..f500692 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -2027,7 +2027,7 @@ static struct regmap *wm5102_get_regmap(struct device *dev)
 	.copy = wm_adsp_compr_copy,
 };
 
-static struct snd_soc_platform_driver wm5102_compr_platform = {
+static const struct snd_soc_platform_driver wm5102_compr_platform = {
 	.compr_ops = &wm5102_compr_ops,
 };
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 1bc9421..d6fae139 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2382,7 +2382,7 @@ static struct regmap *wm5110_get_regmap(struct device *dev)
 	.copy = wm_adsp_compr_copy,
 };
 
-static struct snd_soc_platform_driver wm5110_compr_platform = {
+static const struct snd_soc_platform_driver wm5110_compr_platform = {
 	.compr_ops = &wm5110_compr_ops,
 };
 
-- 
1.9.1
