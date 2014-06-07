From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH 1/9] drm/i2c: tda998x: move drm_i2c_encoder_destroy call
Date: Sat,  7 Jun 2014 00:02:00 -0300
Message-ID: <1402110128-30471-2-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:42423 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbaFGDBM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2014 23:01:12 -0400
Received: by mail-vc0-f181.google.com with SMTP id hq11so4126646vcb.12
        for <linux-omap@vger.kernel.org>; Fri, 06 Jun 2014 20:01:12 -0700 (PDT)
In-Reply-To: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, David Airlie <airlied@linux.ie>, Russell King <linux@arm.linux.org.uk>, Rob Clark <robdclark@gmail.com>, Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, stable@vger.kernel.org

Currently tda998x_encoder_destroy() calls cec_write() and reg_clear(),
as part of the release procedure. Such calls need to access the I2C bus
and therefore, we need to call them before drm_i2c_encoder_destroy()
which unregisters the I2C device.

This commit moves the latter so it's done afterwards.

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
Signed-off-by: Ezequiel Garc=C3=ADa <ezequiel@vanguardiasur.com.ar>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/td=
a998x_drv.c
index 219c7e8..d06eff6 100644
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
2.0.0.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
