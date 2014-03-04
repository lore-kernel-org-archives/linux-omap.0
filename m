From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 12/18] ARM: OMAP3: PM: remove access to PRM_VOLTCTRL register
Date: Tue, 4 Mar 2014 18:19:12 +0200
Message-ID: <1393949958-816-13-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48433 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbaCDQU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Mar 2014 11:20:26 -0500
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

There is a solitary write to this register every wakeup from off-mode,
which isn't doing anything, so remove it.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0eecf6f..2fa9478 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -282,10 +282,6 @@ void omap_sram_idle(void)
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
1.7.9.5

