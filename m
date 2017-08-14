From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 11/11] ASoC: soc-utils: make snd_soc_platform_driver const
Date: Mon, 14 Aug 2017 17:08:50 +0530
Message-ID: <1502710730-18912-12-git-send-email-bhumirks@gmail.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, bardliao@realtek.com, chiou@realtek.com, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, yang.jie@linux.intel.com, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, plai@codeaurora.org, bgoswami@codeaurora.org, krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Make this const as it is only passed as the 2nd argument to the function
snd_soc_register_platform, which is of type const.
Done using Coccinelle

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/soc-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 644d9a9..e30aacb 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -284,7 +284,7 @@ static int dummy_dma_open(struct snd_pcm_substream *substream)
 	.ioctl		= snd_pcm_lib_ioctl,
 };
 
-static struct snd_soc_platform_driver dummy_platform = {
+static const struct snd_soc_platform_driver dummy_platform = {
 	.ops = &dummy_dma_ops,
 };
 
-- 
1.9.1
