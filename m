From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 00/10] usb: generic cleanup patches
Date: Mon, 21 Apr 2014 10:56:42 -0500
Message-ID: <1398095812-14222-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, leigh-0TD6cqJ6btAqdlJmJB21zg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi folks,

I have been playing with following patches today and
I think they're ready to be queued up for v3.16 but
I wanted to get some comments/test results before
I apply them to my 'next' branch.

Changes since v1:
	- modify arch/arm/mach-omap2/usb-host.c and
		board-omap3beagle.c accordingly
	- added a patch to switch over to IS_ENABLED()

Felipe Balbi (10):
  usb: dwc3: gadget: clear stall when disabling endpoint
  usb: dwc3: core: refactor PHY initialization
  usb: phy: mv-u3d: switch over to writel/readl
  usb: dwc3: core: refactor mode initialization to its own function
  usb: gadget: only GPL drivers in the gadget and phy framework
  usb: phy: rename usb_nop_xceiv to usb_phy_generic
  usb: phy: rename <linux/usb/usb_phy_gen_xceiv.h> to
    <linux/usb/usb_phy_generic.h>
  usb: musb: move usb_phy_generic_{un,}register calls to
    probe()/remove()
  usb: phy: generic: allow multiples calls to usb_phy_generic_register()
  usb: phy: generic: switch over to IS_ENABLED()

 arch/arm/mach-omap2/board-omap3beagle.c            |   1 -
 arch/arm/mach-omap2/usb-host.c                     |  10 +-
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
 drivers/usb/phy/phy-mv-u3d-usb.c                   |  20 +-
 .../usb/{usb_phy_gen_xceiv.h => usb_phy_generic.h} |  13 +-
 25 files changed, 306 insertions(+), 278 deletions(-)
 rename include/linux/usb/{usb_phy_gen_xceiv.h => usb_phy_generic.h} (53%)

-- 
1.9.2.459.g68773ac

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
