From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 00/11] usb: musb: adding multi instance support
Date: Thu, 12 Jul 2012 15:23:23 +0530
Message-ID: <1342086814-32181-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36835 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758992Ab2GLJxu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jul 2012 05:53:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Hi,

This series of patches adds,
a) Multi instances support in musb driver
b) DT support for musb_dsps glue layer
c) DT support for NOP transceiver

AM33xx and TI81xx has dual musb controller and has two usb PHY of same type.
This patch series uses 'phandle' based API devm_usb_get_phy_by_phandle() to
get the PHY of same type. This API support is being added by Kishon's patch
discussed at [1]

The series applies to linux-omap (master branch)
	+ Vaibhav baseport patches on his tree at [3]
	+ Kishon's multi phy patches on Felipe's branch 'xceiv'
	+ Kishon's patch on phandle at [1]
	+ AM33xx musb glue compile and bugfix patches at [4], [5], [6] and [7]
	+ Damodar's recent patch at [2] 

and have been tested on Beaglebone board.

1. http://marc.info/?l=linux-usb&m=134070369306112&w=2
2. http://marc.info/?l=linux-usb&m=134200284230689&w=2
3. https://github.com/hvaibhav/am335x-linux/commits/am335x-upstream-staging
4. http://marc.info/?l=linux-usb&m=134131746111637&w=2
5. http://marc.info/?l=linux-usb&m=134131746411639&w=2
6. http://marc.info/?l=linux-usb&m=134062716011251&w=2
7. http://marc.info/?l=linux-usb&m=134061179405213&w=2

Thanks,
Ajay

Ajay Kumar Gupta (11):
  usb: musb: add musb->id to identify core instance
  usb: musb: kill global and static for multi instance
  usb: musb: am335x: add support for dual instance
  usb: otg: nop: add support for multiple tranceiver
  usb: musb: dsps: add dt support
  arm/dts: am33xx: Add dt data for usbss
  usb: otg: nop: add dt support
  arm/dts: am33xx: add dt data for usb nop phy
  usb: musb: dsps: remove explicit NOP device creation
  usb: musb: dsps: get the PHY using phandle api
  arm/dts: am33xx: add phy phandle to usbss

 .../devicetree/bindings/usb/am33xx-usb.txt         |   19 +++
 arch/arm/boot/dts/am33xx.dtsi                      |   21 +++
 arch/arm/mach-omap2/board-omap3evm.c               |    2 +-
 drivers/usb/musb/am35x.c                           |    6 +-
 drivers/usb/musb/blackfin.c                        |    6 +-
 drivers/usb/musb/da8xx.c                           |    6 +-
 drivers/usb/musb/davinci.c                         |    8 +-
 drivers/usb/musb/musb_core.c                       |   18 +--
 drivers/usb/musb/musb_core.h                       |    6 +
 drivers/usb/musb/musb_debugfs.c                    |   14 +-
 drivers/usb/musb/musb_dsps.c                       |  169 ++++++++++++++------
 drivers/usb/musb/omap2430.c                        |    2 +-
 drivers/usb/musb/tusb6010.c                        |    8 +-
 drivers/usb/musb/ux500.c                           |    2 +-
 drivers/usb/otg/nop-usb-xceiv.c                    |   32 +++-
 include/linux/usb/otg.h                            |    9 +-
 16 files changed, 226 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/am33xx-usb.txt

