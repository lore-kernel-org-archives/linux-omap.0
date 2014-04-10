From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/11] ARM: OMAP3: PM: remove access to PRM_VOLTCTRL register
Date: Thu, 10 Apr 2014 16:47:09 -0700
Message-ID: <1397173639-29587-2-git-send-email-tony@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48844 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065AbaDJXrX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2014 19:47:23 -0400
In-Reply-To: <1397173639-29587-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@linaro.org>, Paul Walmsley <paul@pwsan.com>

From: Tero Kristo <t-kristo@ti.com>

There is a solitary write to this register every wakeup from off-mode,
which isn't doing anything, so remove it.

Also note that modifying this register trashes any attempted
voltage scaling configuration and the change probably should
never have gotten merged in the first place.

Cc: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
[tony@atomide.com: updated comments to describe regression]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm34xx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1f3770a..87099bb 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -330,10 +330,6 @@ void omap_sram_idle(void)
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
 		}
-		if (core_next_state == PWRDM_POWER_OFF)
-			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
-					       OMAP3430_GR_MOD,
-					       OMAP3_PRM_VOLTCTRL_OFFSET);
 	}
 	omap3_intc_resume_idle();
 
-- 
1.8.1.1

