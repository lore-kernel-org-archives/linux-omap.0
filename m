From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH] ARM: omap2: cm-t3730: convert boot_params to atag_offset
Date: Fri,  8 Jul 2011 01:10:11 +0300
Message-ID: <1310076611-10135-1-git-send-email-grinberg@compulab.co.il>
References: <201107072240.58987.arnd@arndb.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:56494
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751601Ab1GGWKU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 18:10:20 -0400
In-Reply-To: <201107072240.58987.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
Hi Arnd,
This one should apply cleanly on top of Nicolas' series
and does the missing change for cm-t3730.
If it somehow helps/saves you an effort, here it is.

 arch/arm/mach-omap2/board-cm-t35.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index fcd4032..e7d48e8 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -679,7 +679,7 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
 MACHINE_END
 
 MACHINE_START(CM_T3730, "Compulab CM-T3730")
-	.boot_params    = 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve        = omap_reserve,
 	.map_io         = omap3_map_io,
 	.init_early     = cm_t35_init_early,
-- 
1.7.3.4

