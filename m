From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH v2] Revert "ARM: OMAP3: PM: call pre/post transition per
 powerdomain"
Date: Tue,  7 Aug 2012 15:47:39 -0700
Message-ID: <1344379659-26152-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This reverts commit 58f0829b7186150318c79515f0e0850c5e7a9c89.

Converstion to per-pwrdm per/post transition calls was a bit
premature.  Only tracking MPU, PER & CORE in the idle path means we
lose the accounting for all the other powerdomains which may also
transition in idle.  On OMAP3, due to autodeps, several powerdomains
transition along with MPU (e.g. DSS, USBHOST), and the accounting for
these was lost with this patch.  Since the accounting includes the
context loss counters, drivers for devices in those power domains
would never notice context lost, so would likely hang after any
off-mode transitions.

This patch should be revisited when the upcoming clkdm/pwrmdm/voltdm
use-counting seires is merged since then we can properly do accounting
without relying on a call in the idle path.

In addition, the original patch had another bug because the PER
powerdomain accounting was not updated until after the GPIO resume
hook is called.  Since gpio_resume_after_idle() checks the context
loss count (which is not yet updated) it would not properly restore
context, leaving the GPIO banks in an undefined state.

Cc: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Reported-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e4fc88c..05bd8f0 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -272,21 +272,16 @@ void omap_sram_idle(void)
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
 
-	if (mpu_next_state < PWRDM_POWER_ON) {
-		pwrdm_pre_transition(mpu_pwrdm);
-		pwrdm_pre_transition(neon_pwrdm);
-	}
+	pwrdm_pre_transition(NULL);
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
-		pwrdm_pre_transition(per_pwrdm);
 		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
 		omap2_gpio_prepare_for_idle(per_going_off);
 	}
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
-		pwrdm_pre_transition(core_pwrdm);
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_cm_save_context();
@@ -339,20 +334,14 @@ void omap_sram_idle(void)
 			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
 					       OMAP3430_GR_MOD,
 					       OMAP3_PRM_VOLTCTRL_OFFSET);
-		pwrdm_post_transition(core_pwrdm);
 	}
 	omap3_intc_resume_idle();
 
+	pwrdm_post_transition(NULL);
+
 	/* PER */
-	if (per_next_state < PWRDM_POWER_ON) {
+	if (per_next_state < PWRDM_POWER_ON)
 		omap2_gpio_resume_after_idle();
-		pwrdm_post_transition(per_pwrdm);
-	}
-
-	if (mpu_next_state < PWRDM_POWER_ON) {
-		pwrdm_post_transition(mpu_pwrdm);
-		pwrdm_post_transition(neon_pwrdm);
-	}
 }
 
 static void omap3_pm_idle(void)
-- 
1.7.9.2
