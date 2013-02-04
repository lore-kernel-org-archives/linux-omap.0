From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 7/7] ARM: OMAP4+: Fix sparse warning in system timers
Date: Mon, 4 Feb 2013 11:43:06 -0600
Message-ID: <1359999786-8740-8-git-send-email-jon-hunter@ti.com>
References: <1359999786-8740-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49525 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754619Ab3BDRnU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 12:43:20 -0500
In-Reply-To: <1359999786-8740-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Jon Hunter <jon-hunter@ti.com>

Commit 6bb27d7 (ARM: delete struct sys_timer) changed the function
created by the macro OMAP_SYS_32K_TIMER_INIT from static void to void.
For OMAP4+ devices this created the following sparse warning ...

arch/arm/mach-omap2/timer.c:585:1: warning: symbol
	'omap4_sync32k_timer_init' was not declared. Should it be static?

The function omap4_sync32k_timer_init() is not referenced outside of the
file timer.c and so make this function static.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index c5770ff..a5f88b2 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -587,8 +587,8 @@ OMAP_SYS_GP_TIMER_INIT(3, 2, "timer_sys_ck", NULL,
 #endif
 
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
-OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
-			2, "sys_clkin_ck", NULL);
+static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
+			       2, "sys_clkin_ck", NULL);
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
-- 
1.7.10.4

