From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 02/14] MFD: twl4030-audio: Convert to use
	devm_kzalloc
Date: Tue, 14 Aug 2012 17:22:30 +0300
Message-ID: <1344954162-7985-3-git-send-email-peter.ujfalusi@ti.com>
References: <1344954162-7985-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1344954162-7985-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl4030-audio.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index ac04b4f..efa2d42 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -188,7 +188,8 @@ static int __devinit twl4030_audio_probe(struct platform_device *pdev)
 	twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
 					val, TWL4030_REG_APLL_CTL);
 
-	audio = kzalloc(sizeof(struct twl4030_audio), GFP_KERNEL);
+	audio = devm_kzalloc(&pdev->dev, sizeof(struct twl4030_audio),
+			     GFP_KERNEL);
 	if (!audio)
 		return -ENOMEM;
 
@@ -229,22 +230,18 @@ static int __devinit twl4030_audio_probe(struct platform_device *pdev)
 		ret = -ENODEV;
 	}
 
-	if (!ret)
-		return 0;
+	if (ret) {
+		platform_set_drvdata(pdev, NULL);
+		twl4030_audio_dev = NULL;
+	}
 
-	platform_set_drvdata(pdev, NULL);
-	kfree(audio);
-	twl4030_audio_dev = NULL;
 	return ret;
 }
 
 static int __devexit twl4030_audio_remove(struct platform_device *pdev)
 {
-	struct twl4030_audio *audio = platform_get_drvdata(pdev);
-
 	mfd_remove_devices(&pdev->dev);
 	platform_set_drvdata(pdev, NULL);
-	kfree(audio);
 	twl4030_audio_dev = NULL;
 
 	return 0;
-- 
1.7.8.6
