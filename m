From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH/RESEND 5/9] drm/tilcdc: panel: fix leak when unloading the module
Date: Tue, 17 Jun 2014 11:17:07 -0300
Message-ID: <1403014631-18072-6-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33660 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932696AbaFQOQV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 10:16:21 -0400
Received: by mail-yk0-f173.google.com with SMTP id q200so5277359ykb.18
        for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2014 07:16:21 -0700 (PDT)
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: robdclark@gmail.com, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, airlied@linux.ie, Daniel Mack <zonque@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Vetter <daniel.vetter@ffwll.ch>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, stable@vger.kernel.org

The driver did not unregister the allocated framebuffer, which caused
memory leaks (and memory manager WARNs) when unloading. Also, the
framebuffer device under /dev still existed after unloading.

Add a call to drm_fbdev_cma_fini when unloading the module to prevent
both issues.

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
Cc: <stable@vger.kernel.org> #v3.9+
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilc=
dc/tilcdc_drv.c
index b20b694..490aee7 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -122,6 +122,7 @@ static int tilcdc_unload(struct drm_device *dev)
 	struct tilcdc_drm_private *priv =3D dev->dev_private;
 	struct tilcdc_module *mod, *cur;
=20
+	drm_fbdev_cma_fini(priv->fbdev);
 	drm_kms_helper_poll_fini(dev);
 	drm_mode_config_cleanup(dev);
 	drm_vblank_cleanup(dev);
--=20
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
