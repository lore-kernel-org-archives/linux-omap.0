From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 00/16] OMAP USB Host cleanup
Date: Thu, 15 Nov 2012 16:33:58 +0200
Message-ID: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45633 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767923Ab2KOOeQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 09:34:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com

Hi,

This patchset addresses the following

- Avoid addressing clocks one by one by name and use a for loop + bunch
  of cleanups.
- Get number of channels/ports dynamically either from revision register
  or from platform data. Avoids getting clocks that are not present.
- Add OMAP5 and HSIC mode (Not tested)
- Save power on Panda when EHCI driver is not loaded.

cheers,
-roger

---
Andy Green (1):
  ARM: OMAP: omap4panda: Power down the USB PHY and ETH when not in use

Roger Quadros (15):
  mfd: omap-usb-tll: Avoid creating copy of platform data
  mfd: omap-usb-tll: Clean up clock handling
  mfd: omap-usb-tll: introduce and use mode_needs_tll()
  mfd: omap-usb-tll: Move port clock handling out of runtime ops
  mfd: omap-usb-tll: Add OMAP5 revision and HSIC support
  mfd: omap-usb-host: cleanup clock management code
  mfd: omap_usb_host: Avoid creating copy of platform_data
  mfd: omap-usb-host: know about number of ports from revision register
  mfd: omap-usb-host: override number of ports from platform data
  mfd: omap-usb-host: Intialize all available ports
  mfd: omap-usb-host: Manage HSIC clocks for HSIC mode
  ARM: OMAP2+: clock data: Merge utmi_px_gfclk into
    usb_host_hs_utmi_px_clk
  mfd: omap-usb-host: Get rid of unnecessary spinlock
  mfd: omap-usb-host: Support an auxiliary clock per port
  ARM: OMAP4: omap4panda: Don't enable USB PHY clock from board

 arch/arm/mach-omap2/board-omap4panda.c |   94 +++++---
 arch/arm/mach-omap2/clock3xxx_data.c   |    2 -
 arch/arm/mach-omap2/clock44xx_data.c   |   30 +--
 arch/arm/mach-omap2/usb-host.c         |    3 +
 arch/arm/plat-omap/include/plat/usb.h  |    8 +
 drivers/mfd/omap-usb-host.c            |  397 +++++++++++++++++++-------------
 drivers/mfd/omap-usb-tll.c             |  255 +++++++++++----------
 7 files changed, 454 insertions(+), 335 deletions(-)

-- 
1.7.4.1

