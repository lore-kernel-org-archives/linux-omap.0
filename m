From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 1/2] memory: ti-emif-sram: Add ti_emif_run_hw_leveling for
 DDR3 hardware leveling
Date: Tue, 2 Apr 2019 11:57:42 -0500
Message-ID: <20190402165743.28106-2-d-gerlach@ti.com>
References: <20190402165743.28106-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190402165743.28106-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Keerthy J <j-keerthy@ti.com>, linux-omap@vger.kernel.org, Brad Griffis <bgriffis@ti.com>, linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

In certain situations, such as when returning from low power modes, the
EMIF must re-run hardware leveling to properly restore DDR3 access.

This is accomplished by introducing a new ti-emif-sram-pm call,
ti_emif_run_hw_leveling, to check if DDR3 is in use and if so, trigger
the full write and read leveling processes.

Suggested-by: Brad Griffis <bgriffis@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/memory/emif.h            |  4 ++++
 drivers/memory/ti-emif-pm.c      |  3 +++
 drivers/memory/ti-emif-sram-pm.S | 41 ++++++++++++++++++++++++++++++++
 include/linux/ti-emif-sram.h     |  3 +++
 4 files changed, 51 insertions(+)

diff --git a/drivers/memory/emif.h b/drivers/memory/emif.h
index 9e9f8037955d..6b71fadb3cfa 100644
--- a/drivers/memory/emif.h
+++ b/drivers/memory/emif.h
@@ -537,6 +537,9 @@
 #define MCONNID_SHIFT					0
 #define MCONNID_MASK					(0xff << 0)
 
+/* READ_WRITE_LEVELING_CONTROL */
+#define RDWRLVLFULL_START				0x80000000
+
 /* DDR_PHY_CTRL_1 - EMIF4D */
 #define DLL_SLAVE_DLY_CTRL_SHIFT_4D			4
 #define DLL_SLAVE_DLY_CTRL_MASK_4D			(0xFF << 4)
@@ -598,6 +601,7 @@ extern struct emif_regs_amx3 ti_emif_regs_amx3;
 
 void ti_emif_save_context(void);
 void ti_emif_restore_context(void);
+void ti_emif_run_hw_leveling(void);
 void ti_emif_enter_sr(void);
 void ti_emif_exit_sr(void);
 void ti_emif_abort_sr(void);
diff --git a/drivers/memory/ti-emif-pm.c b/drivers/memory/ti-emif-pm.c
index 2250d03ea17f..ab07aa163138 100644
--- a/drivers/memory/ti-emif-pm.c
+++ b/drivers/memory/ti-emif-pm.c
@@ -138,6 +138,9 @@ static int ti_emif_alloc_sram(struct device *dev,
 	emif_data->pm_functions.exit_sr =
 		sram_resume_address(emif_data,
 				    (unsigned long)ti_emif_exit_sr);
+	emif_data->pm_functions.run_hw_leveling =
+		sram_resume_address(emif_data,
+				    (unsigned long)ti_emif_run_hw_leveling);
 
 	emif_data->pm_data.regs_virt =
 		(struct emif_regs_amx3 *)emif_data->ti_emif_sram_data_virt;
diff --git a/drivers/memory/ti-emif-sram-pm.S b/drivers/memory/ti-emif-sram-pm.S
index a5369181e5c2..d75ae18efa7d 100644
--- a/drivers/memory/ti-emif-sram-pm.S
+++ b/drivers/memory/ti-emif-sram-pm.S
@@ -27,6 +27,7 @@
 #define EMIF_POWER_MGMT_SELF_REFRESH_MODE_MASK		0x0700
 
 #define EMIF_SDCFG_TYPE_DDR2				0x2 << SDRAM_TYPE_SHIFT
+#define EMIF_SDCFG_TYPE_DDR3				0x3 << SDRAM_TYPE_SHIFT
 #define EMIF_STATUS_READY				0x4
 
 #define AM43XX_EMIF_PHY_CTRL_REG_COUNT                  0x120
@@ -244,6 +245,46 @@ emif_skip_restore_extra_regs:
 	mov	pc, lr
 ENDPROC(ti_emif_restore_context)
 
+/*
+ * void ti_emif_run_hw_leveling(void)
+ *
+ * Used during resume to run hardware leveling again and restore the
+ * configuration of the EMIF PHY, only for DDR3.
+ */
+ENTRY(ti_emif_run_hw_leveling)
+	adr	r4, ti_emif_pm_sram_data
+	ldr	r0, [r4, #EMIF_PM_BASE_ADDR_PHYS_OFFSET]
+
+	ldr	r3, [r0, #EMIF_READ_WRITE_LEVELING_CONTROL]
+	orr	r3, r3, #RDWRLVLFULL_START
+	ldr	r2, [r0, #EMIF_SDRAM_CONFIG]
+	and	r2, r2, #SDRAM_TYPE_MASK
+	cmp	r2, #EMIF_SDCFG_TYPE_DDR3
+	bne	skip_hwlvl
+
+	str	r3, [r0, #EMIF_READ_WRITE_LEVELING_CONTROL]
+
+	/*
+	 * If EMIF registers are touched during initial stage of HW
+	 * leveling sequence there will be an L3 NOC timeout error issued
+	 * as the EMIF will not respond, which is not fatal, but it is
+	 * avoidable. This small wait loop is enough time for this condition
+	 * to clear, even at worst case of CPU running at max speed of 1Ghz.
+	 */
+	mov	r2, #0x2000
+1:
+	subs	r2, r2, #0x1
+	bne	1b
+
+	/* Bit clears when operation is complete */
+2:	ldr     r1, [r0, #EMIF_READ_WRITE_LEVELING_CONTROL]
+	tst     r1, #RDWRLVLFULL_START
+	bne     2b
+
+skip_hwlvl:
+	mov	pc, lr
+ENDPROC(ti_emif_run_hw_leveling)
+
 /*
  * void ti_emif_enter_sr(void)
  *
diff --git a/include/linux/ti-emif-sram.h b/include/linux/ti-emif-sram.h
index 53604b087f2c..2fc854155c27 100644
--- a/include/linux/ti-emif-sram.h
+++ b/include/linux/ti-emif-sram.h
@@ -55,6 +55,7 @@ struct ti_emif_pm_data {
 struct ti_emif_pm_functions {
 	u32 save_context;
 	u32 restore_context;
+	u32 run_hw_leveling;
 	u32 enter_sr;
 	u32 exit_sr;
 	u32 abort_sr;
@@ -126,6 +127,8 @@ static inline void ti_emif_asm_offsets(void)
 	       offsetof(struct ti_emif_pm_functions, save_context));
 	DEFINE(EMIF_PM_RESTORE_CONTEXT_OFFSET,
 	       offsetof(struct ti_emif_pm_functions, restore_context));
+	DEFINE(EMIF_PM_RUN_HW_LEVELING,
+	       offsetof(struct ti_emif_pm_functions, run_hw_leveling));
 	DEFINE(EMIF_PM_ENTER_SR_OFFSET,
 	       offsetof(struct ti_emif_pm_functions, enter_sr));
 	DEFINE(EMIF_PM_EXIT_SR_OFFSET,
-- 
2.20.1
