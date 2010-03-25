From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [patch-2.6.35 (v2) 09/11] usb: musb: Makefile: remove unexistent config option
Date: Thu, 25 Mar 2010 13:25:26 +0200
Message-ID: <1269516328-28267-10-git-send-email-felipe.balbi@nokia.com>
References: <1269516328-28267-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269516328-28267-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Remove the unexistent CONFIG_USB_INVENTRA_MUSB_HAS_AHB_ID
option from our Makefile.

Problem reported by Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/Makefile |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index a1677f9..9705f71 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -72,12 +72,6 @@ endif
 
 ################################################################################
 
-# FIXME remove all these extra "-DMUSB_* things, stick to CONFIG_*
-
-ifeq ($(CONFIG_USB_INVENTRA_MUSB_HAS_AHB_ID),y)
-	EXTRA_CFLAGS += -DMUSB_AHB_ID
-endif
