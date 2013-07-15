From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/4] Enable USB3 for OMAP5
Date: Mon, 15 Jul 2013 18:33:39 +0300
Message-ID: <1373902423-28654-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53604 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932244Ab3GOPec (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jul 2013 11:34:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>

Hi,

I have just tested all these patches on OMAP5 uEVM and it's
working fine.

| [1141397.137900] usb 10-2: USB disconnect, device number 3
| [1142023.549485] usb 10-2: new SuperSpeed USB device number 4 using xhci_hcd
| [1142024.185535] usb 10-2: Parent hub missing LPM exit latency info.  Power management will be impacted.
| [1142025.458738] usb 10-2: New USB device found, idVendor=0525, idProduct=a4a0
| [1142025.458744] usb 10-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
| [1142025.458748] usb 10-2: Product: Gadget Zero
| [1142025.458752] usb 10-2: Manufacturer: Linux 3.11.0-rc1-00068-g6df6cd3-dirty with dwc3-gadget
| [1142025.458755] usb 10-2: SerialNumber: 0123456789.0123456789.0123456789
| [1142025.866540] usbtest 10-2:3.0: Linux gadget zero
| [1142025.866547] usbtest 10-2:3.0: super-speed {control in/out bulk-in bulk-out} tests (+alt)

please consider applying them.

Benoit Cousson (1):
  arm: omap5: hwmod: add missing ocp2scp hwmod data

Felipe Balbi (3):
  arm: omap5: dts: fix reg property size
  arm: omap5: dts: add palmas-usb node
  arm: omap2plus_defconfig: enable dwc3 and dependencies

 arch/arm/boot/dts/omap5-uevm.dts           | 10 +++++++
 arch/arm/boot/dts/omap5.dtsi               |  9 +++---
 arch/arm/configs/omap2plus_defconfig       |  9 ++++++
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 45 ++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 4 deletions(-)

-- 
1.8.2.1

