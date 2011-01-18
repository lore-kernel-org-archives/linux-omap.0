From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 6/7] arm: plat-omap: system.h: move voiceblue definitions into the board header
Date: Tue, 18 Jan 2011 09:52:44 +0200
Message-ID: <1295337165-22934-7-git-send-email-aaro.koskinen@iki.fi>
References: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:43749 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab1ARHwg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 02:52:36 -0500
In-Reply-To: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Move voiceblue definitions into the board-specific header.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/plat-omap/include/plat/board-voiceblue.h |    6 ++++++
 arch/arm/plat-omap/include/plat/system.h          |    7 +------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/board-voiceblue.h b/arch/arm/plat-omap/include/plat/board-voiceblue.h
index 27916b2..431d70e 100644
--- a/arch/arm/plat-omap/include/plat/board-voiceblue.h
+++ b/arch/arm/plat-omap/include/plat/board-voiceblue.h
@@ -15,5 +15,11 @@ extern void voiceblue_wdt_enable(void);
 extern void voiceblue_wdt_disable(void);
 extern void voiceblue_wdt_ping(void);
 
+#ifndef CONFIG_MACH_VOICEBLUE
+#define voiceblue_reset()		do {} while (0)
+#else
+extern void voiceblue_reset(void);
+#endif
+
 #endif /*  __ASM_ARCH_VOICEBLUE_H */
 
diff --git a/arch/arm/plat-omap/include/plat/system.h b/arch/arm/plat-omap/include/plat/system.h
index d0a119f..24bb5ae 100644
--- a/arch/arm/plat-omap/include/plat/system.h
+++ b/arch/arm/plat-omap/include/plat/system.h
@@ -9,14 +9,9 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 
+#include <plat/board-voiceblue.h>
 #include <plat/prcm.h>
 
-#ifndef CONFIG_MACH_VOICEBLUE
-#define voiceblue_reset()		do {} while (0)
-#else
-extern void voiceblue_reset(void);
-#endif
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
-- 
1.5.6.5

