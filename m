From: "vimal singh" <vimalsingh@ti.com>
Subject: [PATCH-v3 0/3] OMAP: Adding flash support to SDP,
      ZOOM2 and LDP boards
Date: Thu, 10 Sep 2009 17:01:04 +0530 (IST)
Message-ID: <63751.192.168.10.88.1252582264.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38485 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbZIJLbH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Sep 2009 07:31:07 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8ABV5uk023780
	for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2009 06:31:10 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n8ABV34b012276
	for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2009 06:31:04 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch series adds flash support for NAND (in sdp, zoom2 and ldp),
OneNAND and NOR (in sdp)

Tested on Zoom2 by Vikram, On SDP by Vimal

  OMAP: Zoom2: Enable NAND and JFFS2 in defconfig
  OMAP2/3: Add support for flash on SDP boards
  OMAP3: Add support for NAND on ZOOM2/LDP boards

 arch/arm/omap_zoom2_defconfig |  241 +++++++++++++++++++++++++++++++++++++--------------
 arch/arm/mach-omap2/Makefile            |    4
 arm/mach-omap2/board-2430sdp.c          |    2
 arch/arm/mach-omap2/board-3430sdp.c     |    2
 arch/arm/mach-omap2/board-sdp-flash.c   |  327 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-sdp.h         |   15 +
 arch/arm/plat-omap/include/mach/gpmc.h  |    2
 arch/arm/mach-omap2/board-ldp.c              |    2
 arch/arm/mach-omap2/board-zoom-flash.c       |  196 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom2.c            |    2
 arch/arm/plat-omap/include/mach/board-zoom.h |   36 ++++++
 arch/arm/plat-omap/include/mach/nand.h       |    2
 12 files changed, 767 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
 create mode 100644 arch/arm/mach-omap2/board-sdp.h
 create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
 create mode 100644 arch/arm/plat-omap/include/mach/board-zoom.h


