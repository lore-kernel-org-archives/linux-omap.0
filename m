From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 0/3] OMAP2/3 clock: fix module IDLEST code for unusual devs
Date: Thu, 25 Jun 2009 17:38:21 -0600
Message-ID: <20090625233647.19686.87614.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45697 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbZFYXls (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 19:41:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

After Linux enables an OMAP device's clocks, it must wait for the
device to leave the 'idle' state, or register accesses may result in
an interconnect error and subsequent system crash.  Code to do this is
currently in the OMAP clock code, but is overgeneralized, and will not
work correctly for several exception cases - one on 2430, and four on
OMAP3.

This series fixes these bugs by modularizing omap2_clk_wait_ready(),
allowing custom CM_IDLEST register and bit shift data to be supplied
on a per-clock basis, if necessary.  (This was originally fixed in the
linux-omap kernel during 2.6.29 in a slightly different manner.)

In the medium term, the module wait code will be moved to omap_hwmod or a
similar OMAP device layer.

Tested on BeagleBoard rev C2 (OMAP3530 ES3); compile-tested with the
N800 defconfig.

This second version fills in the clock.c documentation and removes one
of the custom find_idlest functions (since DSS and USBHOST use the same
target IDLEST shift).


- Paul

---

size:
   text	   data	    bss	    dec	    hex	filename
3405015	 191408	 103632	3700055	 387557	vmlinux.beagle.orig
3405475	 192144	 103632	3701251	 387a03	vmlinux.beagle

Paul Walmsley (3):
      OMAP3 clock: correct module IDLEST bits: SSI; DSS; USBHOST; HSOTGUSB
      OMAP2 clock: 2430 I2CHS uses non-standard CM_IDLEST register
      OMAP2/3 clock: split, rename omap2_wait_clock_ready()


 arch/arm/mach-omap2/clock.c             |  156 ++++++++++++++++---------------
 arch/arm/mach-omap2/clock.h             |    6 +
 arch/arm/mach-omap2/clock24xx.c         |   37 +++++++
 arch/arm/mach-omap2/clock24xx.h         |    4 -
 arch/arm/mach-omap2/clock34xx.c         |  118 ++++++++++++++++++++++-
 arch/arm/mach-omap2/clock34xx.h         |   85 +++++++++++++++--
 arch/arm/mach-omap2/prcm.c              |   43 +++++++++
 arch/arm/plat-omap/include/mach/clock.h |    2 
 arch/arm/plat-omap/include/mach/prcm.h  |    1 
 9 files changed, 353 insertions(+), 99 deletions(-)

