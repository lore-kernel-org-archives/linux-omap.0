From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v2 0/8] introduce 3630 boards
Date: Tue, 10 Nov 2009 16:47:21 -0600
Message-ID: <1257893249-15467-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38032 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbZKJWsE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Nov 2009 17:48:04 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAAMm9da012786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 16:48:09 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Introducing 3630 boards: zoom3 and sdp3630

The peripherals are very similar for the two bards as per this discussion:
	http://marc.info/?l=linux-omap&m=125676595710748&w=2

So maximum reuse is done for the board files for zoom3 and sdp3630

V1: Review comments incorporated:
	http://marc.info/?l=linux-omap&m=125632676504364&w=2
	http://marc.info/?l=linux-omap&m=125632720804869&w=2
	http://marc.info/?l=linux-omap&m=125633994320138&w=2

V2: Review comments by Nishanth Menon
	http://marc.info/?l=linux-omap&m=125728617825678&w=2
	http://marc.info/?l=linux-omap&m=125728665226332&w=2
	http://marc.info/?l=linux-omap&m=125728729027309&w=2
	http://marc.info/?l=linux-omap&m=125728749327603&w=2

Vikram Pandita (8):
  omap: 3630: update is_chip variable
  omap: DEBUG_LL: allow no omap uart configuration
  omap: zoom2: split board file for reuse
  omap: zoom2: update defconfig
  omap: zoom3: introduce zoom3 board support
  omap: zoom3: defconfig creation
  omap: 3630sdp: introduce 3630 sdp board support
  omap: 3630sdp: defconfig creation

 arch/arm/configs/omap_3630sdp_defconfig            | 1606 ++++++++++++++++++++
 arch/arm/configs/omap_zoom2_defconfig              |  231 ++--
 arch/arm/configs/omap_zoom3_defconfig              | 1605 +++++++++++++++++++
 arch/arm/mach-omap2/Kconfig                        |    8 +
 arch/arm/mach-omap2/Makefile                       |    8 +
 arch/arm/mach-omap2/board-3630sdp.c                |   96 ++
 arch/arm/mach-omap2/board-zoom-peripherals.c       |  403 +++++
 arch/arm/mach-omap2/board-zoom2.c                  |  261 +---
 arch/arm/mach-omap2/board-zoom3.c                  |   59 +
 arch/arm/mach-omap2/id.c                           |    2 +
 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h |   52 +
 arch/arm/plat-omap/Kconfig                         |    3 +
 arch/arm/plat-omap/include/plat/cpu.h              |    7 +-
 arch/arm/plat-omap/include/plat/uncompress.h       |    4 +-
 14 files changed, 4005 insertions(+), 340 deletions(-)
 create mode 100644 arch/arm/configs/omap_3630sdp_defconfig
 create mode 100644 arch/arm/configs/omap_zoom3_defconfig
 create mode 100755 arch/arm/mach-omap2/board-3630sdp.c
 create mode 100644 arch/arm/mach-omap2/board-zoom-peripherals.c
 create mode 100644 arch/arm/mach-omap2/board-zoom3.c
 create mode 100644 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h

