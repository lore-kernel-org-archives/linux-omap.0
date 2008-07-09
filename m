From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [RFC] OMAP3: CPUIDLE & PM: Fix slow serial-console
Date: Wed,  9 Jul 2008 11:30:08 +0300
Message-ID: <1215592208-30857-1-git-send-email-jouni.hogander@nokia.com>
References: <1215584973-14982-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38632 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbYGIIad (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2008 04:30:33 -0400
In-Reply-To: <1215584973-14982-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, rnayak@ti.com

This patch fixes slowness on serial console. This patch superseeds
"OMAP3: CPUIDLE & PM: check_bm fix".
---
 arch/arm/mach-omap2/cpuidle34xx.c |    3 ++-
 arch/arm/mach-omap2/pm34xx.c      |    2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index c14152f..b227d9b 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -30,6 +30,7 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/gpmc.h>
 #include <asm/arch/control.h>
+#include <asm/arch/common.h>
 #include <linux/sched.h>
 #include "cpuidle34xx.h"
 #include "cm.h"
@@ -430,7 +431,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 
 	current_cx_state = *cx;
 
-	if (cx->type == OMAP3_STATE_C0) {
+	if (cx->type == OMAP3_STATE_C0 || !omap_serial_can_sleep()) {
 		/* Do nothing for C0, not even a wfi */
 		return 0;
 	}
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9f73e5c..9bb0fba 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -385,8 +385,6 @@ int omap3_can_sleep(void)
 		return 0;
 	if (atomic_read(&sleep_block) > 0)
 		return 0;
-	if (!omap_serial_can_sleep())
-		return 0;
 	return 1;
 }
 
-- 
1.5.5

