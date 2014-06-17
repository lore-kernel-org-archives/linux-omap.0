From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH/RESEND 9/9] drm/tilcdc: replace late_initcall with module_init
Date: Tue, 17 Jun 2014 11:17:11 -0300
Message-ID: <1403014631-18072-10-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:34943 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588AbaFQOQq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 10:16:46 -0400
Received: by mail-yh0-f43.google.com with SMTP id a41so5558038yho.30
        for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2014 07:16:45 -0700 (PDT)
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: robdclark@gmail.com, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, airlied@linux.ie, Daniel Mack <zonque@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Vetter <daniel.vetter@ffwll.ch>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>

Use module_init instead of late_initcall, as is the norm for modular
drivers.

module_init was used until 6e8de0bd6a51fdeebd5d975c4fcc426f730b339b
("drm/tilcdc: add encoder slave (v2)") changed it to a late_initcall,
but it does not explain why. Tests show it's working properly with
module_init.

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilc=
dc/tilcdc_drv.c
index 2c860c4..6be623b 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -629,7 +629,7 @@ static void __exit tilcdc_drm_fini(void)
 	tilcdc_tfp410_fini();
 }
=20
-late_initcall(tilcdc_drm_init);
+module_init(tilcdc_drm_init);
 module_exit(tilcdc_drm_fini);
=20
 MODULE_AUTHOR("Rob Clark <robdclark@gmail.com");
--=20
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
