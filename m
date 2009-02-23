From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 00/23] ehci cleanup series
Date: Mon, 23 Feb 2009 20:52:28 +0200
Message-ID: <1235415171-17376-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46596 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336AbZBWSxN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:53:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Syed Mohammed Khasim <x0khasim@ti.com>, Felipe Balbi <me@felipebalbi.com>

Hi all,

Please give the following patches a good test. I don't have
hw to test them so any comments will be really welcome.

We still have lots to do before getting this driver upstream,
let's try to keep track of our TODO list and get this driver in
mainline for 2.6.31 merge window (2.6.30 is too close already).

Let's not try to push this driver until ES2.x and ES3.x are fully
supported, that will probably have to be done by an omap_rev
check in ehci-omap driver, also, this driver doesn't really
enumerate any attached devices, but that's old problem as Tony
told me off list.

Anyways, I guess this driver is finally walking. Me and Anand (and anyone
interested) will be discussing how to get EHCI and OHCI working fine, I'm
guessing we won't have really big issues with OHCI but you never know.

Again, please give it a good test, see if you don't have any clock issues,
NULL pointers, check if the error path is really fine, see if VBUS turns on
or not, as I said, *I HAVE NO HW TO TEST THESE*

thanks in advance for those who will read/test/comment these patches

Felipe Balbi (22):
  usb: host: ehci: make checkpatch.pl happy with ehci-omap
  usb: host: ehci: use dev_name
  usb: host: ehci: standardize variables
  usb: host: ehci: tabify structures
  usb: host: ehci: use resource helpers
  usb: host: ehci: sanitize error path
  usb: host: ehci: get rid of pm functions
  usb: host: ehci: reorganize structures
  usb: host: ehci: better function names
  usb: host: ehci: move some comments
  usb: host: ehci: add MODULE_AUTHOR
  usb: host: ehci: include <linux/gpio.h> instead
  usb: host: ehci: remove ehci-omap.h
  usb: host: ehci: get rid of infinite loops
  usb: host: ehci: disable clocks on error
  usb: host: ehci: add platform_data
  usb: host: ehci: fix register definitions
  arm: omap: make usb base defines follow trm
  usb: host: ehci: ioremap all usb bases
  usb: host: ehci: align defines
  usb: host: ehci: don't ensure register write
  usb: host: ehci: add few comments and todo

Tony Lindgren (1):
  ehci-omap: Remove defines for clock names

 arch/arm/mach-omap2/board-3430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c       |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 +-
 arch/arm/mach-omap2/board-overo.c          |    2 +-
 arch/arm/mach-omap2/usb-ehci.c             |   34 +-
 arch/arm/plat-omap/include/mach/omap34xx.h |    4 +-
 arch/arm/plat-omap/include/mach/usb.h      |   24 +-
 drivers/usb/host/Kconfig                   |   19 -
 drivers/usb/host/ehci-omap.c               |  890 +++++++++++++++++-----------
 drivers/usb/host/ehci-omap.h               |  125 ----
 11 files changed, 591 insertions(+), 515 deletions(-)
 delete mode 100644 drivers/usb/host/ehci-omap.h

