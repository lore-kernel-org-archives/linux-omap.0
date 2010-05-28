From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH] OMAP3 PM: Prevent Core off when DPLL3 autoidle is disabled
Date: Fri, 28 May 2010 20:04:29 +0530
Message-ID: <1275057269-15863-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49893 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037Ab0E1OdH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 May 2010 10:33:07 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4SEX4dg026413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 28 May 2010 09:33:06 -0500
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

As per errata i580, Core should not attempt to goto OSWR/OFF state if 
DPLL3 is in manual lock mode (CM_AUTOIDLE_PLL[AUTO_CORE_DPLL] = 0).
This WA is applicable only if WA for errata i581 is applied since DPLL3
is put in manual lock mode as part of the i581 errata.
This patch has been developed on top of i581 errata WA available@
https://patchwork.kernel.org/patch/102673/

Tested on OMAP3630 ZOOM3.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b0a5d09..5b48b6c
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -461,6 +461,9 @@ void omap_sram_idle(void)
 				}
 				cm_rmw_mod_reg_bits(OMAP3430_AUTO_CORE_DPLL_MASK,
 				0x1, PLL_MOD, CM_AUTOIDLE);
+			} else if (core_next_state > PWRDM_POWER_RET) {
+				pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_RET);
+				core_next_state = PWRDM_POWER_RET;
 			}
 		}
 	}
