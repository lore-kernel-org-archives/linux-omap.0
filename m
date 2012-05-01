From: jean.pihet@newoldbits.com
Subject: [PATCH 4/5] ARM: OMAP2+: PM: use the power domains registers cache invalidate API
Date: Tue,  1 May 2012 15:07:42 +0200
Message-ID: <1335877663-32649-5-git-send-email-j-pihet@ti.com>
References: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:45236 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080Ab2EANIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 09:08:15 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1464892wgb.1
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 06:08:14 -0700 (PDT)
In-Reply-To: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

The power domains registers cache is partially invalidated when clearing
the previous power states and after coming back from the low power mode,
i.e. after the return from the low level WFI instruction.

Note: this invalidate use scheme is optimized for performance, the states
returned by the state read functions might not reflect the real state if
the power domains registers have not been changed using the API or have
not been changed by the operating system (e.g. the ROM code in case of
secure code execution).

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c      |    6 ++++++
 arch/arm/mach-omap2/powerdomain.c |    4 +++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ed73ffc..a222f517 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -353,6 +353,12 @@ void omap_sram_idle(void)
 	else
 		omap34xx_do_sram_idle(save_state);
 
+	/*
+	 * Invalidate the current states from the regs cache
+	 * for all power domains
+	 */
+	pwrdm_invalidate_regs_cache_fields_current(NULL);
+
 	/* Restore normal SDRC POWER settings */
 	if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
 	    (omap_type() == OMAP2_DEVICE_TYPE_EMU ||
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 9800b2b..0b9259b 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1324,8 +1324,10 @@ int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
 	pr_debug("powerdomain: clearing previous power state reg for %s\n",
 		 pwrdm->name);
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_clear_all_prev_pwrst)
+	if (arch_pwrdm && arch_pwrdm->pwrdm_clear_all_prev_pwrst) {
 		ret = arch_pwrdm->pwrdm_clear_all_prev_pwrst(pwrdm);
+		pwrdm_invalidate_regs_cache_fields_prev(pwrdm);
+	}
 
 	return ret;
 }
-- 
1.7.7.6

