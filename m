From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] ARM: OMAP: 2430SDP: Use defines in asm/sizes.h
Date: Wed, 30 Apr 2008 11:43:50 +0300
Message-ID: <1209545030-31637-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23398 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059AbYD3IpS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 04:45:18 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3U8jDAY029044
	for <linux-omap@vger.kernel.org>; Wed, 30 Apr 2008 11:45:15 +0300
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
index 47aa8bf..f645051 100644
--- a/arch/arm/mach-omap2/board-2430sdp-flash.c
+++ b/arch/arm/mach-omap2/board-2430sdp-flash.c
@@ -38,25 +38,26 @@ static struct mtd_partition nand_partitions[] = {
 	{
 		.name		= "X-Loader",
 		.offset		= 0,
-		.size		= 4*(64*2048),  /* 0-3 blks reserved.
-						   Mandated by ROM code */
+		.size		= SZ_128K,	 /* 0-3 blks reserved.
+						  * Mandated by ROM code
+						  */
 		.mask_flags	= MTD_WRITEABLE	/* force read-only */
 	},
 	{
 		.name		= "U-Boot",
 		.offset		= MTDPART_OFS_APPEND,
-		.size		=  4*(64*2048),
+		.size		= SZ_128K,
 		.mask_flags	= MTD_WRITEABLE	/* force read-only */
 	},
 	{
 		.name		= "U-Boot Environment",
 		.offset		= MTDPART_OFS_APPEND,
-		.size		= 2*(64*2048),
+		.size		= SZ_128K,
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

