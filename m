From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 0/8] phy: omap-usb: Support multiple instances and new types
Date: Mon, 26 Aug 2013 18:08:25 +0300
Message-ID: <1377529713-19762-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46584 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664Ab3HZPJO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Aug 2013 11:09:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, bcousson@baylibre.com
Cc: tony@atomide.com, george.cherian@ti.com, kishon@ti.com, bigeasy@linutronix.de, sergei.shtylyov@cogentembedded.com, thomas.langer@lantiq.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

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

v6:
- addressed review comment about usage of control_usb before allocation.

v5:
- fixed whitespace alignment issues.

v4:
- removed "ti,has-mailbox" from omap-usb binding document example.

v3:
- return -EINVAL instead of -ENODEV on probe failure.
- pass device type data through of_device_id table.
- get rid of "ti,mailbox" property and "has_mailbox" from musb platform data.

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

 Documentation/devicetree/bindings/usb/omap-usb.txt |   33 ++--
 arch/arm/boot/dts/omap4.dtsi                       |   20 ++-
 arch/arm/boot/dts/omap5.dtsi                       |   20 ++-
 drivers/usb/musb/omap2430.c                        |   25 ++-
 drivers/usb/phy/phy-omap-control.c                 |  210 +++++++++++---------
 drivers/usb/phy/phy-omap-usb2.c                    |   26 ++-
 drivers/usb/phy/phy-omap-usb3.c                    |   32 +++-
 include/linux/usb/musb.h                           |    2 -
 include/linux/usb/omap_control_usb.h               |   33 ++--
 9 files changed, 226 insertions(+), 175 deletions(-)

-- 
1.7.4.1

