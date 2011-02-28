From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH 00/10 v1] EHCI and OHCI patches of OMAP3 and OMAP4
Date: Mon, 28 Feb 2011 22:01:42 +0530
Message-ID: <1298910712-2051-1-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49512 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753116Ab1B1QcU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 11:32:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, gadiyar@ti.com, p-basak2@ti.com

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
 arch/arm/mach-omap2/clock3xxx_data.c           |   14 +-
 arch/arm/mach-omap2/clock44xx_data.c           |   10 +-
 arch/arm/mach-omap2/{usb-ehci.c => usb-host.c} |  307 +++++---
 arch/arm/plat-omap/include/plat/usb.h          |   55 +-
 drivers/mfd/Kconfig                            |    9 +
 drivers/mfd/Makefile                           |    1 +
 drivers/mfd/omap-usb-host.c                    |  981 ++++++++++++++++++++++++
 drivers/usb/host/ehci-omap.c                   |  877 ++-------------------
 drivers/usb/host/ohci-omap3.c                  |  584 ++-------------
 28 files changed, 1445 insertions(+), 1581 deletions(-)
 rename arch/arm/mach-omap2/{usb-ehci.c => usb-host.c} (68%)
 create mode 100644 drivers/mfd/omap-usb-host.c

