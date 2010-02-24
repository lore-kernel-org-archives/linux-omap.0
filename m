From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCHv4 1/7] OMAP4: PMIC: Add support for twl6030 codec
Date: Tue, 23 Feb 2010 18:10:19 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE65DD1B13@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32878 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793Ab0BXAK1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 19:10:27 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

From: Misael Lopez Cruz <x0052729@ti.com>

In order to have TWL6030 CODEC driver as a platform driver, codec data
should be passed through twl_platform_data structure.

For twl6030 audio codec, the following data may be passed:
    - audpwron_gpio: gpio line used to power-up/down the codec. A low-to-high
      transition powers codec up. Setting audpwron_gpio to a negative value
      means that codec will use manual power sequence instead of automatic
      sequence
    - naudint_irq: irq line for audio interrupt. twl6030 drives NAUDINT line
      to low when an interrupt (codec ready, plug insertion/removal, etc) is
      detected

However, codec driver can operate if any or none of them are passed.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
---
 drivers/mfd/twl-core.c  |   18 +++++++++++++++---
 include/linux/i2c/twl.h |    4 ++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 514e1e4..7e3b0d7 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -118,7 +118,8 @@
 #define twl_has_watchdog()        false
 #endif
 
-#if defined(CONFIG_TWL4030_CODEC) || defined(CONFIG_TWL4030_CODEC_MODULE)
+#if defined(CONFIG_TWL4030_CODEC) || defined(CONFIG_TWL4030_CODEC_MODULE) ||\
+	defined(CONFIG_SND_SOC_TWL6030) || defined(CONFIG_SND_SOC_TWL6030_MODULE)
 #define twl_has_codec()	true
 #else
 #define twl_has_codec()	false
@@ -735,8 +736,19 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 			return PTR_ERR(child);
 	}
 
-	if (twl_has_codec() && pdata->codec) {
-		child = add_child(1, "twl4030_codec",
+	if (twl_has_codec() && pdata->codec && twl_class_is_4030()) {
+		sub_chip_id = twl_map[TWL_MODULE_AUDIO_VOICE].sid;
+		child = add_child(sub_chip_id, "twl4030_codec",
+				pdata->codec, sizeof(*pdata->codec),
+				false, 0, 0);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+	}
+
+	/* Phoenix*/
+	if (twl_has_codec() && pdata->codec && twl_class_is_6030()) {
+		sub_chip_id = twl_map[TWL_MODULE_AUDIO_VOICE].sid;
+		child = add_child(sub_chip_id, "twl6030_codec",
 				pdata->codec, sizeof(*pdata->codec),
 				false, 0, 0);
 		if (IS_ERR(child))
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 9cf6cd7..d943c8b 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -556,6 +556,10 @@ struct twl4030_codec_data {
 	unsigned int	audio_mclk;
 	struct twl4030_codec_audio_data		*audio;
 	struct twl4030_codec_vibra_data		*vibra;
+
+	/* twl6030 */
+	int audpwron_gpio;      /* audio power-on gpio */
+	int naudint_irq;        /* audio interrupt */
 };
 
 struct twl4030_platform_data {
-- 
1.6.1.3

