From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 6/6] OMAP3: PM: Remove PER wakeup dependency on CORE.
Date: Tue, 11 May 2010 16:47:11 -0700
Message-ID: <1273621631-9148-7-git-send-email-khilman@deeprootsystems.com>
References: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38417 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991Ab0EKXre (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:47:34 -0400
Received: by mail-vw0-f46.google.com with SMTP id 17so1655954vws.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 16:47:34 -0700 (PDT)
In-Reply-To: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Mike Chan <mike@android.com>

From: Mike Chan <mike@android.com>

We can remove this wakeup dependency since now, when
GPIO2-6 are enabled for IO-pad wakeup, PER domain is gauranteed
to be awake or be woken up to service.

The previous dependency did not handle all corner cases. Since there
was no sleep dependency between CORE and PER domains, if PER enters
RET and CORE is ON, PER will not be active for GPIO handling.

Signed-off-by: Mike Chan <mike@android.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index eec0916..1d71698 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1096,14 +1096,6 @@ static int __init omap3_pm_init(void)
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
1.7.0.2

