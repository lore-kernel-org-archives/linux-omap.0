From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [patch-2.6.35 09/11] usb: musb: Makefile: remove unexistent config option
Date: Wed, 24 Mar 2010 14:55:16 +0200
Message-ID: <1269435318-29153-10-git-send-email-felipe.balbi@nokia.com>
References: <1269435318-29153-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269435318-29153-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Remove the unexistent CONFIG_USB_INVENTRA_MUSB_HAS_AHB_ID
option from our Makefile.

Problem reported by Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/Makefile |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index a1677f9..4266d79 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -74,10 +74,6 @@ endif
 
 # FIXME remove all these extra "-DMUSB_* things, stick to CONFIG_*
 
-ifeq ($(CONFIG_USB_INVENTRA_MUSB_HAS_AHB_ID),y)
-	EXTRA_CFLAGS += -DMUSB_AHB_ID
-endif
