From: Charles Manning <cdhmanning@gmail.com>
Subject: [PATCH 2/2] omap2 nand: Align subpage reads.
Date: Thu,  6 Jan 2011 14:39:02 +1300
Message-ID: <1294277942-1252-3-git-send-email-cdhmanning@gmail.com>
References: <1294277942-1252-1-git-send-email-cdhmanning@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:47647 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab1AFBjg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 20:39:36 -0500
Received: by pxi15 with SMTP id 15so2843343pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 17:39:35 -0800 (PST)
In-Reply-To: <1294277942-1252-1-git-send-email-cdhmanning@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Charles Manning <cdhmanning@gmail.com>

Set align_subpage to align buffer to u32 to use the prefetch engine.

Signed-off-by: Charles Manning <cdhmanning@gmail.com>
---
 drivers/mtd/nand/omap2.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index cd41c58..3630971 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -886,6 +886,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 #else
 	info->nand.ecc.mode = NAND_ECC_SOFT;
 #endif
+	info->nand.align_subpage = nand_align_subpage32;
 
 	/* DIP switches on some boards change between 8 and 16 bit
 	 * bus widths for flash.  Try the other width if the first try fails.
-- 
1.7.1.5.g49342

