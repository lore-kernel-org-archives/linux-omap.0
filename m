From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 0/3] Introduce Zoom3 board
Date: Fri, 23 Oct 2009 14:23:23 -0500
Message-ID: <1256325806-14400-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44249 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbZJWTZQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Oct 2009 15:25:16 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9NJPKAf027060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 14:25:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Zoom3 is the next versoin of Zoom2 board.
There has been a silicon update from zoom2 to zoom3.

Zoom2 has OMAP34xx
Zoom3 has OMAP3630

Zoom3 = OMAP3630 SOM board + same zoom2 main board + same debugboard

We want to reuse the zoom2 files as much for zoom3, as at board level, 
there is no change at all.

Vikram Pandita (3):
  omap: zoom: reuse zoom2 board file for zoom3
  omap: zoom2: update makefile for boardfile name change
  omap: zoom3: add zoom3 board support

 arch/arm/mach-omap2/Kconfig             |    4 +
 arch/arm/mach-omap2/Makefile            |    5 +-
 arch/arm/mach-omap2/board-zoom2-zoom3.c |  296 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom2.c       |  292 ------------------------------
 4 files changed, 304 insertions(+), 293 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-zoom2-zoom3.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom2.c

