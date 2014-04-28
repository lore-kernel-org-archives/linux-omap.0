From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/7] USB support for DRA7-evm
Date: Mon, 28 Apr 2014 17:01:20 +0300
Message-ID: <1398693687-13967-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This series enables the 2 USB ports on the DRA7-evm.

NOTE: USB1 port is hard coded to work in peripheral mode and USB2 port
in host mode. This is due to missing ID pin interrupt in pre ver.E boards.

USB1 port doesn't in peripheral mode out of the box due to missing VBUS detection
and mailbox write. To test this I had to do a manual write to enable VBUSVALID
in the USB_UTMI_OTG_STATUS register.
	omapconf set bit 0x48880084 1

USB2 port works well in host mode.

Patches are based on 3.15-rc3.

cheers,
-roger

Roger Quadros (7):
  ARM: dts: dra7-clock: Add "l3init_960m_gfclk" clock gate
  ARM: DRA7: hwmod: Add SYSCONFIG for usb_otg_ss
  phy: omap-usb2: Use generic clock names "wkupclk" and "refclk"
  ARM: dts: omap4+: Add clocks to USB2 PHY node
  phy: omap-usb2: Add clock names to Documentation binding
  ARM: dts: dra7: Add USB related nodes
  dts: dra7-evm: add USB support

 Documentation/devicetree/bindings/phy/ti-phy.txt |   7 ++
 arch/arm/boot/dts/dra7-evm.dts                   |  24 ++++
 arch/arm/boot/dts/dra7.dtsi                      | 149 +++++++++++++++++++++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi             |  12 +-
 arch/arm/boot/dts/omap4.dtsi                     |   2 +
 arch/arm/boot/dts/omap5.dtsi                     |   2 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c        |  22 ++--
 drivers/phy/phy-omap-usb2.c                      |   8 +-
 8 files changed, 210 insertions(+), 16 deletions(-)

-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
