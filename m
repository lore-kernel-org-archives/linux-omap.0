From: Felipe Balbi <balbi@ti.com>
Subject: [patch-v2.6.39 00/19] OMAP USB + MUSB patches
Date: Tue,  1 Mar 2011 17:15:21 +0200
Message-ID: <1298992540-5984-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:55085 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755100Ab1CAPQI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 10:16:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <balbi@ti.com>

Hi Greg,

This is my last pull request for this merge window. I tested that
it merges cleanly on today's linus/master. There's a conflict with
linux-omap's for-next branch but I'll be sending a resolution still
today for that.

Patches are also sent as a reply to this mail. Pull request is below.

The following changes since commit d105e74eff7f8197b4d8e104e347ffbc5c3989b8:

  USB: ffs-test: fix header path (2011-02-28 19:27:12 -0800)

are available in the git repository at:
  git://gitorious.org/usb/usb.git for-next

Anand Gadiyar (1):
      usb: ehci: omap: add support for TLL mode on OMAP4

Felipe Balbi (4):
      usb: musb: gadget: fix list_head usage
      arm: omap: usb: host: add names to resources
      usb: host: omap: switch to platform_get_resource_byname
      arm: omap2: usb: rename usb-ehci.c to usb-host.c

Hema HK (6):
      usb: musb: Remove platform context save/restore API
      usb: musb: Idle path retention and offmode support for OMAP3
      usb: otg: TWL4030: Update the last_event variable.
      usb: otg: OMAP4430: Save/restore the context
      usb: musb: OMAP4430: Power down the PHY during board init
      usb: musb: OMAP3xxx: Fix device detection in otg & host mode

Huzaifa Sidhpurwala (1):
      usb: musb: tusb: Fix possible null pointer dereference in tusb6010_omap.c

Keshava Munegowda (7):
      arm: omap: usb: create common enums and structures for ehci and ohci
      usb: host: omap: common usb host core driver
      arm: omap: usb: usbhs core device initialization
      arm: omap: usb: Invoke usbhs core device initialization
      arm: omap: usb: cleanup ehci and ohci resources and devices
      usb: host: omap: ehci and ohci simplification
      arm: omap: usb: clock entries for omap3 and omap4

 arch/arm/mach-omap2/Makefile                   |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c            |   10 +-
 arch/arm/mach-omap2/board-3630sdp.c            |   10 +-
 arch/arm/mach-omap2/board-4430sdp.c            |   10 +-
 arch/arm/mach-omap2/board-am3517crane.c        |   10 +-
 arch/arm/mach-omap2/board-am3517evm.c          |   12 +-
 arch/arm/mach-omap2/board-cm-t35.c             |   10 +-
 arch/arm/mach-omap2/board-cm-t3517.c           |   10 +-
 arch/arm/mach-omap2/board-devkit8000.c         |   10 +-
 arch/arm/mach-omap2/board-igep0020.c           |   10 +-
 arch/arm/mach-omap2/board-igep0030.c           |   10 +-
 arch/arm/mach-omap2/board-omap3beagle.c        |   10 +-
 arch/arm/mach-omap2/board-omap3evm.c           |   14 +-
 arch/arm/mach-omap2/board-omap3pandora.c       |   10 +-
 arch/arm/mach-omap2/board-omap3stalker.c       |   10 +-
 arch/arm/mach-omap2/board-omap3touchbook.c     |   10 +-
 arch/arm/mach-omap2/board-omap4panda.c         |   10 +-
 arch/arm/mach-omap2/board-overo.c              |   10 +-
 arch/arm/mach-omap2/board-zoom.c               |   10 +-
 arch/arm/mach-omap2/clock3xxx_data.c           |   19 +-
 arch/arm/mach-omap2/clock44xx_data.c           |   10 +-
 arch/arm/mach-omap2/omap_phy_internal.c        |    7 +
 arch/arm/mach-omap2/{usb-ehci.c => usb-host.c} |  306 ++++---
 arch/arm/mach-omap2/usb-musb.c                 |    4 +
 arch/arm/plat-omap/include/plat/usb.h          |   55 +-
 drivers/mfd/Kconfig                            |    9 +
 drivers/mfd/Makefile                           |    1 +
 drivers/mfd/omap-usb-host.c                    | 1061 ++++++++++++++++++++++++
 drivers/usb/host/ehci-omap.c                   |  882 ++------------------
 drivers/usb/host/ohci-omap3.c                  |  584 ++------------
 drivers/usb/musb/musb_core.c                   |   40 +
 drivers/usb/musb/musb_core.h                   |    4 -
 drivers/usb/musb/musb_gadget.c                 |   18 +-
 drivers/usb/musb/omap2430.c                    |   70 +-
 drivers/usb/musb/tusb6010_omap.c               |    4 +-
 drivers/usb/otg/twl4030-usb.c                  |    2 +
 36 files changed, 1630 insertions(+), 1634 deletions(-)
 rename arch/arm/mach-omap2/{usb-ehci.c => usb-host.c} (68%)
 create mode 100644 drivers/mfd/omap-usb-host.c

-- 
1.7.4.rc2

