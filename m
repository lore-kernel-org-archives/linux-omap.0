From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] PHY: ti-pipe3: Manage 3.3V PHY regulator
Date: Mon, 30 Jun 2014 14:00:35 +0300
Message-ID: <1404126038-19974-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kishon-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: nm-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On some SoCs e.g. J6 the 3.3V supply to the USB2 PHY can be
powered down when the PHY is not in use. Add regulator
management code to control this power line.

cheers,
-roger
---

Roger Quadros (3):
  phy: omap-usb2: Manage PHY 3.3V supply regulator
  phy: omap-usb2: Add PHY regulator to DT binding documentation
  ARM: dts: dra7-evm: Add regulator information to USB2 PHYs

 Documentation/devicetree/bindings/phy/ti-phy.txt |  1 +
 arch/arm/boot/dts/dra7-evm.dts                   |  8 ++++++++
 drivers/phy/phy-omap-usb2.c                      | 25 ++++++++++++++++++++++++
 include/linux/phy/omap_usb.h                     |  1 +
 4 files changed, 35 insertions(+)

-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
