From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Fix compile if MTD_NAND_OMAP2 is not selected
Date: Fri, 25 Feb 2011 10:17:57 -0800
Message-ID: <20110225181757.GB20560@atomide.com>
References: <1298463072-19891-1-git-send-email-premi@ti.com>
 <20110225181640.GA20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63194 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790Ab1BYSR7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 13:17:59 -0500
Content-Disposition: inline
In-Reply-To: <20110225181640.GA20560@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Fix compile if MTD_NAND_OMAP2 is not selected

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -154,7 +154,7 @@ __init board_nand_init(struct mtd_partition *nand_parts,
 }
 #else
 void
-__init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs)
+__init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs, int nand_type)
 {
 }
 #endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
