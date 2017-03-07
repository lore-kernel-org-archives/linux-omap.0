From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap: Remove unnecessary 'out of
	memory' message" to the asoc tree
Date: Tue, 07 Mar 2017 14:33:28 +0100
Message-ID: <E1clFF2-0005ae-DD@finisterre>
References: <1488136326-3602-1-git-send-email-constantinescu33@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1488136326-3602-1-git-send-email-constantinescu33@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adriana Constantinescu <constantinescu33@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, peter.ujfalusi@ti.com, broonie@kernel.org, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: omap: Remove unnecessary 'out of memory' message

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

>From 8804e073a8b7b85e98e46a239da4d2d92adfe124 Mon Sep 17 00:00:00 2001
From: Adriana Constantinescu <constantinescu33@gmail.com>
Date: Sun, 26 Feb 2017 21:12:06 +0200
Subject: [PATCH] ASoC: omap: Remove unnecessary 'out of memory' message

Out of memory message detected using checkpatch.pl

Signed-off-by: Adriana Constantinescu <constantinescu33@gmail.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/rx51.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index a76845748a10..086b59b7b6d7 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -433,10 +433,9 @@ static int rx51_soc_probe(struct platform_device *pdev)
 	}
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (pdata == NULL) {
-		dev_err(card->dev, "failed to create private data\n");
+	if (pdata == NULL)
 		return -ENOMEM;
-	}
+
 	snd_soc_card_set_drvdata(card, pdata);
 
 	pdata->tvout_selection_gpio = devm_gpiod_get(card->dev,
-- 
2.11.0
