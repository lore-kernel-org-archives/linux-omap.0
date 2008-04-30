From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] ARM: OMAP: 2430SDP: Use defines in asm/sizes.h
Date: Wed, 30 Apr 2008 12:07:49 +0300
Message-ID: <1209546469-32686-1-git-send-email-felipe.balbi@nokia.com>
References: <91846c6802efa889898a7c21ab1e74e2@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:50775 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434AbYD3JJJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 05:09:09 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3U98Jev012695
	for <linux-omap@vger.kernel.org>; Wed, 30 Apr 2008 12:09:06 +0300
In-Reply-To: <91846c6802efa889898a7c21ab1e74e2@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Instead of manually calculating the partition sizes, it's
better to use defines already set in include/asm-arm/sizes.h

Compile test only.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-2430sdp-flash.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp-flash.c b/arch/arm/mach-omap2/board-2430sdp-flash.c
index 47aa8bf..3428483 100644
--- a/arch/arm/mach-omap2/board-2430sdp-flash.c
+++ b/arch/arm/mach-omap2/board-2430sdp-flash.c
@@ -38,25 +38,26 @@ static struct mtd_partition nand_partitions[] = {
 	{
 		.name		= "X-Loader",
 		.offset		= 0,
-		.size		= 4*(64*2048),  /* 0-3 blks reserved.
-						   Mandated by ROM code */
+		.size		= SZ_512K,	 /* 0-3 blks reserved.
+						  * Mandated by ROM code
+						  */
 		.mask_flags	= MTD_WRITEABLE	/* force read-only */
 	},
 	{
 		.name		= "U-Boot",
 		.offset		= MTDPART_OFS_APPEND,
-		.size		=  4*(64*2048),
+		.size		= SZ_512K,
 		.mask_flags	= MTD_WRITEABLE	/* force read-only */
 	},
 	{
 		.name		= "U-Boot Environment",
 		.offset		= MTDPART_OFS_APPEND,
-		.size		= 2*(64*2048),
+		.size		= SZ_256K,
 	},
 	{
 		.name		= "Kernel",
 		.offset		= MTDPART_OFS_APPEND,
-		.size		= 32*(64*2048),		/* 4*1M */
+		.size		= SZ_4M,		/* 4*1M */
 	},
 	{
 		.name		= "File System",
-- 
1.5.5.1.99.gf0ec4

