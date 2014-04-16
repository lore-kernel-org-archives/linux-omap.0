From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/8] usb: generic cleanup patches
Date: Wed, 16 Apr 2014 16:26:27 -0500
Message-ID: <1397683595-3606-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, zhangwm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi folks,

I have been playing with following patches today and
I think they're ready to be queued up for v3.16 but
I wanted to get some comments/test results before
I apply them to my 'next' branch.

Thanks

Felipe Balbi (8):
  usb: dwc3: gadget: clear stall when disabling endpoint
  usb: dwc3: core: refactor PHY initialization
  usb: dwc3: core: refactor mode initialization to its own function
  usb: gadget: only GPL drivers in the gadget and phy framework
  usb: phy: rename usb_nop_xceiv to usb_phy_generic
  usb: phy: rename <linux/usb/usb_phy_gen_xceiv.h> to
    <linux/usb/usb_phy_generic.h>
  usb: musb: move usb_phy_generic_{un,}register calls to
    probe()/remove()
  usb: phy: generic: allow multiples calls to usb_phy_generic_register()

 drivers/usb/dwc3/core.c                            | 253 +++++++++++----------
 drivers/usb/dwc3/dwc3-exynos.c                     |   8 +-
 drivers/usb/dwc3/dwc3-pci.c                        |   8 +-
 drivers/usb/dwc3/gadget.c                          |   4 +
 drivers/usb/gadget/configfs.c                      |   2 +-
 drivers/usb/gadget/f_fs.c                          |   6 +-
 drivers/usb/gadget/f_rndis.c                       |   2 +-
 drivers/usb/gadget/rndis.c                         |  28 +--
 drivers/usb/gadget/storage_common.c                |  52 ++---
 drivers/usb/gadget/u_ether.c                       |  32 +--
 drivers/usb/gadget/u_f.c                           |   2 +-
 drivers/usb/musb/am35x.c                           |  14 +-
 drivers/usb/musb/blackfin.c                        |  14 +-
 drivers/usb/musb/da8xx.c                           |  16 +-
 drivers/usb/musb/davinci.c                         |   8 +-
 drivers/usb/musb/musb_dsps.c                       |   2 +-
 drivers/usb/musb/tusb6010.c                        |   8 +-
 drivers/usb/phy/phy-am335x.c                       |   4 +-
 drivers/usb/phy/phy-generic.c                      |  65 +++---
 drivers/usb/phy/phy-generic.h                      |   8 +-
 drivers/usb/phy/phy-keystone.c                     |   4 +-
 .../usb/{usb_phy_gen_xceiv.h => usb_phy_generic.h} |  10 +-
 22 files changed, 289 insertions(+), 261 deletions(-)
 rename include/linux/usb/{usb_phy_gen_xceiv.h => usb_phy_generic.h} (62%)

-- 
1.9.2.459.g68773ac

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
