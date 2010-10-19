From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC v2 0/7] OMAP4: mux: Add the OMAP4430 ES1 & ES2 support
Date: Wed, 20 Oct 2010 00:22:29 +0200
Message-ID: <1287526956-21853-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38404 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904Ab0JSWXJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 18:23:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, nm@ti.com, Benoit Cousson <b-cousson@ti.com>

Hi Tony,

Upon Nishanth request, here is the updated version...

It takes into account your proposal to store partition
information in a partition structure instead of inside every pad entries.
The mechanism relies on the uniqueness of the pad name in each partition to
find the correct partition during iteration.

Removed as well some cpu_is_xxx calls from the core code by adding a couple of
flags during partition init.

Please note that due to low level access to mux api from the RX51 board code,
I have to disable the mux change to build properly with omap2plus_defconfig.
Look like you do have some idea to fix that :-)
I was thinking of:
- brute force approach that consist of keeping all the data after init, and
thus allowing removing the __init in the omap_mux_init_signal API
- or adding some flag in the pad entry to keep them after init .


Boot tested on SDP4430 with ES1.0 & ES2.0 with omap2plus_defconfig. Still require
some real driver to use that mux API in order to validate it.

The series is on top of lo/master (2.6.36-rc8) and is available here:
git://gitorious.org/omap-pm/linux.git ctrl-wip/mux-omap4-v2


Thanks,
Benoit


v1:
    http://www.spinics.net/lists/linux-omap/msg37158.html    


Benoit Cousson (7):
  OMAP: mux: Replace printk with pr_xxx macros
  OMAP3: RX-51: Temporary disable dynamic mux change for eMMC
  OMAP: mux: Add support for control module split in several partitions
  OMAP4: mux: Add CBL package data for OMAP4430 ES1
  OMAP4: mux: Select CBL package for SDP4430 with ES1
  OMAP4: mux: Add CBS package data for OMAP4430 ES2
  OMAP4: mux: Select CBS package for SDP4430 with ES2

 arch/arm/mach-omap2/Kconfig                  |    8 +
 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/board-4430sdp.c          |   14 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |    3 +-
 arch/arm/mach-omap2/mux.c                    |  330 ++++--
 arch/arm/mach-omap2/mux.h                    |   92 +-
 arch/arm/mach-omap2/mux2420.c                |    7 +-
 arch/arm/mach-omap2/mux2430.c                |    7 +-
 arch/arm/mach-omap2/mux34xx.c                |    7 +-
 arch/arm/mach-omap2/mux44xx.c                | 1625 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux44xx.h                |  298 +++++
 11 files changed, 2229 insertions(+), 163 deletions(-)
 create mode 100644 arch/arm/mach-omap2/mux44xx.c
 create mode 100644 arch/arm/mach-omap2/mux44xx.h

