From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH 1/2] OMAP4: PMIC: Rename twl6030_codec as twl6040_codec
Date: Fri, 12 Mar 2010 19:52:15 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE66173AF6@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42650 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab0CMBw1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 20:52:27 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 drivers/mfd/twl-core.c  |    4 ++--
 include/linux/i2c/twl.h |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 562cd49..720e099 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -109,7 +109,7 @@
 #endif
 
 #if defined(CONFIG_TWL4030_CODEC) || defined(CONFIG_TWL4030_CODEC_MODULE) ||\
-	defined(CONFIG_SND_SOC_TWL6030) || defined(CONFIG_SND_SOC_TWL6030_MODULE)
+	defined(CONFIG_SND_SOC_TWL6040) || defined(CONFIG_SND_SOC_TWL6040_MODULE)
 #define twl_has_codec()	true
 #else
 #define twl_has_codec()	false
@@ -708,7 +708,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 	/* Phoenix*/
 	if (twl_has_codec() && pdata->codec && twl_class_is_6030()) {
 		sub_chip_id = twl_map[TWL_MODULE_AUDIO_VOICE].sid;
-		child = add_child(sub_chip_id, "twl6030_codec",
+		child = add_child(sub_chip_id, "twl6040_codec",
 				pdata->codec, sizeof(*pdata->codec),
 				false, 0, 0);
 		if (IS_ERR(child))
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index fb6784e..ebd90ce 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -569,9 +569,9 @@ struct twl4030_codec_data {
 	struct twl4030_codec_audio_data		*audio;
 	struct twl4030_codec_vibra_data		*vibra;
 
-	/* twl6030 */
-	int audpwron_gpio;      /* audio power-on gpio */
-	int naudint_irq;        /* audio interrupt */
+	/* twl6040 */
+	int audpwron_gpio;	/* audio power-on gpio */
+	int naudint_irq;	/* audio interrupt */
 };
 
 struct twl4030_platform_data {
-- 
1.6.1.3
