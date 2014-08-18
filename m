From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/8] drm/tilcdc: Add I2S HDMI audio config for tda998x
Date: Tue, 19 Aug 2014 00:46:40 +0300
Message-ID: <6e3745f51bf20304e6c7d2d4636968cc543b6f64.1408397864.git.jsarha@ti.com>
References: <cover.1408397864.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1408397864.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The configuration is needed for HDMI audio. The "swap" and "mirr"
parameters have to be correctly set in the configuration in order to
have proper colors in the HDMI picture.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 drivers/gpu/drm/tilcdc/tilcdc_slave.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_slave.c b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
index 3775fd4..5dd8d78 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_slave.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
@@ -19,6 +19,7 @@
 #include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/consumer.h>
 #include <drm/drm_encoder_slave.h>
+#include <drm/i2c/tda998x.h>
 
 #include "tilcdc_drv.h"
 
@@ -111,8 +112,29 @@ static const struct drm_encoder_helper_funcs slave_encoder_helper_funcs = {
 		.restore        = drm_i2c_encoder_restore,
 };
 
+static struct tda998x_encoder_params tda998x_pdata = {
+	.swap_b = 0x3,
+	.mirr_b = 0x0,
+	.swap_a = 0x2,
+	.mirr_a = 0x0,
+	.swap_d = 0x1,
+	.mirr_d = 0x0,
+	.swap_c = 0x0,
+	.mirr_c = 0x0,
+	.swap_f = 0x5,
+	.mirr_f = 0x0,
+	.swap_e = 0x4,
+	.mirr_e = 0x0,
+	.audio_cfg = 0x3,	/* I2S mode */
+	.audio_clk_cfg = 1,	/* select clock pin */
+	.audio_frame[1] = 1,	/* channels - 1 */
+	.audio_format = AFMT_I2S,
+	.audio_sample_rate = 48000,
+};
+
 static const struct i2c_board_info info = {
-		I2C_BOARD_INFO("tda998x", 0x70)
+		I2C_BOARD_INFO("tda998x", 0x70),
+		.platform_data = &tda998x_pdata,
 };
 
 static struct drm_encoder *slave_encoder_create(struct drm_device *dev,
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
