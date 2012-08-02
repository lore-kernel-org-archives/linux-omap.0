From: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v7 00/11] usb: musb: adding multi instance support
Date: Thu, 2 Aug 2012 17:42:43 +0530
Message-ID: <1343909574-15633-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
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

Changes from v6:
	- Removed parent_pdev to get glue and used dev_get_getdrv() as per
	  Felipe's comment
	- use pr_debug() instead of pr_info() as per Felipe's comment
Changes from v5:
	- Removed musb->id as per Felipe's comment
	- used nop_ida as per Felipe's comment
Changes from v4:
	- Fixed Felipe's comment for adding EXPORT_SYMBOL_GPL()
	- Fixed Felipe's comment on using dev_set_mask()
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

Ajay Kumar Gupta (10):
  usb: musb: add musb_ida for multi instance support
  usb: musb: kill global and static for multi instance
  usb: musb: am335x: add support for dual instance
  usb: otg: nop: add support for multiple tranceiver
  usb: musb: dsps: add dt support
  arm/dts: am33xx: Add dt data for usbss
  usb: otg: nop: add dt support
  arm/dts: am33xx: add dt data for usb nop phy
  usb: musb: dsps: remove explicit NOP device creation
  arm/dts: am33xx: add phy phandle to usbss

Ravi Babu (1):
  usb: musb: dsps: get the PHY using phandle api

 .../devicetree/bindings/usb/am33xx-usb.txt         |   19 ++
 arch/arm/boot/dts/am33xx.dtsi                      |   21 ++
 drivers/usb/musb/am35x.c                           |   44 +++--
 drivers/usb/musb/blackfin.c                        |   28 ++-
 drivers/usb/musb/da8xx.c                           |   36 +++-
 drivers/usb/musb/davinci.c                         |   38 +++--
 drivers/usb/musb/musb_core.c                       |   53 ++++--
 drivers/usb/musb/musb_core.h                       |    6 +
 drivers/usb/musb/musb_debugfs.c                    |    8 +-
 drivers/usb/musb/musb_dsps.c                       |  210 +++++++++++++-------
 drivers/usb/musb/omap2430.c                        |   26 ++-
 drivers/usb/musb/tusb6010.c                        |   30 ++-
 drivers/usb/musb/ux500.c                           |   33 +++-
 drivers/usb/otg/nop-usb-xceiv.c                    |   64 ++++++-
 include/linux/usb/otg.h                            |    4 +-
 15 files changed, 455 insertions(+), 165 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/am33xx-usb.txt

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
