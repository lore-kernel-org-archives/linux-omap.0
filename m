From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v2 0/2] Cleanup DEBUG_LL infrastructure
Date: Fri, 11 Sep 2009 12:57:26 -0500
Message-ID: <1252691846-9739-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41006 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754622AbZIKSCi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Sep 2009 14:02:38 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8BI2fp9029138
	for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2009 13:02:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Patch1: add DEBUG_LL support for Zoom2 board that has external UART
Patch2: clean up the DEBUG_LL infrastructure for run time detection

Patchs are also hosted at:
git://dev.omapzoom.org/pub/scm/vikram/omap3.git runtime-debug-ll

Tested on OMAP3: SDP3430/Zoom2/Zoom1/Beagleboard
Will appreciate if some can verify for OMAP2 and OMAP1 boards

Vikram Pandita (2):
  OMAP: Zoom2: Add DEBUG_LL interface using Quart
  OMAP1/2/3/4: DEBUG_LL run time detection

 arch/arm/boot/compressed/head.S               |   17 ++++
 arch/arm/boot/compressed/misc.c               |  108 ++++++++++++++++++++++++-
 arch/arm/mach-omap2/board-zoom-debugboard.c   |    5 +-
 arch/arm/mach-omap2/board-zoom2.c             |   19 ++++-
 arch/arm/plat-omap/Kconfig                    |   16 ----
 arch/arm/plat-omap/include/mach/debug-macro.S |   74 +++++++++--------
 arch/arm/plat-omap/include/mach/io.h          |    6 ++
 arch/arm/plat-omap/include/mach/uncompress.h  |   22 +++---
 8 files changed, 202 insertions(+), 65 deletions(-)

