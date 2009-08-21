From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 4/5] OMAP: Zoom2: Fix serial break
Date: Fri, 21 Aug 2009 13:11:06 -0500
Message-ID: <1250878266-10632-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43963 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754405AbZHUSLb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Aug 2009 14:11:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: Vikram Pandita <vikram.pandita@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Fix the break in Zoom2 Quad uart debug port support.

Patch by Kevin Hilman fd455ea899b5a14 caused a break as it introuduced
per port PLATFORM id and Zoom2 was not tested with this change.

For Zoom2 serial port, add platform id as 4

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-zoom-debugboard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index f8b0726..4dd714d 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -97,7 +97,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 
 static struct platform_device zoom2_debugboard_serial_device = {
 	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM1,
+	.id			= PLAT8250_DEV_FOURPORT,
 	.dev			= {
 		.platform_data	= serial_platform_data,
 	},
-- 
1.6.3.3.334.g916e1

