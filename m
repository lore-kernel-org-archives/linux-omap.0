From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH 2/2] mfd: twl4030-audio: make module DT only
Date: Tue, 15 Nov 2016 10:01:20 +0200
Message-ID: <1479196880-20344-3-git-send-email-Nicolae_Rosia@mentor.com>
References: <1479196880-20344-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1479196880-20344-1-git-send-email-Nicolae_Rosia@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>
List-Id: linux-omap@vger.kernel.org

Remove dead code since all users are DT enabled and
the code remains untested.
Move struct twl4030_codec_data to codec/twl4030.c since
it is only used there.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 drivers/mfd/twl4030-audio.c | 46 +++++++--------------------------------------
 include/linux/i2c/twl.h     | 23 -----------------------
 sound/soc/codecs/twl4030.c  |  8 ++++++++
 3 files changed, 15 insertions(+), 62 deletions(-)

diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index 0a16064..5bda789 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -158,43 +158,17 @@ unsigned int twl4030_audio_get_mclk(void)
 }
 EXPORT_SYMBOL_GPL(twl4030_audio_get_mclk);
 
-static bool twl4030_audio_has_codec(struct twl4030_audio_data *pdata,
-			      struct device_node *node)
-{
-	if (pdata && pdata->codec)
-		return true;
-
-	if (of_find_node_by_name(node, "codec"))
-		return true;
-
-	return false;
-}
-
-static bool twl4030_audio_has_vibra(struct twl4030_audio_data *pdata,
-			      struct device_node *node)
-{
-	int vibra;
-
-	if (pdata && pdata->vibra)
-		return true;
-
-	if (!of_property_read_u32(node, "ti,enable-vibra", &vibra) && vibra)
-		return true;
-
-	return false;
-}
-
 static int twl4030_audio_probe(struct platform_device *pdev)
 {
 	struct twl4030_audio *audio;
-	struct twl4030_audio_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *node = pdev->dev.of_node;
 	struct mfd_cell *cell = NULL;
+	u32 enable_vibra = 0;
 	int ret, childs = 0;
 	u8 val;
 
-	if (!pdata && !node) {
-		dev_err(&pdev->dev, "Platform data is missing\n");
+	if (!node) {
+		dev_err(&pdev->dev, "no DT info\n");
 		return -EINVAL;
 	}
 
@@ -231,22 +205,16 @@ static int twl4030_audio_probe(struct platform_device *pdev)
 	audio->resource[TWL4030_AUDIO_RES_APLL].reg = TWL4030_REG_APLL_CTL;
 	audio->resource[TWL4030_AUDIO_RES_APLL].mask = TWL4030_APLL_EN;
 
-	if (twl4030_audio_has_codec(pdata, node)) {
+	if (of_find_node_by_name(node, "codec")) {
 		cell = &audio->cells[childs];
 		cell->name = "twl4030-codec";
-		if (pdata) {
-			cell->platform_data = pdata->codec;
-			cell->pdata_size = sizeof(*pdata->codec);
-		}
 		childs++;
 	}
-	if (twl4030_audio_has_vibra(pdata, node)) {
+
+	of_property_read_u32(node, "ti,enable-vibra", &enable_vibra);
+	if (enable_vibra == 1) {
 		cell = &audio->cells[childs];
 		cell->name = "twl4030-vibra";
-		if (pdata) {
-			cell->platform_data = pdata->vibra;
-			cell->pdata_size = sizeof(*pdata->vibra);
-		}
 		childs++;
 	}
 
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 9ad7828..983791a 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -681,29 +681,6 @@ struct twl4030_power_data {
 extern int twl4030_remove_script(u8 flags);
 extern void twl4030_power_off(void);
 
-struct twl4030_codec_data {
-	unsigned int digimic_delay; /* in ms */
-	unsigned int ramp_delay_value;
-	unsigned int offset_cncl_path;
-	unsigned int hs_extmute:1;
-	int hs_extmute_gpio;
-};
-
-struct twl4030_vibra_data {
-	unsigned int	coexist;
-};
-
-struct twl4030_audio_data {
-	unsigned int	audio_mclk;
-	struct twl4030_codec_data *codec;
-	struct twl4030_vibra_data *vibra;
-
-	/* twl6040 */
-	int audpwron_gpio;	/* audio power-on gpio */
-	int naudint_irq;	/* audio interrupt */
-	unsigned int irq_base;
-};
-
 struct twl4030_platform_data {
 	struct twl4030_clock_init_data		*clock;
 	struct twl4030_bci_platform_data	*bci;
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index a2104d6..5cba27b 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -48,6 +48,14 @@
 
 #define TWL4030_CACHEREGNUM	(TWL4030_REG_MISC_SET_2 + 1)
 
+struct twl4030_codec_data {
+	unsigned int digimic_delay; /* in ms */
+	unsigned int ramp_delay_value;
+	unsigned int offset_cncl_path;
+	unsigned int hs_extmute:1;
+	int hs_extmute_gpio;
+};
+
 /* codec private data */
 struct twl4030_priv {
 	unsigned int codec_powered;
-- 
2.7.4
