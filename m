From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/7] arm: mach-omap1: board-h2: make h2_nand_platdata static
Date: Tue, 18 Jan 2011 09:52:40 +0200
Message-ID: <1295337165-22934-3-git-send-email-aaro.koskinen@iki.fi>
References: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:44466 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab1ARHwf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 02:52:35 -0500
In-Reply-To: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Eliminates the following sparse warning:

	arch/arm/mach-omap1/board-h2.c:205:27: warning: symbol 'h2_nand_platdata' was not declared. Should it be static?

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-h2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 28b84aa..ba3bd09 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -202,7 +202,7 @@ static int h2_nand_dev_ready(struct mtd_info *mtd)
 
 static const char *h2_part_probes[] = { "cmdlinepart", NULL };
 
-struct platform_nand_data h2_nand_platdata = {
+static struct platform_nand_data h2_nand_platdata = {
 	.chip	= {
 		.nr_chips		= 1,
 		.chip_offset		= 0,
-- 
1.5.6.5

