From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/8] phy: omap-usb: Support multiple instances and new types
Date: Thu, 15 Aug 2013 16:15:04 +0300
Message-ID: <1376572512-9561-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, dmurphy-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This patchset does the following:

* Get rid of omap_control_usb platform data as we support DT only.

* Restructure and add support for new PHY types. We now support the follwing
four types

 TYPE_OMAP - if it has otghs_control mailbox register (e.g. on OMAP4)
 TYPE_USB2 - if it has Power down bit in control_dev_conf register. e.g. USB2 PHY
 TYPE_USB3 - if it has DPLL and individual Rx & Tx power control. e.g. USB3 PHY or SATA PHY
 TYPE_DRA7 - if it has both power down and power aux registers. e.g. USB2 PHY on DRA7

* Get rid of "ti,type" DT property and introduce compatible strings for each type.

* Have only one power control API "omap_control_usb_phy_power()" instead of a
different one for each PHY type.

* Get rid of omap_get_control_dev() so that we can support multiple instances
of the control device. We take advantage of the fact that omap control USB device
is only present on OMAP4 onwards and hence only supports DT boot. The users
of control USB device can get a reference to it from the device node's phandle.

Patches are based on balbi/next.

Smoke tested on OMAP4 panda with MUSB in gadget mode (g_zero).

You can find the patches in branch
 usb-control-module
in git tree
 git://github.com/rogerq/linux.git

v2:
- get rid of "ti,type" property and introduce compatible strings for each device type.

cheers,
-roger

---
Roger Quadros (8):
  usb: phy: omap-control: Get rid of platform data
  usb: phy: omap: Add new device types and remove
    omap_control_usb3_phy_power()
  usb: phy: omap-usb2: Don't use omap_get_control_dev()
  usb: phy: omap-usb3: Don't use omap_get_control_dev()
  usb: musb: omap2430: Don't use omap_get_control_dev()
  usb: phy: omap: get rid of omap_get_control_dev()
  ARM: dts: omap4: update omap-control-usb nodes
  ARM: dts: omap5: update omap-control-usb node

 Documentation/devicetree/bindings/usb/omap-usb.txt |   29 ++--
 arch/arm/boot/dts/omap4.dtsi                       |   17 ++-
 arch/arm/boot/dts/omap5.dtsi                       |   20 ++-
 drivers/usb/musb/omap2430.c                        |   22 ++-
 drivers/usb/phy/phy-omap-control.c                 |  189 +++++++++++---------
 drivers/usb/phy/phy-omap-usb2.c                    |   20 ++-
 drivers/usb/phy/phy-omap-usb3.c                    |   26 ++-
 include/linux/usb/omap_control_usb.h               |   33 ++---
 8 files changed, 206 insertions(+), 150 deletions(-)

-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
