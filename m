From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 5/8] ASoC: twl4030: Configure extmute pinmux when the dedicated pin is in use
Date: Mon, 31 Dec 2012 11:51:46 +0100
Message-ID: <1356951109-4286-6-git-send-email-peter.ujfalusi@ti.com>
References: <1356951109-4286-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47999 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322Ab2LaKww (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Dec 2012 05:52:52 -0500
In-Reply-To: <1356951109-4286-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, NeilBrown <neilb@suse.de>

When HS extmute is enabled without custom GPIO we should configure the mux
to allow the pin to be used as extmute signal.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl4030.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 5dd7c81..7bfabe5 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -41,6 +41,11 @@
 /* Register descriptions are here */
 #include <linux/mfd/twl4030-audio.h>
 
+/* TWL4030 PMBR1 Register */
+#define TWL4030_PMBR1_REG		0x0D
+/* TWL4030 PMBR1 Register GPIO6 mux bits */
+#define TWL4030_GPIO6_PWM0_MUTE(value)	((value & 0x03) << 2)
+
 /* Shadow register used by the audio driver */
 #define TWL4030_REG_SW_SHADOW		0x4A
 #define TWL4030_CACHEREGNUM	(TWL4030_REG_SW_SHADOW + 1)
@@ -348,19 +353,32 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 
 	pdata = twl4030_get_pdata(codec);
 
-	if (pdata && pdata->hs_extmute &&
-	    gpio_is_valid(pdata->hs_extmute_gpio)) {
-		int ret;
-
-		if (!pdata->hs_extmute_gpio)
-			dev_warn(codec->dev,
-				 "Extmute GPIO is 0 is this correct?\n");
-
-		ret = gpio_request_one(pdata->hs_extmute_gpio,
-				       GPIOF_OUT_INIT_LOW, "hs_extmute");
-		if (ret) {
-			dev_err(codec->dev, "Failed to get hs_extmute GPIO\n");
-			pdata->hs_extmute_gpio = -1;
+	if (pdata && pdata->hs_extmute) {
+		if (gpio_is_valid(pdata->hs_extmute_gpio)) {
+			int ret;
+
+			if (!pdata->hs_extmute_gpio)
+				dev_warn(codec->dev,
+					"Extmute GPIO is 0 is this correct?\n");
+
+			ret = gpio_request_one(pdata->hs_extmute_gpio,
+					       GPIOF_OUT_INIT_LOW,
+					       "hs_extmute");
+			if (ret) {
+				dev_err(codec->dev,
+					"Failed to get hs_extmute GPIO\n");
+				pdata->hs_extmute_gpio = -1;
+			}
+		} else {
+			u8 pin_mux;
+
+			/* Set TWL4030 GPIO6 as EXTMUTE signal */
+			twl_i2c_read_u8(TWL4030_MODULE_INTBR, &pin_mux,
+					TWL4030_PMBR1_REG);
+			pin_mux &= ~TWL4030_GPIO6_PWM0_MUTE(0x03);
+			pin_mux |= TWL4030_GPIO6_PWM0_MUTE(0x02);
+			twl_i2c_write_u8(TWL4030_MODULE_INTBR, pin_mux,
+					 TWL4030_PMBR1_REG);
 		}
 	}
 
-- 
1.8.0.2

