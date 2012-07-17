From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH v2 00/11] usb: musb: adding multi instance support
Date: Tue, 17 Jul 2012 14:43:16 +0530
Message-ID: <1342516407-16515-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52604 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2GQJNk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jul 2012 05:13:40 -0400
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

Changes from v1:
	- Defined musb_ida to manage core ids based on Felipe's comment
	  in [PATCH 01/11]
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

 .../devicetree/bindings/usb/am33xx-usb.txt         |   19 ++
 arch/arm/boot/dts/am33xx.dtsi                      |   21 +++
 arch/arm/mach-omap2/board-omap3evm.c               |    2 +-
 drivers/usb/musb/am35x.c                           |   46 +++--
 drivers/usb/musb/blackfin.c                        |   30 +++-
 drivers/usb/musb/da8xx.c                           |   38 +++--
 drivers/usb/musb/davinci.c                         |   40 +++--
 drivers/usb/musb/musb_core.c                       |   47 ++++--
 drivers/usb/musb/musb_core.h                       |    8 +
 drivers/usb/musb/musb_debugfs.c                    |   14 +-
 drivers/usb/musb/musb_dsps.c                       |  191 ++++++++++++++------
 drivers/usb/musb/omap2430.c                        |   26 ++-
 drivers/usb/musb/tusb6010.c                        |   32 +++-
 drivers/usb/musb/ux500.c                           |   33 +++-
 drivers/usb/otg/nop-usb-xceiv.c                    |   32 +++-
 include/linux/usb/otg.h                            |    9 +-
 16 files changed, 425 insertions(+), 163 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/am33xx-usb.txt

