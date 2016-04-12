From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH] ARM: OMAP3: Fix external abort on 36xx waking from off mode
 idle
Date: Tue, 12 Apr 2016 10:43:57 -0500
Message-ID: <1460475837-1984-1-git-send-email-d-gerlach@ti.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Richard Woodruff <r-woodruff2@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Depending on timing during the resume path from off mode on 36xx, we may
see external aborts. These seem to be caused by the following:

- OMAP3 Advisory 1.62 "MPU Cannot Exit from Standby" says we need to
  disable disable intc autoidle before WFI

- DM3730 Advisory 1.106 "MPU Leaves MSTANDBY State Before IDLEREQ of
  Interrupt Controller is Released" says we need to wait before
  accessing intc

omap3_intc_resume_idle restores the intc autoidle for all resume paths,
however in the resume path from off mode only it is also being restored
by omap_intc_restore_context before this call to omap3_intc_resume_idle
happens. The second restore of the intc autoidle in this path is what
appears to be causing the external abort so for the off mode resume path
let's rely on omap_intc_restore_context to restore intc autoidle, and
for all other paths let omap3_intc_resume_idle handle it as it is now.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fcf975eb5e9d..bb6e13ce673a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -268,7 +268,6 @@ void omap_sram_idle(void)
 	int per_next_state = PWRDM_POWER_ON;
 	int core_next_state = PWRDM_POWER_ON;
 	int per_going_off;
-	int core_prev_state;
 	u32 sdrc_pwr = 0;
 
 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
@@ -348,17 +347,21 @@ void omap_sram_idle(void)
 		sdrc_write_reg(sdrc_pwr, SDRC_POWER);
 
 	/* CORE */
-	if (core_next_state < PWRDM_POWER_ON) {
-		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
-		if (core_prev_state == PWRDM_POWER_OFF) {
-			omap3_core_restore_context();
-			omap3_cm_restore_context();
-			omap3_push_sram_idle();
-			omap3_push_sram_secure_idle();
-			omap2_sms_restore_context();
-		}
+	if (core_next_state < PWRDM_POWER_ON &&
+	    pwrdm_read_prev_pwrst(core_pwrdm) == PWRDM_POWER_OFF) {
+		omap3_core_restore_context();
+		omap3_cm_restore_context();
+		omap3_push_sram_idle();
+		omap3_push_sram_secure_idle();
+		omap2_sms_restore_context();
+	} else {
+		/*
+		 * In off-mode resume path above, omap3_core_restore_context
+		 * also handles the INTC autoidle restore done here so limit
+		 * this to non-off mode resume paths so we don't do it twice.
+		 */
+		omap3_intc_resume_idle();
 	}
-	omap3_intc_resume_idle();
 
 	pwrdm_post_transition(NULL);
 
-- 
2.7.3
