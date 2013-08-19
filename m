From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 0/8] phy: omap-usb: Support multiple instances and new types
Date: Mon, 19 Aug 2013 13:37:39 +0300
Message-ID: <1376908667-14974-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com, bcousson@baylibre.com
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, tony@atomide.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
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
 drivers/usb/phy/phy-omap-usb3.c                    |   28 ++-
 include/linux/usb/musb.h                           |    2 -
 include/linux/usb/omap_control_usb.h               |   33 ++--
 9 files changed, 224 insertions(+), 173 deletions(-)

-- 
1.7.4.1
