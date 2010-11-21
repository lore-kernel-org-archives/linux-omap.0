From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 00/12] usb: ehci-omap: add OMAP4 support
Date: Mon, 22 Nov 2010 00:10:03 +0530
Message-ID: <1290364814-4417-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series adds support for the EHCI controller on
OMAP4 chips. (This enables the ethernet controller
on the Pandaboard - finally!).

I'm sorry for the really long delay - I know this has
been in the works for a while.

I've tested the series on an OMAP4 SDP and a Pandaboard.
I'll be testing OMAP3 tomorrow.

Dependencies:
One patch depends on the mux framework patches by Benoit
- which are already in linux-next; however the series
compiles cleanly against current Linus' tree.

What's pending:
- OHCI support
- Support for TLL and HSIC modes
- Factoring out code common to ehci-omap and ohci-omap3
- Conversion to use omap_device and the hwmod database
- Runtime PM support

- Anand

Anand Gadiyar (8):
  omap: clock: add clkdev aliases for EHCI clocks
  usb: ehci-omap: use clkdev aliases for functional clocks
  usb: ehci-omap: add helpers for checking port mode
  arm: omap4: add USBHOST and related base addresses
  usb: omap4: add platform init code for EHCI driver
  omap: usb: ehci: introduce HSIC mode
  usb: ehci-omap: Add OMAP4 support
  arm: omap4: select USB_ARCH_HAS_EHCI

Keshava Munegowda (3):
  usb: ehci-omap: update clock names to be more generic
  usb: ehci-omap: don't hard-code TLL channel count
  usb: ehci: introduce CONFIG_USB_EHCI_HCD_OMAP

 arch/arm/mach-omap2/Kconfig                |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c       |    5 +
 arch/arm/mach-omap2/clock44xx_data.c       |    5 +
 arch/arm/mach-omap2/usb-ehci.c             |  144 ++++++++++++-
 arch/arm/plat-omap/include/plat/omap44xx.h |    5 +
 arch/arm/plat-omap/include/plat/usb.h      |    1 +
 drivers/usb/host/Kconfig                   |    8 +
 drivers/usb/host/ehci-hcd.c                |    2 +-
 drivers/usb/host/ehci-omap.c               |  314 +++++++++++++++++++++------
 9 files changed, 406 insertions(+), 79 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
