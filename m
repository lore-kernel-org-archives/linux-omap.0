From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 2/3] omap: zoom2: update makefile for boardfile name change
Date: Fri, 23 Oct 2009 14:23:25 -0500
Message-ID: <1256325806-14400-3-git-send-email-vikram.pandita@ti.com>
References: <1256325806-14400-1-git-send-email-vikram.pandita@ti.com>
 <1256325806-14400-2-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46719 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947AbZJWTZQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Oct 2009 15:25:16 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9NJPLHE032261
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 14:25:21 -0500
In-Reply-To: <1256325806-14400-2-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Accomodate the board file change in Kconfig
arch/arm/mach-omap2/board-zoom2.c -> arch/arm/mach-omap2/board-zoom2-zoom3.c

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 03cb4fc..68f7419 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -71,7 +71,7 @@ obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-peripherals.o \
 					   mmc-twl4030.o
-obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
+obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2-zoom3.o \
 					   mmc-twl4030.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
-- 
1.6.5.rc1.19.g8426

