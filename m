From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 00/13] Device tree support for OMAP HS USB Host
Date: Mon, 4 Feb 2013 17:58:47 +0200
Message-ID: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

This patchset adds device tree support for OMAP's High Speed USB Host
subsystem. Board adaptation for Panda and Beagleboard is also provided.

Tested on Beagleboard.

Will only work with Panda if we provide a reference to the PHY clock
generator in the device tree in PATCH 11. I do not know how to do that
as there is no way to provide a phandle to any of the OMAP generated clocks
in the device tree. Suggestions welcome :).

Based on linux-next:next-20130204

Depends on "USB: omap-ehci: Move PHY management to PHY driver"
	git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:rogerq/linux.git next-usbhost16

The following changes since commit 8c00470e1308d08df1f2b2c7e9a561d868ec0526:

  USB: ehci-omap: Select NOP USB transceiver driver (2013-02-04 16:36:06 +0200)

are available in the git repository at:
  git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:rogerq/linux.git next-usbhost16-dt

Roger Quadros (13):
  usb: phy: nop: Add device tree support and binding information
  USB: phy: nop: Defer probe if device needs VCC/RESET
  mfd: omap-usb-tll: move configuration code to omap_tll_init()
  mfd: omap-usb-tll: Add device tree support
  USB: ehci-omap: Get platform resources by index rather than by name
  USB: ohci-omap3: Get platform resources by index rather than by name
  USB: ohci-omap3: Add device tree support and binding information
  USB: ehci-omap: Add device tree support and binding information
  mfd: omap-usb-host: Add device tree support and binding information
  ARM: dts: OMAP4: Add HS USB Host IP nodes
  ARM: dts: omap4-panda: Add USB Host support
  ARM: dts: OMAP3: Add HS USB Host IP nodes
  ARM: dts: omap3-beagle: Add USB Host support

 .../devicetree/bindings/mfd/omap-usb-host.txt      |   68 +++++++
 .../devicetree/bindings/mfd/omap-usb-tll.txt       |   17 ++
 .../devicetree/bindings/usb/omap-ehci.txt          |   34 +++
 .../devicetree/bindings/usb/omap3-ohci.txt         |   17 ++
 .../devicetree/bindings/usb/usb-nop-xceiv.txt      |   34 +++
 arch/arm/boot/dts/omap3-beagle.dts                 |   71 +++++++
 arch/arm/boot/dts/omap3.dtsi                       |   31 +++
 arch/arm/boot/dts/omap4-panda.dts                  |   55 +++++
 arch/arm/boot/dts/omap4.dtsi                       |   30 +++
 drivers/mfd/omap-usb-host.c                        |   90 ++++++++-
 drivers/mfd/omap-usb-tll.c                         |  213 ++++++++++----------
 drivers/mfd/omap-usb.h                             |    5 +-
 drivers/usb/host/ehci-omap.c                       |   41 ++++-
 drivers/usb/host/ohci-omap3.c                      |   24 ++-
 drivers/usb/otg/nop-usb-xceiv.c                    |   39 ++++
 include/linux/usb/nop-usb-xceiv.h                  |    4 +
 16 files changed, 651 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-host.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
 create mode 100644 Documentation/devicetree/bindings/usb/omap-ehci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/omap3-ohci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt

-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
