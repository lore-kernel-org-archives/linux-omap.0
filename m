From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH/RFC] ARM: OMAP2: PRCM: more init, and clear wakeup events.
Date: Thu, 01 Nov 2007 16:11:56 -0700
Message-ID: <20071101231156.378789006@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

More initialization of wake dependencies.
Clear PRCM wake-up events after coming out of full-retention.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/mach-omap2/pm.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

Index: dev/arch/arm/mach-omap2/pm.c
===================================================================
--- dev.orig/arch/arm/mach-omap2/pm.c
+++ dev/arch/arm/mach-omap2/pm.c
@@ -397,7 +397,7 @@ void omap2_allow_sleep(void)
 
 static void omap2_enter_full_retention(void)
 {
-	u32 sleep_time = 0;
+	u32 l, sleep_time = 0;
 
 	/* There is 1 reference hold for all children of the oscillator
 	 * clock, the following will remove it. If no one else uses the
@@ -450,6 +450,24 @@ no_sleep:
 
 	clk_enable(osc_ck);
 
+	/* clear CORE wake-up events */
+	prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
+	prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
+
+	/* wakeup domain events */
+	l = prm_read_mod_reg(WKUP_MOD, PM_WKST);
+	l &= 0x5;  /* bit 1: GPT1, bit5 GPIO */
+	prm_write_mod_reg(l, WKUP_MOD, PM_WKST);
+
+	/* MPU domain wake events */
+	l = prm_read_reg(OMAP24XX_PRCM_IRQSTATUS_MPU);
+	if (l & 0x01)
+		prm_write_reg(0x01, OMAP24XX_PRCM_IRQSTATUS_MPU);
+	if (l & 0x20)
+		prm_write_reg(0x20, OMAP24XX_PRCM_IRQSTATUS_MPU);
+
+	/* Mask future PRCM-to-MPU interrupts */
+	prm_write_reg(0x0, OMAP24XX_PRCM_IRQSTATUS_MPU);
 }
 
 static int omap2_i2c_active(void)
@@ -654,6 +672,9 @@ static void __init prcm_setup_regs(void)
 	prm_write_mod_reg(OMAP_EN_WKUP, MPU_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, OMAP24XX_DSP_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, CORE_MOD, PM_WKDEP);
+	if (cpu_is_omap2430())
+		prm_write_mod_reg(0, OMAP2430_MDM_MOD, PM_WKDEP);
 
 	l = prm_read_mod_reg(CORE_MOD, PM_PWSTCTRL);
 	/* Enable retention for all memory blocks */
--
