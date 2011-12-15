From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] usb: musb: remove a bit of indentation
Date: Fri, 16 Dec 2011 01:05:10 +0200
Message-ID: <1323990310-11905-4-git-send-email-felipe.contreras@gmail.com>
References: <1323990310-11905-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1323990310-11905-1-git-send-email-felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

And use dev instead of musb->controller.

Signed-off-by: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/omap2430.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index a615538..31fc8a2 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -344,20 +344,19 @@ static void omap2430_musb_enable(struct musb *musb)
 
 	case USB_EVENT_ID:
 		otg_init(musb->xceiv);
-		if (data->interface_type == MUSB_INTERFACE_UTMI) {
-			devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
-			/* start the session */
-			devctl |= MUSB_DEVCTL_SESSION;
-			musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
-			while (musb_readb(musb->mregs, MUSB_DEVCTL) &
-						MUSB_DEVCTL_BDEVICE) {
-				cpu_relax();
