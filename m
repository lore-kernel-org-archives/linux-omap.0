From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCHv2 1/2] OMAP4: PMIC: Rename twl6030_codec as
	twl6040_codec
Date: Wed, 17 Mar 2010 17:42:29 -0500
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE662AC371@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

Correction for chips:
twl6030 is Phoenix Power chip
twl6040 is Phoenix Audio chip

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
