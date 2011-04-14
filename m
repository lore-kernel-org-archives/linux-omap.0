From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH linux-omap-pm/pm-wip/cpufreq] OMAP2PLUS: cpufreq: Fix typo when attempting to set mpu_clk for OMAP4
Date: Thu, 14 Apr 2011 16:21:58 +0300
Message-ID: <1302787318-6650-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40305 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab1DNNUt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Apr 2011 09:20:49 -0400
Received: by ewy4 with SMTP id 4so448932ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Apr 2011 06:20:47 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

Fix this typo as there is no dpll_mpu_ck for OMAP3 and code flow is clearly
trying to set mpu_clk for OMAP4 for which this dpll_mpu_ck is available.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 8d472f6..d53ce23 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -161,7 +161,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 		mpu_clk = clk_get(NULL, "virt_prcm_set");
 	else if (cpu_is_omap34xx())
 		mpu_clk = clk_get(NULL, "dpll1_ck");
-	else if (cpu_is_omap34xx())
+	else if (cpu_is_omap44xx())
 		mpu_clk = clk_get(NULL, "dpll_mpu_ck");
 
 	if (IS_ERR(mpu_clk))
-- 
1.7.4.1

