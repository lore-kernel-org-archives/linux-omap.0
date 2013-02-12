From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 8/8] ARM: omap2: gpmc: Remove redundant chip select out of range check
Date: Tue, 12 Feb 2013 16:22:24 -0300
Message-ID: <1360696944-3371-9-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360696944-3371-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47141 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165Ab3BLTWw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 14:22:52 -0500
In-Reply-To: <1360696944-3371-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jon Hunter <jon-hunter@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This check is done before the call to gpmc_cs_reserved() and
gpmc_cs_set_reserved() and it's redundant to do it again in each
function. This simplifies the code a bit.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Reviewed-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index fa4764f..0201ea9 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -441,22 +441,14 @@ static int gpmc_cs_mem_enabled(int cs)
 	return l & GPMC_CONFIG7_CSVALID;
 }
 
-static int gpmc_cs_set_reserved(int cs, int reserved)
+static void gpmc_cs_set_reserved(int cs, int reserved)
 {
-	if (cs > GPMC_CS_NUM)
-		return -ENODEV;
-
 	gpmc_cs_map &= ~(1 << cs);
 	gpmc_cs_map |= (reserved ? 1 : 0) << cs;
-
-	return 0;
 }
 
 static bool gpmc_cs_reserved(int cs)
 {
-	if (cs > GPMC_CS_NUM)
-		return true;
-
 	return gpmc_cs_map & (1 << cs);
 }
 
-- 
1.7.8.6

