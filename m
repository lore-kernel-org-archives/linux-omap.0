From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-abe-twl6040: Use
	devm_snd_soc_register_card()" to the asoc tree
Date: Wed, 24 Aug 2016 12:20:34 +0100
Message-ID: <E1bcWEU-00009o-Uh@debutante>
References: <1471993817-10903-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1471993817-10903-1-git-send-email-weiyj.lk@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: omap-abe-twl6040: Use devm_snd_soc_register_card()

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

>From 687df1ad848102da9ea1ee8b0c64c2576ceb60f6 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Tue, 23 Aug 2016 23:10:17 +0000
Subject: [PATCH] ASoC: omap-abe-twl6040: Use devm_snd_soc_register_card()

Using devm_snd_soc_register_card() can make the code
shorter and cleaner.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/omap-abe-twl6040.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index f61b3b58083b..89fe95e877db 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -305,23 +305,14 @@ static int omap_abe_probe(struct platform_device *pdev)
 
 	snd_soc_card_set_drvdata(card, priv);
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
-		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+		dev_err(&pdev->dev, "devm_snd_soc_register_card() failed: %d\n",
 			ret);
 
 	return ret;
 }
 
-static int omap_abe_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-
-	return 0;
-}
-
 static const struct of_device_id omap_abe_of_match[] = {
 	{.compatible = "ti,abe-twl6040", },
 	{ },
@@ -335,7 +326,6 @@ static struct platform_driver omap_abe_driver = {
 		.of_match_table = omap_abe_of_match,
 	},
 	.probe = omap_abe_probe,
-	.remove = omap_abe_remove,
 };
 
 static int __init omap_abe_init(void)
-- 
2.8.1
