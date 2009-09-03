From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH-v2 0/3] OMAP: Adding flash support to SDP, ZOOM2 and LDP boards
Date: Thu,  3 Sep 2009 14:25:50 -0500
Message-ID: <1252005950-17610-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35220 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753888AbZICTbo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Sep 2009 15:31:44 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n83JVf2w016157
	for <linux-omap@vger.kernel.org>; Thu, 3 Sep 2009 14:31:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

This patch series adds flash support for NAND (in sdp, zoom2 and ldp),
OneNAND and NOR (in sdp)

Tested on Zoom2 by Vikram, On SDP by Vimal

Vikram Pandita (1):
  OMAP: Zoom2: Enable NAND in defconfig

Vimal Singh (2):
  OMAP2/3: Add support for flash on SDP boards
  OMAP3: Add support for NAND on ZOOM2/LDP boards

 arch/arm/configs/omap_zoom2_defconfig        |  224 +++++++++++++-----
 arch/arm/mach-omap2/Makefile                 |    4 +
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +
 arch/arm/mach-omap2/board-3430sdp.c          |    2 +
 arch/arm/mach-omap2/board-ldp.c              |    2 +
 arch/arm/mach-omap2/board-sdp-flash.c        |  326 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-sdp.h              |   15 ++
 arch/arm/mach-omap2/board-zoom-flash.c       |  196 ++++++++++++++++
 arch/arm/mach-omap2/board-zoom2.c            |    2 +
 arch/arm/plat-omap/include/mach/board-zoom.h |   36 +++
 arch/arm/plat-omap/include/mach/gpmc.h       |    2 +
 arch/arm/plat-omap/include/mach/nand.h       |    1 +
 12 files changed, 748 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
 create mode 100644 arch/arm/mach-omap2/board-sdp.h
 create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
 create mode 100644 arch/arm/plat-omap/include/mach/board-zoom.h

