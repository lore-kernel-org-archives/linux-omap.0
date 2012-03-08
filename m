From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix compile error when FB_OMAP2 is not set
Date: Thu, 8 Mar 2012 12:43:28 -0800
Message-ID: <20120308204328.GW12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40443 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab2CHUnb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 15:43:31 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Otherwise we will get:

arch/arm/plat-omap/fb.c:101: error: expected =E2=80=98)=E2=80=99 before=
 =E2=80=98*=E2=80=99 token

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Tomi, you need something like this for what you have in for-next.

--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -98,6 +98,8 @@ arch_initcall(omap_init_fb);
=20
 #else
=20
-void __init omapfb_set_lcd_config(omap_lcd_config *config) { }
+void __init omapfb_set_lcd_config(const struct omap_lcd_config *config=
)
+{
+}
=20
 #endif
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
