From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [patch-2.6.35 07/11] usb: musb: omap2430: remove unused define
Date: Wed, 24 Mar 2010 14:55:14 +0200
Message-ID: <1269435318-29153-8-git-send-email-felipe.balbi@nokia.com>
References: <1269435318-29153-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269435318-29153-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>

get_cpu_rev() is unused in this driver. It is probably legacy
code. So remove it.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/omap2430.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 2633049..202cafa 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -40,10 +40,6 @@
 #include "musb_core.h"
 #include "omap2430.h"
 
-#ifdef CONFIG_ARCH_OMAP3430
-#define	get_cpu_rev()	2
-#endif
