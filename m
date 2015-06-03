From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/12] ARM: OMAP2+: Fix dm814x DT_MACHINE_START
Date: Wed,  3 Jun 2015 09:23:10 -0700
Message-ID: <1433348601-8966-2-git-send-email-tony@atomide.com>
References: <1433348601-8966-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:12998 "HELO
	pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754162AbbFCQXq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2015 12:23:46 -0400
In-Reply-To: <1433348601-8966-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Matthijs van Duin <matthijsvanduin@gmail.com>

Fix dm814x DT_MACHINE_START.

Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 34ff14b..a233860 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -169,7 +169,7 @@ static const char *const ti814x_boards_compat[] __initconst = {
 	NULL,
 };
 
-DT_MACHINE_START(TI81XX_DT, "Generic ti814x (Flattened Device Tree)")
+DT_MACHINE_START(TI814X_DT, "Generic ti814x (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= ti81xx_map_io,
 	.init_early	= ti814x_init_early,
-- 
2.1.4

