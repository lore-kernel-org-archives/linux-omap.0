From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 03/14] MFD: twl4030-audio: Rearange and clean-up the probe
 function
Date: Tue, 14 Aug 2012 17:22:31 +0300
Message-ID: <1344954162-7985-4-git-send-email-peter.ujfalusi@ti.com>
References: <1344954162-7985-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1344954162-7985-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

To facilitate the device tree support the probe function need to be rearanged.
Small cleanup in the APLL frequency selection part as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/twl4030-audio.c |   34 ++++++++++++++++------------------
 1 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index efa2d42..ca2d669 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -169,35 +169,30 @@ static int __devinit twl4030_audio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	audio = devm_kzalloc(&pdev->dev, sizeof(struct twl4030_audio),
+			     GFP_KERNEL);
+	if (!audio)
+		return -ENOMEM;
+
+	mutex_init(&audio->mutex);
+	audio->audio_mclk = pdata->audio_mclk;
+
 	/* Configure APLL_INFREQ and disable APLL if enabled */
-	val = 0;
-	switch (pdata->audio_mclk) {
+	switch (audio->audio_mclk) {
 	case 19200000:
-		val |= TWL4030_APLL_INFREQ_19200KHZ;
+		val = TWL4030_APLL_INFREQ_19200KHZ;
 		break;
 	case 26000000:
-		val |= TWL4030_APLL_INFREQ_26000KHZ;
+		val = TWL4030_APLL_INFREQ_26000KHZ;
 		break;
 	case 38400000:
-		val |= TWL4030_APLL_INFREQ_38400KHZ;
+		val = TWL4030_APLL_INFREQ_38400KHZ;
 		break;
 	default:
 		dev_err(&pdev->dev, "Invalid audio_mclk\n");
 		return -EINVAL;
 	}
-	twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
-					val, TWL4030_REG_APLL_CTL);
-
-	audio = devm_kzalloc(&pdev->dev, sizeof(struct twl4030_audio),
-			     GFP_KERNEL);
-	if (!audio)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, audio);
-
-	twl4030_audio_dev = pdev;
-	mutex_init(&audio->mutex);
-	audio->audio_mclk = pdata->audio_mclk;
+	twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE, val, TWL4030_REG_APLL_CTL);
 
 	/* Codec power */
 	audio->resource[TWL4030_AUDIO_RES_POWER].reg = TWL4030_REG_CODEC_MODE;
@@ -222,6 +217,9 @@ static int __devinit twl4030_audio_probe(struct platform_device *pdev)
 		childs++;
 	}
 
+	platform_set_drvdata(pdev, audio);
+	twl4030_audio_dev = pdev;
+
 	if (childs)
 		ret = mfd_add_devices(&pdev->dev, pdev->id, audio->cells,
 				      childs, NULL, 0);
-- 
1.7.8.6
