From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Handle return value of devm_kasprintf" to the asoc tree
Date: Thu, 21 Sep 2017 16:55:48 +0100
Message-ID: <E1dv3pM-0006Oy-DZ@debutante>
References: <1505901971-12004-2-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505901971-12004-2-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.competer.ujfalusi@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.orgalsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: davinci-mcasp: Handle return value of devm_kasprintf

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

>From 0c8b794c4a10aaf7ac0d4a49be2b2638e2038adb Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 20 Sep 2017 15:36:09 +0530
Subject: [PATCH] ASoC: davinci-mcasp: Handle return value of devm_kasprintf

devm_kasprintf() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 40be08cecea4..804c6f2bcf21 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1868,6 +1868,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (irq >= 0) {
 		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_common",
 					  dev_name(&pdev->dev));
+		if (!irq_name) {
+			ret = -ENOMEM;
+			goto err;
+		}
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						davinci_mcasp_common_irq_handler,
 						IRQF_ONESHOT | IRQF_SHARED,
@@ -1885,6 +1889,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (irq >= 0) {
 		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_rx",
 					  dev_name(&pdev->dev));
+		if (!irq_name) {
+			ret = -ENOMEM;
+			goto err;
+		}
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						davinci_mcasp_rx_irq_handler,
 						IRQF_ONESHOT, irq_name, mcasp);
@@ -1900,6 +1908,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (irq >= 0) {
 		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_tx",
 					  dev_name(&pdev->dev));
+		if (!irq_name) {
+			ret = -ENOMEM;
+			goto err;
+		}
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						davinci_mcasp_tx_irq_handler,
 						IRQF_ONESHOT, irq_name, mcasp);
-- 
2.14.1
