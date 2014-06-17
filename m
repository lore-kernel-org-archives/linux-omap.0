From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH/RESEND 1/9] drm/i2c: tda998x: move drm_i2c_encoder_destroy call
Date: Tue, 17 Jun 2014 11:17:03 -0300
Message-ID: <1403014631-18072-2-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: stable-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: robdclark@gmail.com, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, airlied@linux.ie, Daniel Mack <zonque@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Vetter <daniel.vetter@ffwll.ch>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Currently tda998x_encoder_destroy() calls cec_write() and reg_clear(),
as part of the release procedure. Such calls need to access the I2C bus
and therefore, we need to call them before drm_i2c_encoder_destroy()
which unregisters the I2C device.

This commit moves the latter so it's done afterwards.

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
Signed-off-by: Ezequiel Garc=C3=ADa <ezequiel@vanguardiasur.com.ar>
Cc: <stable@vger.kernel.org> #v3.9+
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/td=
a998x_drv.c
index 240c331..db9515f 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1183,7 +1183,6 @@ static void
 tda998x_encoder_destroy(struct drm_encoder *encoder)
 {
 	struct tda998x_priv *priv =3D to_tda998x_priv(encoder);
-	drm_i2c_encoder_destroy(encoder);
=20
 	/* disable all IRQs and free the IRQ handler */
 	cec_write(priv, REG_CEC_RXSHPDINTENA, 0);
@@ -1193,6 +1192,7 @@ tda998x_encoder_destroy(struct drm_encoder *encod=
er)
=20
 	if (priv->cec)
 		i2c_unregister_device(priv->cec);
+	drm_i2c_encoder_destroy(encoder);
 	kfree(priv);
 }
=20
--=20
2.0.0
