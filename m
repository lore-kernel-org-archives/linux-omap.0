From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v3 0/8] nand support on omap3 boards
Date: Wed, 16 Jun 2010 17:09:52 +0530
Message-ID: <1276688400-4812-1-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48754 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab0FPLkF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 07:40:05 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5GBe2Hn032116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 06:40:04 -0500
In-Reply-To: <Sukumar Ghorai <s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>

   The following set of patches applies on top of for-next branch.
   And these are the patches required to enable nand (nor and onenand for sdp
   only) for different platform.
   
   v3: patch rebase on latest nand patch and depend on -
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30305.html
   
   v2: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26479.html
	rework to use full nand in partition table of ZOOM2/3;
	ZOOM1(LDP)support added.
		
   v1: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg22205.html

Sukumar Ghorai (8):
	omap3 flash: rename board-sdp-flash.c to be use by other boards
	omap3: add support for NAND on zoom2 board
	omap3: add support for NAND on zoom3 board
	omap-3630-sdp : Add support for Flash
	omap-3630-sdp: enable Flash device support
	omap3: add support for NAND on LDP board
	zoom2: enable NAND support
	zoom3: enable NAND support

 arch/arm/configs/omap_3630sdp_defconfig      |   31 +++-
 arch/arm/configs/omap_zoom2_defconfig        |   24 +++-
 arch/arm/configs/omap_zoom3_defconfig        |   24 +++-
 arch/arm/mach-omap2/Makefile                 |    6 +-
 arch/arm/mach-omap2/board-3430sdp.c          |   16 ++-
 arch/arm/mach-omap2/board-3630sdp.c          |  120 ++++++++++++
 arch/arm/mach-omap2/board-ldp.c              |   35 ++++
 arch/arm/mach-omap2/board-flash.c            |  253 ++++++++++++++++++++++
 arch/arm/mach-omap2/board-sdp-flash.c        |  267 --------------------------
 arch/arm/mach-omap2/board-zoom2.c            |   49 +++++
 arch/arm/mach-omap2/board-zoom3.c            |   48 +++++
 arch/arm/mach-omap2/include/mach/board-flash.h | 28 +++
 arch/arm/mach-omap2/include/mach/board-sdp.h |   21 --
 11 files changed, 628 insertions(+), 294 deletions(-)


