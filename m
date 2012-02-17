From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [BUG] EHCI build dependencies broken?
Date: Fri, 17 Feb 2012 10:37:46 +0000
Message-ID: <20120217103746.GN15338@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33762 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab2BQKhw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Feb 2012 05:37:52 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

The latest randconfig build for OMAP4430SDP produced this build failure:

drivers/usb/host/ehci-hcd.c:1382:2: error: #error "missing bus glue for ehci-hcd"

This appears to be because the OMAP EHCI glue was not selected in the
configuration, but ehci-hcd was:

CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
# CONFIG_USB_EHCI_HCD_OMAP is not set
# CONFIG_USB_EHCI_MV is not set

Looking at the Kconfig file, it seems that it's entirely possible to
select EHCI_HCD without any glue selected.  It's also possible to build
EHCI with two (or more) bus glues selected - eg, it's possible for
both these to be selected:

Kconfig:
config USB_EHCI_HCD_OMAP
        bool "EHCI support for OMAP3 and later chips"
        depends on USB_EHCI_HCD && ARCH_OMAP

config USB_EHCI_MV
        bool "EHCI support for Marvell on-chip controller"
        depends on USB_EHCI_HCD

ehci-hcd.c:
#ifdef CONFIG_USB_EHCI_HCD_OMAP
#include "ehci-omap.c"
#define        PLATFORM_DRIVER         ehci_hcd_omap_driver
#endif
#ifdef CONFIG_USB_EHCI_MV
#include "ehci-mv.c"
#define        PLATFORM_DRIVER         ehci_mv_driver
#endif

So on the whole, it looks like the Kconfig for EHCI is broken.

The full config file which produced this failure will be available for
the next 7 days from:

http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=146

and the failing build log:

http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=146
