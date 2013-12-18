From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 0/6] net: cpsw: Support for am335x chip MACIDs
Date: Wed, 18 Dec 2013 17:47:16 +0100
Message-ID: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This series introduces a driver to read and use the MACIDs stored in the am335x
control module. These are read-only registers for a unique MACID. At the moment
the MACIDs are generated randomly or they are set by the bootloader.

A device node is added in am33xx dtsi and used by the cpsw slaves in the bone
board files.

Regards,

Markus


Markus Pargmann (6):
  DT doc: net: cpsw mac-address is optional
  net: cpsw: header, Add missing include
  net: cpsw: Add control-module macid driver
  net: cpsw: Use cpsw-ctrl-macid driver
  arm: dts: am33xx, Add device node for cpsw-ctrl-macid
  arm: dts: am335x beagle bone use processor macids

 .../devicetree/bindings/net/cpsw-ctrl-macid.txt    |  31 +++++
 Documentation/devicetree/bindings/net/cpsw.txt     |   7 +-
 arch/arm/boot/dts/am335x-bone.dts                  |   8 ++
 arch/arm/boot/dts/am335x-boneblack.dts             |   8 ++
 arch/arm/boot/dts/am33xx.dtsi                      |   7 ++
 drivers/net/ethernet/ti/Kconfig                    |   8 ++
 drivers/net/ethernet/ti/Makefile                   |   1 +
 drivers/net/ethernet/ti/cpsw-ctrl-macid.c          | 138 +++++++++++++++++++++
 drivers/net/ethernet/ti/cpsw.c                     |  18 ++-
 drivers/net/ethernet/ti/cpsw.h                     |   3 +
 10 files changed, 224 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
 create mode 100644 drivers/net/ethernet/ti/cpsw-ctrl-macid.c

-- 
1.8.5.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
