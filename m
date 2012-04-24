From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFT 3/3] ARM: OMAP3: PM: cleanup cam_pwrdm leftovers
Date: Tue, 24 Apr 2012 07:23:40 -0700
Message-ID: <1335277420-29124-4-git-send-email-khilman@ti.com>
References: <1335277420-29124-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:39053 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754754Ab2DXOW5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 10:22:57 -0400
Received: by dady13 with SMTP id y13so962017dad.13
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 07:22:56 -0700 (PDT)
In-Reply-To: <1335277420-29124-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

commit e7410cf7 (02fdb03e69699f26e1370d0e51593dbc8a4e5265) moved
mangement of cam_pwrdm to CPUidle but left some remnants behind,
namely the call to clkcm_allo_idle() for the clockdomains in the MPU
pwrdm.  Remove these since they are not necessary and cause unwanted
latency in the idle path.

Cc: Tero Kristo <Tero Kristo <t-kristo@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 74a7f8c..66ff828 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -70,7 +70,6 @@ void (*omap3_do_wfi_sram)(void);
 
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
-static struct powerdomain *cam_pwrdm;
 
 static void omap3_enable_io_chain(void)
 {
@@ -395,8 +394,6 @@ void omap_sram_idle(void)
 
 	if (mpu_next_state < PWRDM_POWER_ON)
 		pwrdm_post_transition(mpu_pwrdm);
-
-	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
 static void omap3_pm_idle(void)
@@ -759,7 +756,6 @@ static int __init omap3_pm_init(void)
 	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
 	per_pwrdm = pwrdm_lookup("per_pwrdm");
 	core_pwrdm = pwrdm_lookup("core_pwrdm");
-	cam_pwrdm = pwrdm_lookup("cam_pwrdm");
 
 	neon_clkdm = clkdm_lookup("neon_clkdm");
 	mpu_clkdm = clkdm_lookup("mpu_clkdm");
-- 
1.7.9.2

