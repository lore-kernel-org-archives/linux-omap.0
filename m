From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/5] ARM: omap/fb: move omap_init_fb to .init.text
Date: Thu,  2 Sep 2010 10:03:38 +0200
Message-ID: <1283414622-2663-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38625 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab0IBIDp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 04:03:45 -0400
In-Reply-To: <1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

omap_init_fb() is only called as arch_initcall and so can live in
=2Einit.text.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-omap/fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index 0054b95..a727133 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -336,7 +336,7 @@ void omapfb_set_ctrl_platform_data(void *data)
 	omapfb_config.ctrl_platform_data =3D data;
 }
=20
-static inline int omap_init_fb(void)
+static int __init omap_init_fb(void)
 {
 	const struct omap_lcd_config *conf;
=20
@@ -381,7 +381,7 @@ void omapfb_set_platform_data(struct omapfb_platfor=
m_data *data)
 	omapfb_config =3D *data;
 }
=20
-static inline int omap_init_fb(void)
+static int __init omap_init_fb(void)
 {
 	return platform_device_register(&omap_fb_device);
 }
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
