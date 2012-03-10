From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv5 6/6] ARM: OMAP3 PM: Remove IO Daisychain control from
 cpuidle
Date: Fri, 9 Mar 2012 21:02:41 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203092102030.30879@utopia.booyaka.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com> <1331046702-2472-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34115 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757235Ab2CJECm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 23:02:42 -0500
In-Reply-To: <1331046702-2472-7-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

On Tue, 6 Mar 2012, Tero Kristo wrote:

> From: Vishwanath BS <vishwanath.bs@ti.com>
> 
> As IO Daisy chain sequence is triggered via hwmod mux, there is no need to
> control it from cpuidle path for OMAP3.
> 
> Also as omap3_disable_io_chain is no longer being used, just remove the
> function.
> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reviewed-by: Rajendra Nayak <rnayak@ti.com>

And here's a modified version of this one that takes into account the 
earlier changes.


- Paul

>From ad04159c4ec89eef4026fa2e2aeefc3795d98b89 Mon Sep 17 00:00:00 2001
From: Vishwanath BS <vishwanath.bs@ti.com>
Date: Fri, 2 Mar 2012 17:17:55 +0200
Subject: [PATCH 6/6] ARM: OMAP3: PM: Remove IO Daisychain control from
 cpuidle

As IO Daisy chain sequence is triggered via hwmod mux, there is no need to
control it from cpuidle path for OMAP3.

Also as omap3_disable_io_chain is no longer being used, just remove the
function.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/pm34xx.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 378a0de..ed12bb4 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -291,13 +291,6 @@ void omap_sram_idle(void)
 	/* Enable IO-PAD and IO-CHAIN wakeups */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
-	if (omap3_has_io_wakeup() &&
-	    (per_next_state < PWRDM_POWER_ON ||
-	     core_next_state < PWRDM_POWER_ON)) {
-		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
-		if (omap3_has_io_chain_ctrl())
-			omap3_reconfigure_io_chain();
-	}
 
 	pwrdm_pre_transition();
 
@@ -376,13 +369,6 @@ void omap_sram_idle(void)
 			omap3_per_restore_context();
 	}
 
-	/* Disable IO-PAD and IO-CHAIN wakeup */
-	if (omap3_has_io_wakeup() &&
-	    (per_next_state < PWRDM_POWER_ON ||
-	     core_next_state < PWRDM_POWER_ON))
-		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
-					     PM_WKEN);
-
 	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
-- 
1.7.9.1

