From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/3] OMAP2/3 clock: fix module IDLEST code for unusual devs
Date: Mon, 22 Jun 2009 01:56:03 -0600
Message-ID: <20090622075500.13566.96430.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33525 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbZFVH4w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 03:56:52 -0400
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


- Paul

---

   text    data     bss     dec     hex filename
3346788  187872  103104 3637764  378204 vmlinux.beagle.orig
3347316  188608  103104 3639028  3786f4 vmlinux.beagle


Paul Walmsley (3):
      OMAP3 clock: correct module IDLEST bits: SSI; DSS; USBHOST; HSOTGUSB
      OMAP2 clock: 2430 I2CHS uses non-standard CM_IDLEST register
      OMAP2/3 clock: split, rename omap2_wait_clock_ready()


 arch/arm/mach-omap2/clock.c             |  126 +++++++++++------------------
 arch/arm/mach-omap2/clock.h             |    6 +
 arch/arm/mach-omap2/clock24xx.c         |   37 ++++++++-
 arch/arm/mach-omap2/clock24xx.h         |    4 -
 arch/arm/mach-omap2/clock34xx.c         |  133 +++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/clock34xx.h         |   85 +++++++++++++++++---
 arch/arm/mach-omap2/prcm.c              |   43 ++++++++++
 arch/arm/plat-omap/include/mach/clock.h |    2 
 arch/arm/plat-omap/include/mach/prcm.h  |    1 
 9 files changed, 338 insertions(+), 99 deletions(-)

