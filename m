From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 00/10] EHCI and OHCI patches of OMAP3 and OMAP4
Date: Sat, 26 Feb 2011 04:36:28 +0530
Message-ID: <1298675198-14214-1-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, p-basak2-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

this is how it EHCI/OHCI code re oraganize look like:
	. we have EHCI and OHCI be children of a usbhs "core driver"
		which will take care of all accesses to
		UHH and TLL bases. 

	. we pass enable/disable functions down from EHCI and OHCI drivers.
		to USBHS driver.

	. UHH and TLL power management will eventually move to
		omap-usb-host.c


Felipe Balbi (3):
  arm: omap: usb: host: add names to resources
  usb: host: omap: switch to platform_get_resource_byname
  arm: omap2: usb: rename usb-ehci.c to usb-host.c

Keshava Munegowda (7):
  arm: omap: usb: create enums and structures for ehci and ohci
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
 arch/arm/mach-omap2/clock3xxx_data.c           |   14 +-
 arch/arm/mach-omap2/clock44xx_data.c           |   10 +-
 arch/arm/mach-omap2/{usb-ehci.c => usb-host.c} |  305 +++++---
 arch/arm/plat-omap/include/plat/usb.h          |   55 +-
 drivers/mfd/Kconfig                            |    9 +
 drivers/mfd/Makefile                           |    1 +
 drivers/mfd/omap-usb-host.c                    |  981 ++++++++++++++++++++++++
 drivers/usb/host/ehci-omap.c                   |  881 ++-------------------
 drivers/usb/host/ohci-omap3.c                  |  584 ++-------------
 28 files changed, 1444 insertions(+), 1584 deletions(-)
 rename arch/arm/mach-omap2/{usb-ehci.c => usb-host.c} (68%)
 create mode 100644 drivers/mfd/omap-usb-host.c

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
