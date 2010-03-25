From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [patch-2.6.34-rc2+ 00/11] musb patches (v2)
Date: Thu, 25 Mar 2010 13:14:22 +0200
Message-ID: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Greg,

sorry for the last time. There was a bug in my script
which caused it to rebased against the wrong branch.

Now rebasing against Linus' today's master.

Ajay Kumar Gupta (2):
  musb: fix power field to hold all possible values
  musb: save and restore missing bus control register

Dan Carpenter (1):
  musb: potential use after free

Sergei Shtylyov (8):
  MUSB: fix DaVinci glue layer dependency
  MUSB: Blackfin: don't fake blackfin_interrupt() result
  musb_core: don't touch 'musb->clock' in musb_free()
  musb_core: don't prevent disabling clock on driver unload
  MUSB: DaVinci: fix musb_platform_init() error cleanup path
  MUSB: OMAP: don't call clk_put()
  musb_core: don't call musb_platform_exit() twice
  musb_core: fix musb_init_controller() error cleanup path

 arch/arm/plat-omap/include/plat/usb.h |    2 +-
 drivers/usb/musb/Kconfig              |    2 +-
 drivers/usb/musb/Makefile             |    2 +-
 drivers/usb/musb/blackfin.c           |    8 +---
 drivers/usb/musb/davinci.c            |    2 +
 drivers/usb/musb/musb_core.c          |   77 ++++++++++++++++++--------------
 drivers/usb/musb/musb_core.h          |    2 +-
 drivers/usb/musb/musb_host.c          |    1 +
 drivers/usb/musb/omap2430.c           |    3 -
 9 files changed, 51 insertions(+), 48 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
