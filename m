From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 17/29] OMAP3: PM: Remove unneeded code from traditional pm_idle loop
Date: Thu, 11 Sep 2008 15:34:01 +0300
Message-ID: <1221136453-16697-17-git-send-email-khilman@deeprootsystems.com>
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
 <1221136453-16697-15-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-16-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43086 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755881AbYIKMeq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:34:46 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BCXxjP022459
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 07:34:44 -0500
In-Reply-To: <1221136453-16697-16-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jouni Hogander <jouni.hogander@nokia.com>, Git administrator <gitowner@stego.research.nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

Remove code from traditional pm_idle loop. Removed code is in
omap_sram_idle which is shared between cpuidle and pm_idle.

Signed-off-by: Git administrator <gitowner@stego.research.nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 73f32a0..ae324b4 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -479,21 +479,7 @@ static void omap3_pm_idle(void)
 	if (!omap_serial_can_sleep())
 		goto out;
 
-	omap2_gpio_prepare_for_retention();
-
-	omap_serial_enable_clocks(0, 0);
-	omap_serial_enable_clocks(0, 1);
-	omap_serial_enable_clocks(0, 2);
-	per_gpio_clk_disable();
-
 	omap_sram_idle();
-
-	omap_serial_enable_clocks(1, 0);
-	omap_serial_enable_clocks(1, 1);
-	omap_serial_enable_clocks(1, 2);
-	per_gpio_clk_enable();
-
-	omap2_gpio_resume_after_retention();
 out:
 	local_fiq_enable();
 	local_irq_enable();
-- 
1.6.0

