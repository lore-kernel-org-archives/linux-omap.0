From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part2 v1][PATCH 4/4] omap3: zoom 2/3: Change debugboard serial port id
Date: Mon,  1 Mar 2010 12:55:54 -0600
Message-ID: <1267469754-10638-5-git-send-email-saaguirre@ti.com>
References: <1267469754-10638-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52910 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378Ab0CASzj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Mar 2010 13:55:39 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o21Itd7I003486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 1 Mar 2010 12:55:39 -0600
In-Reply-To: <1267469754-10638-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergio Aguirre <saaguirre@ti.com>

This is now changed to PLAT8250_DEV_PLATFORM (= 0), because
it is the only port that's going to be initted in Zoom 2/3 boards.

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

