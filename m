From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv2 2/2] OMAP3: Implemented VFP restore/save context
Date: Thu,  3 Dec 2009 15:35:53 +0200
Message-ID: <1259847353-22725-3-git-send-email-tero.kristo@nokia.com>
References: <> <1259847353-22725-1-git-send-email-tero.kristo@nokia.com>
	<1259847353-22725-2-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1259847353-22725-2-git-send-email-tero.kristo@nokia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

VFP save context is called before MPU/NEON off. Restore is not needed as
the next VFP trap will restore context automatically. Uses the support
routine implemented in arch/arm/vfp/vfpmodule.c.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/pm.h     |    1 +
 arch/arm/mach-omap2/pm34xx.c |   14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index e0c94ea..bf9b7f9 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -23,6 +23,7 @@ extern void omap_sram_idle(void);
 extern int omap3_can_sleep(void);
 extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
+extern void vfp_pm_save_context(void);
 
 struct prm_setup_times_vc {
 	u16 clksetup;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 009bc55..624a7af 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -321,6 +321,13 @@ static void restore_control_register(u32 val)
 	__asm__ __volatile__ ("mcr p15, 0, %0, c1, c0, 0" : : "r" (val));
 }
 
+static inline void omap3_save_neon_context(void)
+{
+#ifdef CONFIG_VFP
+	vfp_pm_save_context();
+#endif
+}
+
 /* Function to restore the table entry that was modified for enabling MMU */
 static void restore_table_entry(void)
 {
@@ -365,6 +372,7 @@ void omap_sram_idle(void)
 	/* save_state = 3 => L1, L2 and logic lost */
 	int save_state = 0;
 	int mpu_next_state = PWRDM_POWER_ON;
+	int neon_next_state = PWRDM_POWER_ON;
 	int per_next_state = PWRDM_POWER_ON;
 	int core_next_state = PWRDM_POWER_ON;
 	int core_prev_state, per_prev_state;
@@ -398,8 +406,12 @@ void omap_sram_idle(void)
 	pwrdm_pre_transition();
 
 	/* NEON control */
-	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
+	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON) {
 		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
+		neon_next_state = mpu_next_state;
+		if (neon_next_state == PWRDM_POWER_OFF)
+			omap3_save_neon_context();
+	}
 
 	/* PER */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
-- 
1.5.4.3
