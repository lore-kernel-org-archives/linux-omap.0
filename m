From: Mike Chan <mike@android.com>
Subject: [PATCH 2/2] omap: pm34xx: Remove PER wakeup dependency on CORE.
Date: Mon,  3 May 2010 14:26:58 -0700
Message-ID: <1272922018-11388-2-git-send-email-mike@android.com>
References: <1272922018-11388-1-git-send-email-mike@android.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:36524 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526Ab0ECV1I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 17:27:08 -0400
In-Reply-To: <1272922018-11388-1-git-send-email-mike@android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com, Mike Chan <mike@android.com>

We can remove this wakeup dependency since now, when
GPIO2-6 are enabled for IO-pad wakeup, PER domain is gauranteed
to be awake or be woken up to service.

The previous dependency did not handle all corner cases. Since there
was no sleep dependency between CORE and PER domains, if PER enters
RET and CORE is ON, PER will not be active for GPIO handling.

Signed-off-by: Mike Chan <mike@android.com>
---
 arch/arm/mach-omap2/pm34xx.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2b2eaaa..acf180b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1086,14 +1086,6 @@ static int __init omap3_pm_init(void)
 	omap3_idle_init();
 
 	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
-	/*
-	 * REVISIT: This wkdep is only necessary when GPIO2-6 are enabled for
-	 * IO-pad wakeup.  Otherwise it will unnecessarily waste power
-	 * waking up PER with every CORE wakeup - see
-	 * http://marc.info/?l=linux-omap&m=121852150710062&w=2
-	*/
-	clkdm_add_wkdep(per_clkdm, core_clkdm);
-
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		omap3_secure_ram_storage =
 			kmalloc(0x803F, GFP_KERNEL);
-- 
1.7.0.1

