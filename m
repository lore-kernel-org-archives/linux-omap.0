From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/7] OMAP4: mux: Add the OMAP4430 ES1.0 & ES2.x support
Date: Thu, 11 Nov 2010 22:35:14 +0100
Message-ID: <1289511321-18532-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50260 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464Ab0KKVfp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Nov 2010 16:35:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi Tony,

Here is the version updated with your fixes.
This is the first non RFC version to make Nishant M. happy;-)

Thanks to you, the RX-51 is now handled properly and the low level API
is still public like before for dynamic mux use.

The pandaboard is now supported thanks to Sricharan, and a couple of bugs
are fixed, thanks to Dan who reported them.

The series is based on mainline (2.6.37-rc1) and is available here:
git://gitorious.org/omap-pm/linux.git ctrl-wip/mux-omap4-v3

Tested on SDP4430 ES1.0, ES2.0 and ES2.1 with omap2plus_defconfig.
Still require some test on OMAP3 and OMAP2.

Thanks,
Benoit


RFC v2:
    http://www.spinics.net/lists/linux-omap/msg38995.html
    
    - Take into account Tony's proposal to store partition information
    in a partition structure instead of inside every pad entries.
    - Remove some cpu_is_xxx calls from the core code by adding a
    couple of flags during partition init.

RFC v1:
    http://www.spinics.net/lists/linux-omap/msg37158.html    


Benoit Cousson (6):
  OMAP: mux: Replace printk with pr_xxx macros
  OMAP: mux: Add support for control module split in several partitions
  OMAP4: mux: Add CBL package data for OMAP4430 ES1
  OMAP4: sdp4430: Select CBL package for ES1 and initialize mux
  OMAP4: mux: Add CBS package data for OMAP4430 ES2
  OMAP4: sdp4430: Select CBS package for ES2

sricharan (1):
  OMAP4: pandaboard: Select CBL & CBS package and initialize mux

 arch/arm/mach-omap2/Kconfig                  |   10 +
 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/board-4430sdp.c          |   14 +
 arch/arm/mach-omap2/board-omap4panda.c       |   16 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |   12 +-
 arch/arm/mach-omap2/mux.c                    |  342 ++++--
 arch/arm/mach-omap2/mux.h                    |   84 ++-
 arch/arm/mach-omap2/mux2420.c                |    7 +-
 arch/arm/mach-omap2/mux2430.c                |    7 +-
 arch/arm/mach-omap2/mux34xx.c                |    7 +-
 arch/arm/mach-omap2/mux44xx.c                | 1625 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux44xx.h                |  298 +++++
 12 files changed, 2279 insertions(+), 144 deletions(-)
 create mode 100644 arch/arm/mach-omap2/mux44xx.c
 create mode 100644 arch/arm/mach-omap2/mux44xx.h

