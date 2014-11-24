From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 7/8] usb: musb: Allow multiple glue layers to be built in
Date: Mon, 24 Nov 2014 11:05:05 -0800
Message-ID: <1416855906-13931-8-git-send-email-tony@atomide.com>
References: <1416855906-13931-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416855906-13931-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

There's no reason any longer to keep it as a choice now that
the IO access has been fixed.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 06cc5d6..9d68372 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -58,8 +58,7 @@ config USB_MUSB_DUAL_ROLE
 
 endchoice
 
-choice
-	prompt "Platform Glue Layer"
+comment "Platform Glue Layer"
 
 config USB_MUSB_DAVINCI
 	tristate "DaVinci"
@@ -101,8 +100,6 @@ config USB_MUSB_JZ4740
 	depends on USB_MUSB_GADGET
 	depends on USB_OTG_BLACKLIST_HUB
 
-endchoice
