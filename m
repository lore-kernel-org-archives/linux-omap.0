From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 09/13] OMAP3: PM: Apply errata i540 before save secure ram
Date: Thu, 18 Nov 2010 19:54:54 -0600
Message-ID: <1290131698-6194-10-git-send-email-nm@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55462 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab0KSBzD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 20:55:03 -0500
In-Reply-To: <1290131698-6194-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

We need to disable the autoidle bit from MPU INTC,
otherwise INTC would get stall, and we would never
come out of WFI. This must be done before save secure ram
as well because save secure ram also does WFI.

This patch is just a addition to the current W/A we have for i540,
in order to cover the WFI inside the save secure ram.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index f520b38..c7e2db0 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -422,6 +422,14 @@ void omap_sram_idle(void)
 				omap3_per_save_context();
 	}
 
+	/*
+	 * We need to disable the autoidle bit from MPU INTC,
+	 * otherwise INTC would get stall, and we would never
+	 * come out of WFI. This is done here because
+	 * save secure ram also does WFI.
+	 */
+	omap3_intc_prepare_idle();
+
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(0);
@@ -433,8 +441,6 @@ void omap_sram_idle(void)
 		}
 	}
 
-	omap3_intc_prepare_idle();
-
 	/*
 	* On EMU/HS devices ROM code restores a SRDC value
 	* from scratchpad which has automatic self refresh on timeout
-- 
1.6.3.3

