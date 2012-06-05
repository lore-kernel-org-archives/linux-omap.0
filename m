From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V4 02/12] ARM: OMAP2+: Remove unused max number of timers definition
Date: Tue, 5 Jun 2012 12:34:50 -0500
Message-ID: <1338917700-29174-3-git-send-email-jon-hunter@ti.com>
References: <1338917700-29174-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40040 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755053Ab2FERfF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Jun 2012 13:35:05 -0400
In-Reply-To: <1338917700-29174-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Jon Hunter <jon-hunter@ti.com>

The OMAP2+ timer code has a definition for the maximum number of timers that
OMAP2+ devices have. This defintion is not used anywhere in the code and
appears to be left over. Furthermore the definition is not accurate for OMAP4
devices that only have 11 timers available because the 12th timer is reserved
as a secure timer and for OMAP3 devices the 12th timer is not available on
secure devices. Therefore, remove this definition.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index ea6a0eb..8350352 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -69,9 +69,6 @@
 #define OMAP3_SECURE_TIMER	1
 #endif
 
-/* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
-#define MAX_GPTIMER_ID		12
-
 static u32 sys_timer_reserved;
 
 /* Clockevent code */
-- 
1.7.9.5

