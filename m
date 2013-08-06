From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH 1/2] ARM: omap2: fix musb usage for n8x0
Date: Tue,  6 Aug 2013 20:06:15 +0300
Message-ID: <1375808776-14975-2-git-send-email-aaro.koskinen@iki.fi>
References: <1375808776-14975-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1375808776-14975-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Commit b7e2e75a8c ("usb: gadget: drop unused USB_GADGET_MUSB_HDRC")
dropped a config symbol that was unused by the musb core, but it turns
out that board support code still had references to it.

As the core now handles both dual role and host-only modes, we can just
pass MUSB_OTG as mode from board files.

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Tested-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
---
 arch/arm/mach-omap2/board-n8x0.c | 4 ----
 arch/arm/mach-omap2/usb-musb.c   | 5 +----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index f6eeb87..827d150 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -122,11 +122,7 @@ static struct musb_hdrc_config musb_config = {
 };
 
 static struct musb_hdrc_platform_data tusb_data = {
-#ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	.mode		= MUSB_OTG,
-#else
-	.mode		= MUSB_HOST,
-#endif
 	.set_power	= tusb_set_power,
 	.min_power	= 25,	/* x2 = 50 mA drawn from VBUS as peripheral */
 	.power		= 100,	/* Max 100 mA VBUS for host mode */
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 8c4de27..bc89723 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -38,11 +38,8 @@ static struct musb_hdrc_config musb_config = {
 };
 
 static struct musb_hdrc_platform_data musb_plat = {
-#ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	.mode		= MUSB_OTG,
-#else
-	.mode		= MUSB_HOST,
-#endif
+
 	/* .clock is set dynamically */
 	.config		= &musb_config,
 
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
