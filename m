From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 3/8] ARM: omap2: gpmc: Fix gpmc_cs_reserved() return value
Date: Tue, 12 Feb 2013 16:22:19 -0300
Message-ID: <1360696944-3371-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360696944-3371-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47114 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165Ab3BLTWe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 14:22:34 -0500
In-Reply-To: <1360696944-3371-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jon Hunter <jon-hunter@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Currently gpmc_cs_reserved() return value is somewhat inconsistent,
returning a negative value on an error condition, a positive value
if the chip select is reserved and zero if it's available.

Fix this by returning a boolean value as the function name suggests:
  * true if the chip select is reserved,
  * false if it's available

Suggested-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Reviewed-by: Jon Hunter <jon-hunter@ti.com>
---
Changelog from v1:
 * As suggested by Felipe Balbi, fix return code to a boolean

 arch/arm/mach-omap2/gpmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index bd3bc93..fa4764f 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -452,10 +452,10 @@ static int gpmc_cs_set_reserved(int cs, int reserved)
 	return 0;
 }
 
-static int gpmc_cs_reserved(int cs)
+static bool gpmc_cs_reserved(int cs)
 {
 	if (cs > GPMC_CS_NUM)
-		return -ENODEV;
+		return true;
 
 	return gpmc_cs_map & (1 << cs);
 }
-- 
1.7.8.6

