From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/4] Device tree support for OMAP USB Host
Date: Thu, 15 Nov 2012 16:56:32 +0200
Message-ID: <1352991396-19589-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55786 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768071Ab2KOO4i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 09:56:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, balbi@ti.com, keshava_mgowda@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, rogerq@ti.com

    Provides a means for the OMAP USB host subsystem to be initialized
    from Device tree. This is a first step for device tree migration where
    we specify only the board specific stuff. Things like I/O address space
    and interrupts are not yet specified in the device tree but can be
    done as a next step.
    
    This patch will allow boards to be booted with our without device tree
    and have USB host functional.

    Tested on OMAP4 Panda ES Rev B1.

    This patchset depends on the following series
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg80691.html

cheers,
-roger

---
Keshava Munegowda (1):
  ARM: OMAP4: USB: Add pin mux configuration for panda board

Roger Quadros (3):
  ARM: OMAP: usb-host: Device tree support for USB Host
  ARM/dts: omap4-panda: Add USB Host support
  regulator: fixed: Properly use input_supply parameter from device
    tree

 .../devicetree/bindings/arm/omap/usb-host.txt      |   60 +++++++++++++++++
 .../bindings/regulator/fixed-regulator.txt         |    6 +-
 arch/arm/boot/dts/omap4-panda.dts                  |   54 +++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |    5 ++
 arch/arm/mach-omap2/board-generic.c                |    1 +
 arch/arm/mach-omap2/common.h                       |    2 +
 arch/arm/mach-omap2/usb-host.c                     |   71 ++++++++++++++++++++
 drivers/regulator/fixed.c                          |    6 +-
 8 files changed, 200 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/usb-host.txt

-- 
1.7.4.1

