From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [patch-v2.6.39 00/12] OMAP USB and MUSB patches for Next
Date: Thu, 17 Feb 2011 14:38:37 +0200
Message-ID: <1297946329-9353-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Greg, all,

Here are the tested set of patches for the next merge window.

We have a pending fixes pull request [1] which could be
integrated to this one if wanted/needed.

I'll be waiting for v2.6.38-rc5 appear on greg/usb-next
before sending the pull request otherwise we will have
conflicts popping.

If there are any other patches pending, you guys have
just a few days remaining to send me those.

[1] http://marc.info/?l=linux-usb&m=129767766917391&w=2

Felipe Balbi (4):
  usb: musb: do not error out if Kconfig doesn't match board mode
  usb: musb: gadget: beautify
    usb_gadget_probe_driver()/usb_gadget_unregister_driver
  usb: musb: gadget: do not poke with gadget's list_head
  usb: otg: notifier: switch to atomic notifier

Hema HK (8):
  usb: musb: Using runtime pm APIs for musb.
  usb: otg: enable regulator only on cable/device connect
  usb: otg: Remove one unnecessary I2C read request.
  usb: otg: OMAP4430: Add phy_suspend function pointer to
    twl4030_usb_data
  usb: otg: OMAP4430: Introducing suspend function for power management
  usb: otg: TWL6030: Introduce the twl6030_phy_suspend function.
  usb: otg: TWL6030 Save the last event in otg_transceiver
  usb: musb: OMAP4430: Fix usb device detection if connected during
    boot

 arch/arm/mach-omap2/board-4430sdp.c     |    1 +
 arch/arm/mach-omap2/board-omap4panda.c  |    1 +
 arch/arm/mach-omap2/omap_phy_internal.c |   22 +++-
 arch/arm/plat-omap/include/plat/usb.h   |    1 +
 drivers/usb/musb/musb_core.c            |   25 ----
 drivers/usb/musb/musb_core.h            |    6 +-
 drivers/usb/musb/musb_gadget.c          |  191 +++++++++++++++++--------------
 drivers/usb/musb/musb_gadget.h          |    7 +-
 drivers/usb/musb/musb_gadget_ep0.c      |   24 +++--
 drivers/usb/musb/omap2430.c             |  134 ++++++++++++----------
 drivers/usb/otg/ab8500-usb.c            |    6 +-
 drivers/usb/otg/nop-usb-xceiv.c         |    2 +-
 drivers/usb/otg/twl4030-usb.c           |    6 +-
 drivers/usb/otg/twl6030-usb.c           |   56 ++++++----
 include/linux/i2c/twl.h                 |    2 +
 include/linux/usb/otg.h                 |    7 +-
 16 files changed, 260 insertions(+), 231 deletions(-)

-- 
1.7.4.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
