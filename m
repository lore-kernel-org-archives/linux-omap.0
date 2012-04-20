From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v2 3/3] ARM: omap3: pm: Remove uart module level wakeup configurations
Date: Fri, 20 Apr 2012 16:40:07 +0530
Message-ID: <1334920207-19160-4-git-send-email-govindraj.raja@ti.com>
References: <1334920207-19160-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53107 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755157Ab2DTLKb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 07:10:31 -0400
In-Reply-To: <1334920207-19160-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

The uart module level wakeups enabling and disabling
are now handled from uart driver itself remove the uart module
level configurations from pm code.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 703bd10..7a19498 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -529,8 +529,6 @@ static void __init omap3_d2d_idle(void)
 
 static void __init prcm_setup_regs(void)
 {
-	u32 omap3630_en_uart4_mask = cpu_is_omap3630() ?
-					OMAP3630_EN_UART4_MASK : 0;
 	u32 omap3630_grpsel_uart4_mask = cpu_is_omap3630() ?
 					OMAP3630_GRPSEL_UART4_MASK : 0;
 
@@ -562,13 +560,11 @@ static void __init prcm_setup_regs(void)
 				OMAP3430_DSS_MOD, PM_WKEN);
 
 	/* Enable wakeups in PER */
-	omap2_prm_write_mod_reg(omap3630_en_uart4_mask |
-			  OMAP3430_EN_GPIO2_MASK | OMAP3430_EN_GPIO3_MASK |
-			  OMAP3430_EN_GPIO4_MASK | OMAP3430_EN_GPIO5_MASK |
-			  OMAP3430_EN_GPIO6_MASK | OMAP3430_EN_UART3_MASK |
-			  OMAP3430_EN_MCBSP2_MASK | OMAP3430_EN_MCBSP3_MASK |
-			  OMAP3430_EN_MCBSP4_MASK,
-			  OMAP3430_PER_MOD, PM_WKEN);
+	omap2_prm_write_mod_reg(OMAP3430_EN_GPIO2_MASK |
+			OMAP3430_EN_GPIO3_MASK | OMAP3430_EN_GPIO4_MASK |
+			OMAP3430_EN_GPIO5_MASK | OMAP3430_EN_GPIO6_MASK |
+			OMAP3430_EN_MCBSP2_MASK | OMAP3430_EN_MCBSP3_MASK |
+			OMAP3430_EN_MCBSP4_MASK, OMAP3430_PER_MOD, PM_WKEN);
 	/* and allow them to wake up MPU */
 	omap2_prm_write_mod_reg(omap3630_grpsel_uart4_mask |
 			  OMAP3430_GRPSEL_GPIO2_MASK |
-- 
1.7.9

