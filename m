From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 5/7] arm: mach-omap1: board-h3: make nand_platdata static
Date: Tue, 18 Jan 2011 09:52:43 +0200
Message-ID: <1295337165-22934-6-git-send-email-aaro.koskinen@iki.fi>
References: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:43755 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406Ab1ARHwg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 02:52:36 -0500
In-Reply-To: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Eliminates the following sparse warning:

	arch/arm/mach-omap1/board-h3.c:207:27: warning: symbol 'nand_platdata' was not declared. Should it be static?

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-h3.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index dbc8b8d..ac48677 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -204,7 +204,7 @@ static int nand_dev_ready(struct mtd_info *mtd)
 
 static const char *part_probes[] = { "cmdlinepart", NULL };
 
-struct platform_nand_data nand_platdata = {
+static struct platform_nand_data nand_platdata = {
 	.chip	= {
 		.nr_chips		= 1,
 		.chip_offset		= 0,
-- 
1.5.6.5

