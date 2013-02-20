From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/9] ARM: OMAP1: PM: Remove bogus fiq_[enable/disable] tuple
Date: Wed, 20 Feb 2013 20:48:40 +0530
Message-ID: <1361373527-21695-3-git-send-email-santosh.shilimkar@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43744 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933491Ab3BTPRr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:17:47 -0500
In-Reply-To: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP platform, FIQ is reserved for secure environment only. If at all
the FIQ needs to be disabled, it involves going through security
API call. Hence the local_fiq_[enable/disable]() in the OMAP code is bogus.

So just get rid of it.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap1/pm.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 7a7690a..25aa9c4 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -111,8 +111,6 @@ void omap1_pm_idle(void)
 	__u32 use_idlect1 = arm_idlect1_mask;
 	int do_sleep = 0;
 
-	local_fiq_disable();
-
 #if defined(CONFIG_OMAP_MPU_TIMER) && !defined(CONFIG_OMAP_DM_TIMER)
 #warning Enable 32kHz OS timer in order to allow sleep states in idle
 	use_idlect1 = use_idlect1 & ~(1 << 9);
@@ -158,8 +156,6 @@ void omap1_pm_idle(void)
 	}
 	omap_sram_suspend(omap_readl(ARM_IDLECT1),
 			  omap_readl(ARM_IDLECT2));
-
-	local_fiq_enable();
 }
 
 /*
@@ -235,7 +231,6 @@ void omap1_pm_suspend(void)
 	 */
 
 	local_irq_disable();
-	local_fiq_disable();
 
 	/*
 	 * Step 2: save registers
@@ -414,7 +409,6 @@ void omap1_pm_suspend(void)
 	 */
 
 	local_irq_enable();
-	local_fiq_enable();
 
 	omap_serial_wake_trigger(0);
 
-- 
1.7.9.5

