From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [patch-2.6.35 00/11] musb patches
Date: Wed, 24 Mar 2010 14:55:07 +0200
Message-ID: <1269435318-29153-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Greg,

here are more patches for the 2.6.35 merge window

Ajay Kumar Gupta (1):
  musb: Add extvbus in musb_board_data

Anand Gadiyar (2):
  usb: musb: omap2430: remove unused define
  usb: musb: omap2430.c: remove unnecessary includes

Cliff Cai (1):
  USB: musb: support host/gadget role switching on Blackfin parts

Felipe Balbi (2):
  usb: musb: debugfs: musb_exit_debugfs() can be called on probe
  usb: musb: Makefile: remove unexistent config option

Heikki Krogerus (1):
  usb: musb: add ulpi access operations

Sergei Shtylyov (4):
  MUSB: OMAP: remove omap_vbus_power()
  MUSB: Blackfin: remove bfin_vbus_power()
  MUSB: OMAP: make musb_platform_suspend() 'static'
  MUSB: Blackfin: remove musb_platform_{suspend|resume}()

 arch/arm/mach-omap2/board-omap3evm.c  |    3 +
 arch/arm/mach-omap2/usb-musb.c        |    1 +
 arch/arm/plat-omap/include/plat/usb.h |    1 +
 drivers/usb/musb/Makefile             |    4 --
 drivers/usb/musb/blackfin.c           |   86 ++++++++++++++++++++++--------
 drivers/usb/musb/musb_core.c          |   93 ++++++++++++++++++++++++++++++++-
 drivers/usb/musb/musb_debugfs.c       |    2 +-
 drivers/usb/musb/musb_regs.h          |   10 ++++
 drivers/usb/musb/omap2430.c           |   16 +-----
 9 files changed, 171 insertions(+), 45 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
