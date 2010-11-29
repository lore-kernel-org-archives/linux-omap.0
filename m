From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/4] arm: omap4: Add support for EHCI
Date: Mon, 29 Nov 2010 22:56:08 +0530
Message-ID: <1291051572-24084-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series adds the platform init code for the EHCI
controller on OMAP4 and allows the EHCI driver to be
built on OMAP4. The patches are based on v2.6.37-rc3,
and they apply cleanly on linux-next as of today.

Pin-muxing is done at one shot in the usb-ehci.c file, as
is done on OMAP3. None of the signals are on multiple pads,
so this was easy. This part depends on the mux framework
series from Benoit which is already queued up.

Also register the controller on the OMAP4 SDP. This is
already done for the Pandaboard.

This is a precursor to adapting the driver to hwmod;
I didn't want to hold up the EHCI driver so long - as the
ethernet controller on the Pandaboard needs EHCI to work.
I'll send out RFC patches for this work in a while.

The complete series (including the series going via
linux-usb) is available in my development tree [1] in the
omap4-ehci-upstream-v2 branch, if anyone wants to test.

- Anand

[1] git://dev.omapzoom.org/pub/scm/anand/linux-omap-usb.git

Anand Gadiyar (3):
  arm: omap4: add USBHOST and related base addresses
  arm: omap4: usb: add platform init code for EHCI
  arm: omap4: select USB_ARCH_HAS_EHCI

Keshava Munegowda (1):
  omap4: 4430sdp: enable the ehci port on 4430SDP

 arch/arm/mach-omap2/Kconfig                |    1 +
 arch/arm/mach-omap2/board-4430sdp.c        |   20 ++++
 arch/arm/mach-omap2/usb-ehci.c             |  144 ++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/omap44xx.h |    5 +
 4 files changed, 162 insertions(+), 8 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
