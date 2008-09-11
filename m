From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 15/29] OMAP3: PM: Move serial console check from omap3_can_sleep to idle loop
Date: Thu, 11 Sep 2008 15:33:59 +0300
Message-ID: <1221136453-16697-15-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-9-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-10-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-11-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-12-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-13-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-14-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18964 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882AbYIKMev (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:34:51 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BCYQwD018071
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 15:34:48 +0300
In-Reply-To: <1221136453-16697-14-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jouni Hogander <jouni.hogander@nokia.com>, Git administrator <gitowner@stego.research.nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

This fixes sluggish serial console.

Signed-off-by: Git administrator <gitowner@stego.research.nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
 arch/arm/mach-omap2/pm34xx.c      |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index a02da6d..b19d2eb 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -431,7 +431,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 
 	current_cx_state = *cx;
 
-	if (cx->type == OMAP3_STATE_C0) {
+	if (cx->type == OMAP3_STATE_C0 || !omap_serial_can_sleep()) {
 		/* Do nothing for C0, not even a wfi */
 		return 0;
 	}
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index da6eae1..42fa546 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -398,8 +398,6 @@ int omap3_can_sleep(void)
 		return 0;
 	if (atomic_read(&sleep_block) > 0)
 		return 0;
-	if (!omap_serial_can_sleep())
-		return 0;
 	return 1;
 }
 
@@ -478,6 +476,9 @@ static void omap3_pm_idle(void)
 	if (omap_irq_pending())
 		goto out;
 
+	if (!omap_serial_can_sleep())
+		goto out;
+
 	omap2_gpio_prepare_for_retention();
 
 	omap_serial_enable_clocks(0, 0);
-- 
1.6.0

