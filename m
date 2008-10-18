From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/5] PM: add omapdev code
Date: Sat, 18 Oct 2008 15:59:08 -0600
Message-ID: <20081018215247.9699.35039.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45267 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbYJRWAJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Oct 2008 18:00:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch series provides an initial representation for most on-chip
devices on OMAP2/3 chips, 'struct omapdev'.  Currently, it is used to
map platform_devices to the corresponding powerdomains for the OMAP PM
code.  In the future, the intention is to use these structures to
initialize on-chip devices at boot and to clean up device
registration.  Detailed notes are in the patch descriptions, and in the
code comments in the final patch.

Tested on 3430SDP and 2430SDP.

(This patchset was formerly known as the "tiocp" patchset.)


- Paul

---
   text    data     bss     dec     hex filename
3459409  159880  105744 3725033  38d6e9 vmlinux.3430sdp.orig
3461481  163344  105744 3730569  38ec89 vmlinux.3430sdp

 arch/arm/mach-omap2/Makefile              |    2 
 arch/arm/mach-omap2/io.c                  |    3 
 arch/arm/mach-omap2/omapdev-common.h      |  309 +++++++++++
 arch/arm/mach-omap2/omapdev.c             |  177 ++++++
 arch/arm/mach-omap2/omapdev242x.h         |  581 +++++++++++++++++++++
 arch/arm/mach-omap2/omapdev243x.h         |  661 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omapdev3xxx.h         |  802 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/omapdev.h |   58 ++
 8 files changed, 2592 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omapdev-common.h
 create mode 100644 arch/arm/mach-omap2/omapdev.c
 create mode 100644 arch/arm/mach-omap2/omapdev242x.h
 create mode 100644 arch/arm/mach-omap2/omapdev243x.h
 create mode 100644 arch/arm/mach-omap2/omapdev3xxx.h
 create mode 100644 arch/arm/plat-omap/include/mach/omapdev.h


