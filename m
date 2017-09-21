From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-asoc-card: Handle return value of devm_kasprintf" to the asoc tree
Date: Thu, 21 Sep 2017 16:55:28 +0100
Message-ID: <E1dv3p2-0006Lg-0Q@debutante>
References: <d973fbc962f750ef87c0bccf7b2df6536c8e987f.1505971045.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d973fbc962f750ef87c0bccf7b2df6536c8e987f.1505971045.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.orgalsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: fsl-asoc-card: Handle return value of devm_kasprintf

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7add71b623a2b2abc2e0947a21fb31e2c8f71e18 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 21 Sep 2017 10:50:03 +0530
Subject: [PATCH] ASoC: fsl-asoc-card: Handle return value of devm_kasprintf

devm_kasprintf() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 3772abbdd7b7..1225e0399de8 100644
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
2.14.1
