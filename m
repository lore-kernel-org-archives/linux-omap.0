From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [pm-wip/uart][PATCH 4/5 v2] OMAP3: PM: Add prepare idle and resume
     idle call for uart4
Date: Wed, 16 Jun 2010 19:44:20 +0530 (IST)
Message-ID: <2235.10.24.255.18.1276697660.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43722 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758890Ab0FPOOW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jun 2010 10:14:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Add prepare idle and resume idle call for uart4 used by 3630.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a120d4f..50c20a2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -394,6 +394,7 @@ void omap_sram_idle(void)
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(2);
+		omap_uart_prepare_idle(3);
 		omap2_gpio_prepare_for_idle(per_next_state);
 		if (per_next_state == PWRDM_POWER_OFF) {
 			if (core_next_state == PWRDM_POWER_ON) {
@@ -474,6 +475,7 @@ void omap_sram_idle(void)
 		if (per_prev_state == PWRDM_POWER_OFF)
 			omap3_per_restore_context();
 		omap_uart_resume_idle(2);
+		omap_uart_resume_idle(3);
 		if (per_state_modified)
 			pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_OFF);
 	}
-- 
1.6.3.3


