From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH] nand support on omap3 boards
Date: Tue, 13 Apr 2010 23:14:21 +0530
Message-ID: <1271180661-31802-1-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57174 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab0DMRoZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 13:44:25 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3DHiMPI011737
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Apr 2010 12:44:25 -0500
In-Reply-To: <Sukumar Ghorai <s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>

   The following set of patches applies on top of the Tony's master branch.
   And these are the patches required to enable nand (nor and onenand for sdp
   only) for different platform.

Sukumar Ghorai (3):
  OMAP: ZOOM: Introducing 'board-zoom-flash.c'
  omap3: add support for NAND on zoom2 board
  omap3: add support for NAND on zoom3 board
  omap-3630-sdp : Add support for Flash
  omap-3630-sdp: enable Flash device support
  omap3: add support for NAND on LDP board
  zoom2: enable NAND support
  zoom3: enable NAND support

 arch/arm/configs/omap_3630sdp_defconfig       |   77 +++++++++++++++++-
 arch/arm/configs/omap_zoom2_defconfig         |   90 ++++++++++++++++++++-
 arch/arm/configs/omap_zoom3_defconfig         |   90 ++++++++++++++++++++-
 arch/arm/mach-omap2/Makefile                  |    4 +
 arch/arm/mach-omap2/board-3630sdp.c           |  110 +++++++++++++++++++++++++
 arch/arm/mach-omap2/board-ldp.c               |   41 +++++++++
 arch/arm/mach-omap2/board-sdp-flash.c         |    2 +
 arch/arm/mach-omap2/board-zoom-flash.c        |   82 ++++++++++++++++++
 arch/arm/mach-omap2/board-zoom2.c             |   49 +++++++++++
 arch/arm/mach-omap2/board-zoom3.c             |   48 +++++++++++
 arch/arm/mach-omap2/include/mach/board-zoom.h |   11 +++
 11 files changed, 601 insertions(+), 3 deletions(-) create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c

