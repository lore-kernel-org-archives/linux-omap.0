From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH 1/7] omap3630: nand: fix device size to work in polled mode
Date: Fri, 26 Nov 2010 21:04:31 +0530
Message-ID: <1290785677-16005-2-git-send-email-s-ghorai@ti.com>
References: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46019 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946Ab0KZPeq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Nov 2010 10:34:46 -0500
In-Reply-To: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>

zoom3 and 3630-sdp having the x16 nand device.
This patch configure gpmc as x16 and select the currect function in driver
for polled mode (without prefetch enable) transfer.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/board-flash.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index fd38c05..001c605 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -145,6 +145,9 @@ __init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs)
 	board_nand_data.parts		= nand_parts;
 	board_nand_data.nr_parts		= nr_parts;
 
+	if (cpu_is_omap3630())
+		board_nand_data.devsize = 1;
+
 	gpmc_nand_init(&board_nand_data);
 }
 #else
-- 
1.7.0.4

