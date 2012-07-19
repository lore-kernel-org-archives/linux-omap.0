From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 00/11] usb: musb: adding multi instance support
Date: Thu, 19 Jul 2012 17:15:56 +0530
Message-ID: <1342698367-12978-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

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

Changes from v3:
	- Fixed Kishon's comment on removing "id" from phy struct and
	  removing unneeded "#else" part.
Changes from v2:
	- Fixed Sergei's comment on not using address prefix in musb_dsps
	  glue and nop transceiver dt dats.
	- Also removed the "ti" string in compatible property for nop data.
Changes from v1:
	- Defined musb_ida to manage core ids based on Felipe's comment
	  in [PATCH 01/11]

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
 drivers/usb/musb/musb_dsps.c                       |  189 ++++++++++++++------
 drivers/usb/musb/omap2430.c                        |   26 ++-
 drivers/usb/musb/tusb6010.c                        |   32 +++-
 drivers/usb/musb/ux500.c                           |   33 +++-
 drivers/usb/otg/nop-usb-xceiv.c                    |   29 +++-
 include/linux/usb/otg.h                            |    8 +-
 16 files changed, 419 insertions(+), 163 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/am33xx-usb.txt

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
