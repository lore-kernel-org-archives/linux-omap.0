From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH 2/2] usb: musb: omap2430: fix sparse warning
Date: Tue,  5 Mar 2013 13:04:24 +0200
Message-ID: <1362481464-10813-2-git-send-email-aaro.koskinen@iki.fi>
References: <1362481464-10813-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362481464-10813-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Fix the following sparse warning:

drivers/usb/musb/omap2430.c:54:33: warning: symbol '_glue' was not declared. Should it be static?

Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
---
 drivers/usb/musb/omap2430.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 2a39c11..1a42a45 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -51,7 +51,7 @@ struct omap2430_glue {
 };
 #define glue_to_musb(g)		platform_get_drvdata(g->musb)
 
-struct omap2430_glue		*_glue;
+static struct omap2430_glue	*_glue;
 
 static struct timer_list musb_idle_timer;
 
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
