From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH 00/11] ARM: OMAP: USB: Host: Device tree Adaptation
Date: Wed, 31 Oct 2012 17:46:38 +0530
Message-ID: <1351685810-20616-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54834 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935501Ab2JaMRD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 08:17:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, sameo@linux.intel.com

The USB2 Host driver of OMAP3/OMAP4 are device tree complaiant with
this patch series.
The device tree data of UHH, EHCI, OHCI and TLL are included.
The drivers are updated to extract and use the register set and
interrupt numbers delivered by these device tree structures.

Keshava Munegowda (11):
  ARM: OMAP4: USB: Host: Add USB2 Host Device Tree Node
  ARM: OMAP4: USB: Host: Panda board specific device tree node
  ARM: OMAP3: USB: Add USB2 Host Device Tree Node
  ARM: OMAP3: USB: Host: Beagle-XM board specific device tree node
  ARM: OMAP: USB: Host: usb host Device tree node Adaptation
  ARM: OMAP: USB: Host: USB TLL Device tree node Adaptation
  ARM: OMAP: USB: Host: Ehci driver uses the usbhs port data
  ARM: OMAP: USB: Change the TLL clock names
  ARM: OMAP: USB: Remove the device name for TLL channel clocks for
    OMAP3
  ARM: OMAP4: USB: Add pin mux configuration for panda board
  ARM: OMAP3: USB: Add pin mux configuration for beagle-xm board

 .../devicetree/bindings/usb/omap-usb-host.txt      |   24 +++
 .../devicetree/bindings/usb/omap-usb-tll.txt       |   21 ++
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   56 +++++
 arch/arm/boot/dts/omap3.dtsi                       |   22 ++
 arch/arm/boot/dts/omap4-panda.dts                  |   51 +++++
 arch/arm/boot/dts/omap4.dtsi                       |   22 ++
 arch/arm/mach-omap2/clock3xxx_data.c               |    6 +-
 arch/arm/mach-omap2/usb-host.c                     |   68 ------
 drivers/mfd/omap-usb-host.c                        |  170 ++++++++++-----
 drivers/mfd/omap-usb-tll.c                         |  216 ++++++++++++--------
 drivers/usb/host/ehci-omap.c                       |   40 ++--
 include/linux/platform_data/usb-omap.h             |   31 ++-
 12 files changed, 485 insertions(+), 242 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/omap-usb-host.txt
 create mode 100644 Documentation/devicetree/bindings/usb/omap-usb-tll.txt

-- 
1.7.9.5

