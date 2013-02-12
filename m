From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 2/8] ARM: omap2: gpmc: Remove unused gpmc_round_ns_to_ticks() function
Date: Tue, 12 Feb 2013 16:22:18 -0300
Message-ID: <1360696944-3371-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360696944-3371-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47109 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165Ab3BLTW2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 14:22:28 -0500
In-Reply-To: <1360696944-3371-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jon Hunter <jon-hunter@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This function is not used anywhere, so it's safe to remove it.
This means less code to maintain.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Reviewed-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index ffe3e1e..bd3bc93 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -230,13 +230,6 @@ unsigned int gpmc_ticks_to_ns(unsigned int ticks)
 	return ticks * gpmc_get_fclk_period() / 1000;
 }
 
-static unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns)
-{
-	unsigned long ticks = gpmc_ns_to_ticks(time_ns);
-
-	return ticks * gpmc_get_fclk_period() / 1000;
-}
-
 static unsigned int gpmc_ticks_to_ps(unsigned int ticks)
 {
 	return ticks * gpmc_get_fclk_period();
-- 
1.7.8.6

