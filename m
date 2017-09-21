From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v2 2/3] ASoC: fsl-asoc-card: Handle return value of devm_kasprintf
Date: Thu, 21 Sep 2017 10:50:03 +0530
Message-ID: <d973fbc962f750ef87c0bccf7b2df6536c8e987f.1505971045.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

devm_kasprintf() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
               Set return 'ret' to -ENOMEM.

 sound/soc/fsl/fsl-asoc-card.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 2db4d0c..a389885 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -639,6 +639,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 				devm_kasprintf(&pdev->dev, GFP_KERNEL,
 					       "ac97-codec.%u",
 					       (unsigned int)idx);
+		if (!priv->dai_link[0].codec_name) {
+			ret = -ENOMEM;
+			goto asrc_fail;
+		}
 	}
 
 	priv->dai_link[0].platform_of_node = cpu_np;
-- 
1.9.1
