From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ASoC: ti: Fix SDMA users not providing channel names
Date: Sun,  2 Jun 2019 16:55:49 +0200
Message-ID: <20190602145549.30899-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

McBSP used to work correctly as long as compat DMA probing, removed by
commit 642aafea8889 ("ASoC: ti: remove compat dma probing"), was
available.  New method of DMA probing apparently requires users to
provide channel names when registering with SDMA, while McBSP passes
NULLs.  Fix it.

The same probably applies to McASP (not tested), hence the patch fixes
both.

Fixes: 642aafea8889 ("ASoC: ti: remove compat dma probing")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 sound/soc/ti/davinci-mcasp.c | 2 +-
 sound/soc/ti/omap-mcbsp.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 9fbc759fdefe..f31805920e3e 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2237,7 +2237,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		ret = edma_pcm_platform_register(&pdev->dev);
 		break;
 	case PCM_SDMA:
-		ret = sdma_pcm_platform_register(&pdev->dev, NULL, NULL);
+		ret = sdma_pcm_platform_register(&pdev->dev, "tx", "rx");
 		break;
 	default:
 		dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index a395598f1f20..610c5e706fd2 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -1438,7 +1438,7 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return sdma_pcm_platform_register(&pdev->dev, NULL, NULL);
+	return sdma_pcm_platform_register(&pdev->dev, "tx", "rx");
 }
 
 static int asoc_mcbsp_remove(struct platform_device *pdev)
-- 
2.21.0
