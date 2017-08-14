From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 06/11] ASoC: pxa: make snd_soc_platform_driver const
Date: Mon, 14 Aug 2017 17:08:45 +0530
Message-ID: <1502710730-18912-7-git-send-email-bhumirks@gmail.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, bardliao@realtek.com, chiou@realtek.com, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, yang.jie@linux.intel.com, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, plai@codeaurora.org, bgoswami@codeaurora.org, krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Make these const as they are only passed as the 2nd argument to the
function devm_snd_soc_register_platform, which is of type const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/pxa/mmp-pcm.c    | 2 +-
 sound/soc/pxa/pxa2xx-pcm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 5b5f1a4..38d5999 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -211,7 +211,7 @@ static int mmp_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static struct snd_soc_platform_driver mmp_soc_platform = {
+static const struct snd_soc_platform_driver mmp_soc_platform = {
 	.ops		= &mmp_pcm_ops,
 	.pcm_new	= mmp_pcm_new,
 	.pcm_free	= mmp_pcm_free_dma_buffers,
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index b51d7a0..636895a 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -84,7 +84,7 @@ static int pxa2xx_soc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static struct snd_soc_platform_driver pxa2xx_soc_platform = {
+static const struct snd_soc_platform_driver pxa2xx_soc_platform = {
 	.ops		= &pxa2xx_pcm_ops,
 	.pcm_new	= pxa2xx_soc_pcm_new,
 	.pcm_free	= pxa2xx_pcm_free_dma_buffers,
-- 
1.9.1
