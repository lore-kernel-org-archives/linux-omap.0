From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [patch-v2.6.36 0/2] musb patches
Date: Thu,  8 Jul 2010 16:34:53 +0530
Message-ID: <1278587095-16978-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Greg,

These are two patches (acked by Felipe) for v2.6.36 kernel.
Sanity tested on OMAP3EVM.

Regards,
Ajay

Anand Gadiyar (2):
  musb: Kill board specific pinmux from driver file
  usb: musb: do not override DMA mode in channel program

 drivers/usb/musb/musbhsdma.c |    5 +----
 drivers/usb/musb/omap2430.c  |    6 ------
 2 files changed, 1 insertions(+), 10 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
