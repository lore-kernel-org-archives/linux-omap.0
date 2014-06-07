From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH 6/9] drm/tilcdc: fix release order on exit
Date: Sat,  7 Jun 2014 00:02:05 -0300
Message-ID: <1402110128-30471-7-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:37742 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbaFGDBy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2014 23:01:54 -0400
Received: by mail-vc0-f181.google.com with SMTP id hq11so4056634vcb.26
        for <linux-omap@vger.kernel.org>; Fri, 06 Jun 2014 20:01:54 -0700 (PDT)
In-Reply-To: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, David Airlie <airlied@linux.ie>, Russell King <linux@arm.linux.org.uk>, Rob Clark <robdclark@gmail.com>, Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, stable@vger.kernel.org

Unregister resources in the correct order on tilcdc_drm_fini, which is
the reverse order they were registered during tilcdc_drm_init.

This also means unregistering the driver before releasing its resources=
=2E

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilc=
dc/tilcdc_drv.c
index de34657..0644429 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -629,10 +629,10 @@ static int __init tilcdc_drm_init(void)
 static void __exit tilcdc_drm_fini(void)
 {
 	DBG("fini");
-	tilcdc_tfp410_fini();
-	tilcdc_slave_fini();
-	tilcdc_panel_fini();
 	platform_driver_unregister(&tilcdc_platform_driver);
+	tilcdc_panel_fini();
+	tilcdc_slave_fini();
+	tilcdc_tfp410_fini();
 }
=20
 late_initcall(tilcdc_drm_init);
--=20
2.0.0.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
