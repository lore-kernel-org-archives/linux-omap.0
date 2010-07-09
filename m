From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v4 0/8] nand support on omap3 boards
Date: Fri,  9 Jul 2010 19:57:46 +0530
Message-ID: <1278685671-12036-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50122 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab0GIO2C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 10:28:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>

   The following set of patches applies on top of for-next branch.
   And these are the patches required to enable nand (nor and onenand for sdp
   only) for different platform.
   
   v4: patch rebase on latest code base; depend on
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31950.html
   
   v3:  http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30735.html
	patch rebase on latest nand patch and depend on -
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30305.html
   
   v2: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26479.html
	rework to use full nand in partition table of ZOOM2/3;
	ZOOM1(LDP)support added.
		
   v1: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg22205.html

Sukumar Ghorai (5):
	omap3 flash: rename board-sdp-flash.c to be use by other boards
	omap3: add support for NAND on zoom2 board
	omap3: add support for NAND on zoom3 board
	omap-3630-sdp : Add support for Flash
	omap3: add support for NAND on LDP board

 arch/arm/mach-omap2/Makefile                  |    6 +-
 arch/arm/mach-omap2/board-3430sdp.c           |   16 +++-
 arch/arm/mach-omap2/board-3630sdp.c           |  120 +++++++++++++++++++++++++
 arch/arm/mach-omap2/board-ldp.c               |   35 +++++++
 arch/arm/mach-omap2/board-sdp-flash.c         |   88 ++++++++-----------
 arch/arm/mach-omap2/board-zoom2.c             |   43 +++++++++
 arch/arm/mach-omap2/board-zoom3.c             |   43 +++++++++
 arch/arm/mach-omap2/include/mach/board-sdp.h  |    9 ++-
 arch/arm/mach-omap2/include/mach/board-zoom.h |    6 ++
 9 files changed, 311 insertions(+), 55 deletions(-)

