From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] musb patches for next merge window
Date: Wed, 11 May 2011 13:06:52 +0300
Message-ID: <1305108415-27206-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi all,

with the following three patches I could successfully
compile musb with omap2plus and am35x glue layers with
no problems.

Currently we still can't have all glue layers plus
DMA support, but we are getting there. Please give
this a round of test on your setup to avoid us
introducing any regressions on 2.6.40-rc0.

Greg,

In a few days I'll prepare a branch and send you a pull
request with these patches.

Felipe Balbi (3):
  usb: musb: drop unneeded musb_debug trickery
  usb: musb: allow musb and glue layers to be modules
  usb: musb: export musb_interrupt symbol

 drivers/usb/musb/Kconfig           |   28 +++------
 drivers/usb/musb/Makefile          |    2 -
 drivers/usb/musb/am35x.c           |   10 ++--
 drivers/usb/musb/blackfin.c        |   10 ++--
 drivers/usb/musb/cppi_dma.c        |   34 ++++++------
 drivers/usb/musb/da8xx.c           |   14 ++--
 drivers/usb/musb/davinci.c         |   10 ++--
 drivers/usb/musb/musb_core.c       |   98 +++++++++++++++-----------------
 drivers/usb/musb/musb_debug.h      |   12 ----
 drivers/usb/musb/musb_gadget.c     |  110 ++++++++++++++++++-----------------
 drivers/usb/musb/musb_gadget_ep0.c |   22 ++++----
 drivers/usb/musb/musb_host.c       |  106 +++++++++++++++-------------------
 drivers/usb/musb/musb_virthub.c    |   22 ++++----
 drivers/usb/musb/musbhsdma.c       |   11 ++--
 drivers/usb/musb/omap2430.c        |   20 +++---
 drivers/usb/musb/tusb6010.c        |   48 ++++++++--------
 drivers/usb/musb/tusb6010_omap.c   |   32 +++++-----
 17 files changed, 277 insertions(+), 312 deletions(-)

-- 
1.7.4.1.343.ga91df

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
