From: Adriana Constantinescu <constantinescu33@gmail.com>
Subject: [PATCH] ASoC: omap: Remove unnecessary 'out of memory'
	message
Date: Sun, 26 Feb 2017 21:12:06 +0200
Message-ID: <1488136326-3602-1-git-send-email-constantinescu33@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, lgirdwood@gmail.com, Adriana Constantinescu <constantinescu33@gmail.com>
List-Id: linux-omap@vger.kernel.org

Out of memory message detected using checkpatch.pl

Signed-off-by: Adriana Constantinescu <constantinescu33@gmail.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/omap/rx51.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index a768457..086b59b 100644
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
1.9.1
