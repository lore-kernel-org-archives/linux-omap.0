From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 07/11] ASoC: qcom: make snd_soc_platform_driver const
Date: Mon, 14 Aug 2017 17:08:46 +0530
Message-ID: <1502710730-18912-8-git-send-email-bhumirks@gmail.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, bardliao@realtek.com, chiou@realtek.com, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, yang.jie@linux.intel.com, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, plai@codeaurora.org, bgoswami@codeaurora.org, krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Make this const as it is only passed as the 2nd argument to the
function devm_snd_soc_register_platform, which is of type const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/qcom/lpass-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 7aabf08..fb3576a 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -557,7 +557,7 @@ static void lpass_platform_pcm_free(struct snd_pcm *pcm)
 	}
 }
 
-static struct snd_soc_platform_driver lpass_platform_driver = {
+static const struct snd_soc_platform_driver lpass_platform_driver = {
 	.pcm_new	= lpass_platform_pcm_new,
 	.pcm_free	= lpass_platform_pcm_free,
 	.ops		= &lpass_platform_pcm_ops,
-- 
1.9.1
