From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2] OMAP2+: PM/serial: fix console semaphore acquire during suspend
Date: Tue,  7 Dec 2010 16:01:59 -0800
Message-ID: <1291766519-11424-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60353 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab0LHACE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 19:02:04 -0500
Received: by yxt3 with SMTP id 3so336619yxt.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 16:02:03 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

commit 0d8e2d0dad98a693bad88aea6876ac8b94ad95c6 (OMAP2+: PM/serial:
hold console semaphore while OMAP UARTs are disabled) added use of the
console semaphore to protect UARTs from being accessed after disabled
during idle, but this causes problems in suspend.

During suspend, the console semaphore is already held by the time we reach
the OMAP suspend path, so the try_acquire_console_sem() will always fail and
suspend will be aborted.

To fix, introduce a check so the console semaphore is only attempted
during idle, and not during suspend.  Also use the same check so that
the console semaphore is not prematurely released during resume.

Thanks to Paul Walmsley for suggesting adding the same check during
resume.

Cc: Paul Walmsley <paul@pwsan.com>
Tested-by: Jean Pihet <j-pihet@ti.com>
Tested-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Applies to Tony's omap-fixes branch.

 arch/arm/mach-omap2/pm34xx.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0ec8a04..648b8c5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -50,6 +50,19 @@
 #include "sdrc.h"
 #include "control.h"
 
+#ifdef CONFIG_SUSPEND
+static suspend_state_t suspend_state = PM_SUSPEND_ON;
+static inline bool is_suspending(void)
+{
+	return (suspend_state != PM_SUSPEND_ON);
+}
+#else
+static inline bool is_suspending(void)
+{
+	return false;
+}
+#endif
+
 /* Scratchpad offsets */
 #define OMAP343X_TABLE_ADDRESS_OFFSET	   0xc4
 #define OMAP343X_TABLE_VALUE_OFFSET	   0xc0
@@ -387,10 +400,11 @@ void omap_sram_idle(void)
 	}
 
 	/* Block console output in case it is on one of the OMAP UARTs */
-	if (per_next_state < PWRDM_POWER_ON ||
-	    core_next_state < PWRDM_POWER_ON)
-		if (try_acquire_console_sem())
-			goto console_still_active;
+	if (!is_suspending())
+		if (per_next_state < PWRDM_POWER_ON ||
+		    core_next_state < PWRDM_POWER_ON)
+			if (try_acquire_console_sem())
+				goto console_still_active;
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
@@ -470,7 +484,8 @@ void omap_sram_idle(void)
 		omap_uart_resume_idle(3);
 	}
 
-	release_console_sem();
+	if (!is_suspending())
+		release_console_sem();
 
 console_still_active:
 	/* Disable IO-PAD and IO-CHAIN wakeup */
@@ -514,8 +529,6 @@ out:
 }
 
 #ifdef CONFIG_SUSPEND
-static suspend_state_t suspend_state;
-
 static int omap3_pm_prepare(void)
 {
 	disable_hlt();
-- 
1.7.2.1

