From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] OMAP3: cpuidle: add more details to the DSS-related CORE
	power domain state restriction
Date: Tue, 01 Mar 2011 15:49:25 -0700
Message-ID: <20110301224924.32613.57042.stgit@twilight.localdomain>
References: <20110301220833.32613.54669.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54716 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659Ab1CAWu1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 17:50:27 -0500
In-Reply-To: <20110301220833.32613.54669.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Tero Kristo <tero.kristo@nokia.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean Pihet <j-pihet@ti.com>

Provide some more details about the rationale behind the CORE power domain
state restriction while DSS is enabled -- hopefully, enough to enable others
to implement an approach based on the DSS's required wakeup latency,
which can vary based on quite a few parameters.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>
Cc: Sumit Semwal <sumit.semwal@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index d1b7789..6bdbb33 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -269,7 +269,33 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 		goto select_state;
 	}
 
-	/* If DSS is active, prevent CORE RET/OFF */
+	/*
+	 * If DSS is active, prevent any CORE power domain transition
+	 * to RETENTION or lower.  This is because we don't currently
+	 * have the infrastructure in the DSS driver or kernel to
+	 * enter CORE RET without causing DSS FIFO underflows.  When
+	 * the DSS FIFO underflows, the screen image can be distorted,
+	 * because the CORE may not be able to come back on-line
+	 * quickly enough to service DSS requests to the SDRAM
+	 * framebuffer.  The DSS may also interrupt the MPU when the
+	 * FIFO underflows, potentially wasting power.
+	 *
+	 * The approach below is easy to implement, but potentially
+	 * wastes power, especially with screens that don't require a
+	 * backlight.  Probably the best long-term way to fix this is
+	 * for the DSS driver to constrain the CORE and SDRAM minimum
+	 * power state with omap_pm_set_max_dev_wakeup_lat(), based on
+	 * the DSS FIFO size(s), watermark levels, drain rate, and
+	 * refill time.  Based on that constraint, the OMAP PM code
+	 * should adjust the CORE maximum power state, CORE DPLL
+	 * autoidle mode, CORE_CLK rate, and voltage scaling to ensure
+	 * the required wakeup latency at the lowest power
+	 * consumption.
+	 *
+	 * (More information on the DSS low-power refresh mode can be
+	 * found in _Using Display Low-Power Refresh on the OMAP3430
+	 * Device_, TI Application Report, SWPA158 - October 2008.)
+	 */
 	dss_state = pwrdm_read_pwrst(dss_pd);
 	if (dss_state == PWRDM_POWER_ON &&
 	    core_next_state != PWRDM_POWER_ON)


