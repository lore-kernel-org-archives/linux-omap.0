From: Steve Sakoman <sakoman@gmail.com>
Subject: [PATCH] ARM: OMAP: Beagle: make u-boot nand partition writable
Date: Thu, 8 Apr 2010 07:22:10 -0700
Message-ID: <t2m5e088bd91004080722k3b5dfb60i26e9925d16cadba8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:31700 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab0DHOWL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 10:22:11 -0400
Received: by qw-out-2122.google.com with SMTP id 8so807692qwh.37
        for <linux-omap@vger.kernel.org>; Thu, 08 Apr 2010 07:22:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Steve Sakoman <steve@sakoman.com>

Many Beagle users prefer to update their NAND using linux tools rather
than u-boot.  This patch makes the u-boot partition writable so that
updates are possible.

Signed-off-by: Steve Sakoman <steve@sakoman.com>
------

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
b/arch/arm/mach-omap2/board-omap3beagle.c
index 0aaab60..4e77097 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -108,7 +108,6 @@ static struct mtd_partition
omap3beagle_nand_partitions[] = {
 		.name		= "U-Boot",
 		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
 		.size		= 15 * NAND_BLOCK_SIZE,
-		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
 	},
 	{
 		.name		= "U-Boot Env",
