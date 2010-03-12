From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH 6/7] omap3: zoom 2/3: Change debugboard serial port id
Date: Fri, 12 Mar 2010 14:00:08 -0600
Message-ID: <1268424009-18974-7-git-send-email-saaguirre@ti.com>
References: <1268424009-18974-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54610 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758506Ab0CLT66 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 14:58:58 -0500
In-Reply-To: <1268424009-18974-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <me@felipebalbi.com>, Sergio Aguirre <saaguirre@ti.com>

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

