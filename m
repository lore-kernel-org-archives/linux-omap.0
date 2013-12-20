From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v2 REPOST 6/8] drm/tilcdc: Add I2C HDMI
	audio config for tda998x
Date: Fri, 20 Dec 2013 12:41:44 +0200
Message-ID: <72b68761b5dfae5c09ba0c95541a36d9010f0b88.1387535303.git.jsarha@ti.com>
References: <cover.1387535299.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <cover.1387535299.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, airlied@linux.ie
Cc: broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: linux-omap@vger.kernel.org

The configuration is needed for HDMI audio. The "swap" and "mirr"
parameters have to be correctly set in the configuration in order to
have proper colors in the HDMI picture.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
cc: airlied@linux.ie
---
 drivers/gpu/drm/tilcdc/tilcdc_slave.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_slave.c b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
index 595068b..e43240a 100644
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
