From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP2+: PM: Warn users of sleep_while_idle if !CONFIG_CPU_IDLE
Date: Wed, 16 Feb 2011 17:34:20 +0530
Message-ID: <1297857860-3713-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51799 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758950Ab1BPME1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 07:04:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

This should help users who do a
'echo 1 > /debug/pm_debug/sleep_while_idle' with a
config which has !CONFIG_CPU_IDLE and wonder
why OMAP is'nt sleeping in idle.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 125f565..1e722a0 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -569,6 +569,10 @@ static int option_get(void *data, u64 *val)
 
 	*val = *option;
 
+#ifndef CONFIG_CPU_IDLE
+	if (option == &sleep_while_idle)
+		pr_warn("CONFIG_CPU_IDLE is not enabled\n");
+#endif
 	return 0;
 }
 
@@ -581,6 +585,11 @@ static int option_set(void *data, u64 val)
 
 	*option = val;
 
+#ifndef CONFIG_CPU_IDLE
+	if (option == &sleep_while_idle)
+		pr_warn("CONFIG_CPU_IDLE is not enabled\n");
+#endif
+
 	if (option == &enable_off_mode) {
 		if (val)
 			omap_pm_enable_off_mode();
-- 
1.7.0.4

