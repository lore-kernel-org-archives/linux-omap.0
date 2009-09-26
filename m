From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCHv2 1/7] OMAP4: PMIC: Add support for twl6030 codec
Date: Fri, 25 Sep 2009 21:02:32 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90A391DF@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57181 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357AbZIZCCe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Sep 2009 22:02:34 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

In order to have TWL6030 CODEC driver as a platform driver, codec data
should be passed through twl_platform_data structure.

For twl6030 audio codec, the following data is required:

- audpwron_gpio: gpio line used to power-up/down the codec. A low-to-high
  transition powers codec up. Setting audpwron_gpio to a negative value
  means that codec will use manual power sequence instead of automatic
  sequence
- naudint_irq: irq line for audio interrupt. twl6030 drives NAUDINT line
  to low when an interrupt (codec ready, plug insertion/removal, etc) is
  detected

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 drivers/mfd/twl-core.c  |   15 +++++++++++++++
 include/linux/i2c/twl.h |   11 +++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index af4cf47..e9d1ff1 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -108,6 +108,12 @@
 #define twl_has_mmc()   false
 #endif
 
+#if defined(CONFIG_SND_SOC_TWL6030)
+#define twl_has_codec()	true
+#else
+#define twl_has_codec()	false
+#endif
+
 #if defined(CONFIG_TWL4030_USB) || defined(CONFIG_TWL4030_USB_MODULE)
 #define twl_has_usb()	true
 #else
@@ -190,6 +196,7 @@
 #define BCI_SUB_CHIP_ID		SUB_CHIP_ID1
 #define GPIO_SUB_CHIP_ID	0 /* NOT SUPPORTED IN TWL6030 */
 #define KEYPAD_SUB_CHIP_ID	0 /* ADDED FOR COMPILATION ONLY */
+#define CODEC_SUB_CHIP_ID	SUB_CHIP_ID3
 
 /* subchip/slave 0 0x48 - POWER */
 #define TWL6030_BASEADD_RTC		0x0000
@@ -632,6 +639,14 @@ add_children(struct twl_platform_data *pdata, unsigned long features)
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 	}
+
+	if (twl_has_codec() && pdata->codec) {
+		child = add_child(CODEC_SUB_CHIP_ID, "twl6030_codec",
+			pdata->codec, sizeof(*pdata->codec), false,
+			0, 0);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+	}
 #endif
 
 	if (twl_has_usb() && pdata->usb) {
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index b687a8b..d8a8823 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -472,6 +472,16 @@ struct twl_usb_data {
 	enum twl_usb_mode	usb_mode;
 };
 
+struct snd_soc_codec;
+
+struct twl_codec_data {
+	struct snd_soc_codec *codec;
+
+	/* twl6030 */
+	int audpwron_gpio;	/* audio power-on gpio */
+	int naudint_irq;	/* audio interrupt */
+};
+
 struct twl_platform_data {
 	unsigned				irq_base, irq_end;
 	struct twl_bci_platform_data	*bci;
@@ -479,6 +489,7 @@ struct twl_platform_data {
 	struct twl_madc_platform_data	*madc;
 	struct twl_keypad_data		*keypad;
 	struct twl_usb_data			*usb;
+	struct twl_codec_data		*codec;
 
 	/* LDO regulators common to TWL4030/TWL6030 */
 	struct regulator_init_data		*vdac;
-- 
1.5.4.3
