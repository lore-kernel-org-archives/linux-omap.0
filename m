From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH] ARM: OMAP2+: gpmc: fix: DT NAND child nodes not probed when MTD_NAND is built as module
Date: Tue, 28 Jan 2014 11:42:40 +0530
Message-ID: <1390889561-11410-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56278 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbaA1GMs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jan 2014 01:12:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Daniel Mack <zonque@gmail.com>

Fixes: commit bc6b1e7b86f5d8e4a6fc1c0189e64bba4077efe0
       ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND

OMAP SoC(s) depend on GPMC controller driver to parse GPMC DT child nodes and
register them platform_device for NAND driver to probe later. However this does
not happen if generic MTD_NAND framework is built as module (CONFIG_MTD_NAND=m).

Therefore, when MTD/NAND and MTD/NAND/OMAP2 modules are loaded, they are unable
to find any matching platform_device and remain un-binded. This causes on board
NAND flash to remain un-detected.

This patch causes GPMC controller to parse DT nodes when
CONFIG_MTD_NAND=y || CONFIG_MTD_NAND=m

CC: <stable@vger.kernel.org> # 3.9.x+
Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index d24926e..c77a84b 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1339,7 +1339,7 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 		of_property_read_bool(np, "gpmc,time-para-granularity");
 }
 
-#ifdef CONFIG_MTD_NAND
+#if IS_ENABLED(CONFIG_MTD_NAND)
 
 static const char * const nand_xfer_types[] = {
 	[NAND_OMAP_PREFETCH_POLLED]		= "prefetch-polled",
-- 
1.8.1

