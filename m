From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [patch-2.6.34-rc2+ 02/11] MUSB: fix DaVinci glue layer dependency
Date: Thu, 25 Mar 2010 13:14:24 +0200
Message-ID: <1269515673-27980-3-git-send-email-felipe.balbi@nokia.com>
References: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269515673-27980-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>

CONFIG_ARCH_DAVINCI now embraces both the "real" DaVinci and DA8xx/OMAP-L1x --
on which the DaVinci glue layer won't work. Change the Makefile dependency to
CONFIG_ARCH_DAVINCI_DMx which corresponds to "real" DaVinci.

Signed-off-by: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/Kconfig  |    2 +-
 drivers/usb/musb/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index b4c783c..07fe490 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -42,7 +42,7 @@ config USB_MUSB_SOC
 	default y if (BF52x && !BF522 && !BF523)
 
 comment "DaVinci 35x and 644x USB support"
-	depends on USB_MUSB_HDRC && ARCH_DAVINCI
+	depends on USB_MUSB_HDRC && ARCH_DAVINCI_DMx
 
 comment "OMAP 243x high speed USB support"
 	depends on USB_MUSB_HDRC && ARCH_OMAP2430
diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index 85710cc..3a485da 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -6,7 +6,7 @@ musb_hdrc-objs := musb_core.o
 
 obj-$(CONFIG_USB_MUSB_HDRC)	+= musb_hdrc.o
 
-ifeq ($(CONFIG_ARCH_DAVINCI),y)
+ifeq ($(CONFIG_ARCH_DAVINCI_DMx),y)
 	musb_hdrc-objs	+= davinci.o
 endif
 
-- 
1.7.0.rc0.33.g7c3932

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
