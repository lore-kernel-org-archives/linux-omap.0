From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH] ARM: OMAP2+: gpmc: fix: DT ONENAND child nodes not probed when MTD_ONENAND is built as module
Date: Tue, 28 Jan 2014 11:42:41 +0530
Message-ID: <1390889561-11410-2-git-send-email-pekon@ti.com>
References: <1390889561-11410-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49902 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbaA1GM7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jan 2014 01:12:59 -0500
In-Reply-To: <1390889561-11410-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Daniel Mack <zonque@gmail.com>

Fixes: commit 75d3625e0e86b2d8d77b4e9c6f685fd7ea0d5a96
       ARM: OMAP2+: gpmc: add DT bindings for OneNAND

OMAP SoC(s) depend on GPMC controller driver to parse GPMC DT child nodes and
register them platform_device for ONENAND driver to probe later. However this does
not happen if generic MTD_ONENAND framework is built as module (CONFIG_MTD_ONENAND=m).

Therefore, when MTD/ONENAND and MTD/ONENAND/OMAP2 modules are loaded, they are unable
to find any matching platform_device and remain un-binded. This causes on board
ONENAND flash to remain un-detected.

This patch causes GPMC controller to parse DT nodes when
CONFIG_MTD_ONENAND=y || CONFIG_MTD_ONENAND=m

CC: <stable@vger.kernel.org> # 3.9.x+
Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index c77a84b..ab43755 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1429,7 +1429,7 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
 }
 #endif
 
-#ifdef CONFIG_MTD_ONENAND
+#if IS_ENABLED(CONFIG_MTD_ONENAND)
 static int gpmc_probe_onenand_child(struct platform_device *pdev,
 				 struct device_node *child)
 {
-- 
1.8.1

