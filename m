From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [patch-2.6.35 (v2) 04/11] MUSB: Blackfin: remove bfin_vbus_power()
Date: Thu, 25 Mar 2010 13:25:21 +0200
Message-ID: <1269516328-28267-5-git-send-email-felipe.balbi@nokia.com>
References: <1269516328-28267-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269516328-28267-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>

This function does nothing...

Signed-off-by: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/blackfin.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 78f33b9..7372ef9 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -290,10 +290,6 @@ void musb_platform_disable(struct musb *musb)
 {
 }
 
-static void bfin_vbus_power(struct musb *musb, int is_on, int sleeping)
-{
-}
