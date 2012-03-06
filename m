From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2: Fix section warning for n8x0 when
 CONFIG_MMC_OMAP is not set
Date: Tue, 6 Mar 2012 11:10:59 -0800
Message-ID: <20120306191059.GT12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53769 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965160Ab2CFTLC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 14:11:02 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Otherwise we get:

arch/arm/mach-omap2/board-n8x0.c:39:12: warning:
'slot1_cover_open' defined but not used [-Wunused-variable]
arch/arm/mach-omap2/board-n8x0.c:40:12: warning:
'slot2_cover_open' defined but not used [-Wunused-variable]
arch/arm/mach-omap2/board-n8x0.c:41:23: warning:
'mmc_device' defined but not used [-Wunused-variable]

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -36,10 +36,6 @@
 
 #include "mux.h"
 
-static int slot1_cover_open;
-static int slot2_cover_open;
-static struct device *mmc_device;
-
 #define TUSB6010_ASYNC_CS	1
 #define TUSB6010_SYNC_CS	4
 #define TUSB6010_GPIO_INT	58
@@ -211,6 +207,10 @@ static struct omap_onenand_platform_data board_onenand_data[] = {
 #define N810_EMMC_VSD_GPIO	23
 #define N810_EMMC_VIO_GPIO	9
 
+static int slot1_cover_open;
+static int slot2_cover_open;
+static struct device *mmc_device;
+
 static int n8x0_mmc_switch_slot(struct device *dev, int slot)
 {
 #ifdef CONFIG_MMC_DEBUG
