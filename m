From: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/5] Add phy support for AM335X platform using Generic PHy framework
Date: Mon, 8 Jul 2013 16:13:16 +0530
Message-ID: <1373280201-31785-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch series adds phy support for AM335X platform.
This patch series is based on Generic PHY framework [1]. 


This series has
	- adds dual musb instances support for am335x platform (just for testing)
	- adds phy-amxxxx-usb driver used in AMxxxx platforms
	- adds dt  bindings for the phys
	- removes usb-phy and replaced with generic phy apis in glue layer

All these changes are avilable at [2]

[1] - http://marc.info/?l=linux-usb&m=137224750928570&w=2
[2] - git://git.ti.com/~georgecherian/ti-linux-kernel/georgec-connectivity-linux-feature-tree.git 
	am335x-phy-driver

George Cherian (4):
  usb: phy: phy-omap-control: Add API to power on/off USB PHY for AM335X
  phy: phy-amxxxx-usb: Add PHY driver for amxxxx platform
  arm: dts: Add USB phy nodes for AM33XX
  usb: musb: dsps: Remove the phy control from glue and add phy driver
    APIs

Ravi Babu (1):
  usb: musb: dsps: enable dual instance support for am33xx platform

 arch/arm/boot/dts/am33xx.dtsi        |  22 ++++
 drivers/phy/Kconfig                  |  12 +++
 drivers/phy/Makefile                 |   1 +
 drivers/phy/phy-amxxxx-usb.c         | 201 +++++++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_dsps.c         | 107 +++++++------------
 drivers/usb/phy/phy-omap-control.c   |  32 ++++++
 include/linux/usb/omap_control_usb.h |  11 ++
 7 files changed, 316 insertions(+), 70 deletions(-)
 create mode 100644 drivers/phy/phy-amxxxx-usb.c

-- 
1.8.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
