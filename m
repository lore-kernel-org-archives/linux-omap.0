From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH v2 0/8] usb: ehci-omap: add OMAP4 support
Date: Mon, 29 Nov 2010 22:55:29 +0530
Message-ID: <1291051537-23743-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58494 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754996Ab0K2RZw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 12:25:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@suse.de>, Anand Gadiyar <gadiyar@ti.com>

This series adds support for the EHCI controller on
OMAP4 chips. (This enables the ethernet controller
on the Pandaboard - finally!).

I've tested the series on an OMAP4 SDP, a Pandaboard,
and a beagleboard - all with a single kernel binary.

The complete series (including the part that can go via
linux-omap) is available in my development tree at [1]
in the omap4-ehci-upstream-v2 branch.

What changed in v2:
- Split out OMAP platform code into a separate series
  which can go through linux-omap
- Add a changelog for one patch which I missed out in v1
- Explicitly CC Paul for the clkdev aliases, and Tony
  for a change to a platform header file needed for build.

Dependencies:
- None

What's pending:
- OHCI support
- Support for TLL and HSIC modes
- Factoring out code common to ehci-omap and ohci-omap3
- Conversion to use omap_device and the hwmod database
- Runtime PM support

- Anand

[1] git://dev.omapzoom.org/pub/scm/anand/linux-omap-usb.git

Anand Gadiyar (5):
  omap: clock: add clkdev aliases for EHCI clocks
  usb: ehci-omap: use clkdev aliases for functional clocks
  usb: ehci-omap: add helpers for checking port mode
  omap: usb: ehci: introduce HSIC mode
  usb: ehci-omap: Add OMAP4 support

Keshava Munegowda (3):
  usb: ehci-omap: update clock names to be more generic
  usb: ehci-omap: don't hard-code TLL channel count
  usb: ehci: introduce CONFIG_USB_EHCI_HCD_OMAP

 arch/arm/mach-omap2/clock3xxx_data.c  |    5 +
 arch/arm/mach-omap2/clock44xx_data.c  |    5 +
 arch/arm/plat-omap/include/plat/usb.h |    1 +
 drivers/usb/host/Kconfig              |    8 +
 drivers/usb/host/ehci-hcd.c           |    2 +-
 drivers/usb/host/ehci-omap.c          |  314 +++++++++++++++++++++++++--------
 6 files changed, 264 insertions(+), 71 deletions(-)

