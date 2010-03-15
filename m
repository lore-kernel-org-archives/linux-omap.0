From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH 6/7] omap3: zoom 2/3: Change debugboard serial port id
Date: Mon, 15 Mar 2010 18:04:11 -0500
Message-ID: <1268694252-21985-7-git-send-email-saaguirre@ti.com>
References: <1268694252-21985-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49261 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937075Ab0COXCd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Mar 2010 19:02:33 -0400
In-Reply-To: <1268694252-21985-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

This is now changed to PLAT8250_DEV_PLATFORM (= 0), because
it's the only port that's going to be initialized in
Zoom 2/3 boards.

So, it doesn't make sense to keep the hardcoded 3 value anymore.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/board-zoom-debugboard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index bb4018b..e15d2e8 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -96,7 +96,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 
 static struct platform_device zoom_debugboard_serial_device = {
 	.name			= "serial8250",
-	.id			= 3,
+	.id			= PLAT8250_DEV_PLATFORM,
 	.dev			= {
 		.platform_data	= serial_platform_data,
 	},
-- 
1.6.3.3

