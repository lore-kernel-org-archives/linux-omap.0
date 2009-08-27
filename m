From: Thara Gopinath <thara@ti.com>
Subject: [PATCH][RFC] OMAP3: PM: Adding OSWR support
Date: Thu, 27 Aug 2009 22:22:42 +0530
Message-ID: <1251391962-11217-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54680 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752891AbZH0Qws (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Aug 2009 12:52:48 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7RGqhwO032311
	for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 11:52:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>

This patch adds OSWR support for MPU/CORE domains in CPUidle.
Two new C states are being added to the existing C states
which makes the new states look like below.

	C1 - MPU WFI + Core active
	C2 - MPU WFI + Core inactive
	C3 - MPU CSWR + Core inactive
	C4 - MPU OFF + Core inactive
	C5 - MPU CSWR + Core CSWR
	C6 - MPU OFF + Core CSWR
	C7 - MPU OSWR + CORE OSWR (New State)
	C8 - MPU OFF + CORE OSWR  (New State)
	C9 - MPU OFF + CORE OFF

To enable this feature echo 1 > /sys/powwer/enable_oswr_ret
To disable this feature echo 0 > /sys/poweer/enable_oswr_ret

This patch depends on http://patchwork.kernel.org/patch/44290/ and
is validated on latest PM branch on OMAP3430 SDP.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/control.c                 |   20 +++
 arch/arm/mach-omap2/cpuidle34xx.c             |  154 +++++++++++++++++++++++--
 arch/arm/mach-omap2/pm-debug.c                |    3 +
 arch/arm/mach-omap2/pm.c                      |   16 +++-
 arch/arm/mach-omap2/pm.h                      |    1 +
 arch/arm/mach-omap2/pm34xx.c                  |  119 +++++++++++++++-----
 arch/arm/mach-omap2/powerdomain.c             |   89 ++++++++++++++-
 arch/arm/mach-omap2/powerdomains34xx.h        |    2 +
 arch/arm/mach-omap2/serial.c                  |   17 +--
 arch/arm/mach-omap2/sleep34xx.S               |    7 +-
 arch/arm/plat-omap/include/mach/control.h     |    1 +
 arch/arm/plat-omap/include/mach/powerdomain.h |    4 +
 arch/arm/plat-omap/include/mach/serial.h      |    2 +-
 include/linux/cpuidle.h                       |    2 +-
 14 files changed, 379 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index c9407c0..dc90207 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -331,6 +331,26 @@ void omap3_save_scratchpad_contents(void)
 		sizeof(sdrc_block_contents), &arm_context_addr, 4);
 }
 
+void omap3_scratchpad_dpll4autoidle(int enable)
+{
+	void * __iomem scratchpad_address;
+	struct omap3_scratchpad_prcm_block prcm_block_contents;
+
+	scratchpad_address = OMAP2_IO_ADDRESS(OMAP343X_SCRATCHPAD);
+
+	memcpy_fromio(&prcm_block_contents, scratchpad_address + 0x2C,
+		sizeof(prcm_block_contents));
+	if (enable)
+		prcm_block_contents.cm_autoidle_pll |=
+			(1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT);
+	else
+		prcm_block_contents.cm_autoidle_pll &=
+			~OMAP3430_AUTO_PERIPH_DPLL_MASK;
+
+	memcpy_toio(scratchpad_address + 0x2C, &prcm_block_contents,
+		sizeof(prcm_block_contents));
+}
+
 void omap3_control_save_context(void)
 {
 	control_context.sysconfig = omap_ctrl_readl(OMAP2_CONTROL_SYSCONFIG);
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 7bbec90..a5b811b 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -36,14 +36,17 @@
 
 #ifdef CONFIG_CPU_IDLE
 
-#define OMAP3_MAX_STATES 7
+#define OMAP3_MAX_STATES 9
 #define OMAP3_STATE_C1 0 /* C1 - MPU WFI + Core active */
 #define OMAP3_STATE_C2 1 /* C2 - MPU WFI + Core inactive */
 #define OMAP3_STATE_C3 2 /* C3 - MPU CSWR + Core inactive */
-#define OMAP3_STATE_C4 3 /* C4 - MPU OFF + Core iactive */
-#define OMAP3_STATE_C5 4 /* C5 - MPU RET + Core RET */
-#define OMAP3_STATE_C6 5 /* C6 - MPU OFF + Core RET */
-#define OMAP3_STATE_C7 6 /* C7 - MPU OFF + Core OFF */
+#define OMAP3_STATE_C4 3 /* C4 - MPU OFF + Core inactive */
+#define OMAP3_STATE_C5 4 /* C5 - MPU CSWR + Core CSWR */
+#define OMAP3_STATE_C6 5 /* C6 - MPU OFF + Core CSWR */
+#define OMAP3_STATE_C7 6 /* C7 - MPU OSWR + CORE OSWR */
+#define OMAP3_STATE_C8 7 /* C8 - MPU OFF + CORE OSWR */
+#define OMAP3_STATE_C9 8 /* C9 - MPU OFF + CORE OFF */
+
 
 struct omap3_processor_cx {
 	u8 valid;
@@ -52,6 +55,11 @@ struct omap3_processor_cx {
 	u32 wakeup_latency;
 	u32 mpu_state;
 	u32 core_state;
+	u32 mpu_logicl1_ret_state;
+	u32 mpu_l2cache_ret_state;
+	u32 core_logic_state;
+	u32 core_mem1_ret_state;
+	u32 core_mem2_ret_state;
 	u32 threshold;
 	u32 flags;
 };
@@ -95,6 +103,11 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	struct omap3_processor_cx *cx = cpuidle_get_statedata(state);
 	struct timespec ts_preidle, ts_postidle, ts_idle;
 	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
+	u32 mpu_logicl1_ret_state = cx->mpu_logicl1_ret_state;
+	u32 mpu_l2cache_ret_state = cx->mpu_l2cache_ret_state;
+	u32 core_logic_state = cx->core_logic_state;
+	u32 core_mem1_ret_state = cx->core_mem1_ret_state;
+	u32 core_mem2_ret_state = cx->core_mem2_ret_state;
 
 	current_cx_state = *cx;
 
@@ -111,6 +124,34 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 			core_state = PWRDM_POWER_RET;
 	}
 
+	if (!enable_oswr_ret) {
+		if (mpu_logicl1_ret_state == PWRDM_POWER_OFF)
+			mpu_logicl1_ret_state = PWRDM_POWER_RET;
+		if (mpu_l2cache_ret_state == PWRDM_POWER_OFF)
+			mpu_l2cache_ret_state = PWRDM_POWER_RET;
+		if (core_logic_state == PWRDM_POWER_OFF)
+			core_logic_state = PWRDM_POWER_RET;
+		if (core_mem1_ret_state == PWRDM_POWER_OFF)
+			core_mem1_ret_state = PWRDM_POWER_RET;
+		if (core_mem2_ret_state == PWRDM_POWER_OFF)
+			core_mem2_ret_state = PWRDM_POWER_RET;
+	}
+
+	if (mpu_logicl1_ret_state != 0xFF)
+		pwrdm_set_logic_retst(mpu_pd, mpu_logicl1_ret_state);
+
+	if (mpu_l2cache_ret_state != 0xFF)
+		pwrdm_set_mem_retst(mpu_pd, 0, mpu_l2cache_ret_state);
+
+	if (core_logic_state != 0xFF)
+		pwrdm_set_logic_retst(core_pd, core_logic_state);
+
+	if (core_mem1_ret_state != 0xFF)
+		pwrdm_set_mem_retst(core_pd, 0, core_mem1_ret_state);
+
+	if (core_mem2_ret_state != 0xFF)
+		pwrdm_set_mem_retst(core_pd, 1, core_mem2_ret_state);
+
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
 	pwrdm_set_next_pwrst(core_pd, core_state);
 
@@ -174,10 +215,24 @@ DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
  *	C4 . MPU OFF + Core inactive
  *	C5 . MPU CSWR + Core CSWR
  *	C6 . MPU OFF + Core CSWR
- *	C7 . MPU OFF + Core OFF
+ *	C7 . MPU OSWR + Core OSWR
+ *	C8 . MPU OFF + Core OSWR
+ *	C9 . MPU OFF + Core OFF
  */
 void omap_init_power_states(void)
 {
+	int i;
+	struct omap3_processor_cx *cx;
+
+	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
+		cx = &omap3_power_states[i];
+		cx->mpu_logicl1_ret_state = 0xFF;
+		cx->mpu_l2cache_ret_state = 0xFF;
+		cx->core_logic_state = 0xFF;
+		cx->core_mem1_ret_state = 0xFF;
+		cx->core_mem2_ret_state = 0xFF;
+	}
+
 	/* C1 . MPU WFI + Core active */
 	omap3_power_states[OMAP3_STATE_C1].valid = 1;
 	omap3_power_states[OMAP3_STATE_C1].type = OMAP3_STATE_C1;
@@ -206,6 +261,10 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C3].threshold = 300;
 	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C3].mpu_logicl1_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C3].mpu_l2cache_ret_state =
+				PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
 
@@ -217,6 +276,10 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C4].threshold = 4000;
 	omap3_power_states[OMAP3_STATE_C4].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C4].mpu_logicl1_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C4].mpu_l2cache_ret_state =
+				PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C4].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
 
@@ -228,6 +291,15 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C5].threshold = 12000;
 	omap3_power_states[OMAP3_STATE_C5].mpu_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C5].core_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C5].mpu_logicl1_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C5].mpu_l2cache_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C5].core_logic_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C5].core_mem1_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C5].core_mem2_ret_state =
+				PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C5].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
 
@@ -239,19 +311,77 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C6].threshold = 15000;
 	omap3_power_states[OMAP3_STATE_C6].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C6].core_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C6].mpu_logicl1_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C6].mpu_l2cache_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C6].core_logic_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C6].core_mem1_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C6].core_mem2_ret_state =
+				PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C6].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
 
-	/* C7 . MPU OFF + Core OFF */
+	/* C7 . MPU OSWR + Core OSWR */
 	omap3_power_states[OMAP3_STATE_C7].valid = 1;
 	omap3_power_states[OMAP3_STATE_C7].type = OMAP3_STATE_C7;
-	omap3_power_states[OMAP3_STATE_C7].sleep_latency = 10000;
-	omap3_power_states[OMAP3_STATE_C7].wakeup_latency = 30000;
-	omap3_power_states[OMAP3_STATE_C7].threshold = 300000;
-	omap3_power_states[OMAP3_STATE_C7].mpu_state = PWRDM_POWER_OFF;
-	omap3_power_states[OMAP3_STATE_C7].core_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C7].sleep_latency = 4000;
+	omap3_power_states[OMAP3_STATE_C7].wakeup_latency = 9000;
+	omap3_power_states[OMAP3_STATE_C7].threshold = 18000;
+	omap3_power_states[OMAP3_STATE_C7].mpu_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C7].core_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C7].mpu_logicl1_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C7].mpu_l2cache_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C7].core_logic_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C7].core_mem1_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C7].core_mem2_ret_state =
+				PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C7].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
+
+	/* C8 . MPU OFF + Core OSWR */
+	omap3_power_states[OMAP3_STATE_C8].valid = 1;
+	omap3_power_states[OMAP3_STATE_C8].type = OMAP3_STATE_C7;
+	omap3_power_states[OMAP3_STATE_C8].sleep_latency = 8000;
+	omap3_power_states[OMAP3_STATE_C8].wakeup_latency = 25000;
+	omap3_power_states[OMAP3_STATE_C8].threshold = 250000;
+	omap3_power_states[OMAP3_STATE_C8].mpu_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C8].core_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C8].mpu_logicl1_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C8].mpu_l2cache_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C8].core_logic_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C8].core_mem1_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C8].core_mem2_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C8].flags = CPUIDLE_FLAG_TIME_VALID |
+				CPUIDLE_FLAG_CHECK_BM;
+
+	/* C9 . MPU OFF + Core OFF */
+	omap3_power_states[OMAP3_STATE_C9].valid = 1;
+	omap3_power_states[OMAP3_STATE_C9].type = OMAP3_STATE_C7;
+	omap3_power_states[OMAP3_STATE_C9].sleep_latency = 10000;
+	omap3_power_states[OMAP3_STATE_C9].wakeup_latency = 30000;
+	omap3_power_states[OMAP3_STATE_C9].threshold = 300000;
+	omap3_power_states[OMAP3_STATE_C9].mpu_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C9].core_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C9].mpu_logicl1_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C9].mpu_l2cache_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C9].core_logic_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C9].core_mem1_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C9].core_mem2_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C9].flags = CPUIDLE_FLAG_TIME_VALID |
+				CPUIDLE_FLAG_CHECK_BM;
 }
 
 struct cpuidle_driver omap3_idle_driver = {
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 1b4c160..ed7eb44 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -383,6 +383,9 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 	for (i = 0; i < 4; i++)
 		seq_printf(s, ",%s:%d", pwrdm_state_names[i],
 			pwrdm->state_counter[i]);
+	seq_printf(s, ",RET-LOGIC-OFF:%d,RET-MEM-OFF:%d",
+			pwrdm->ret_logic_off_counter,
+			pwrdm->ret_mem_off_counter);
 
 	seq_printf(s, "\n");
 
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index fec7d00..5e73613 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -40,6 +40,7 @@
 unsigned short enable_dyn_sleep;
 unsigned short clocks_off_while_idle;
 unsigned short enable_off_mode;
+unsigned short enable_oswr_ret;
 unsigned short voltage_off_while_idle;
 unsigned short wakeup_timer_seconds;
 atomic_t sleep_block = ATOMIC_INIT(0);
@@ -57,6 +58,9 @@ static struct kobj_attribute clocks_off_while_idle_attr =
 static struct kobj_attribute enable_off_mode_attr =
 	__ATTR(enable_off_mode, 0644, idle_show, idle_store);
 
+static struct kobj_attribute enable_oswr_ret_attr =
+	__ATTR(enable_oswr_ret, 0644, idle_show, idle_store);
+
 static struct kobj_attribute voltage_off_while_idle_attr =
 	__ATTR(voltage_off_while_idle, 0644, idle_show, idle_store);
 
@@ -88,6 +92,8 @@ static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
 		return sprintf(buf, "%hu\n", clocks_off_while_idle);
 	else if (attr == &enable_off_mode_attr)
 		return sprintf(buf, "%hu\n", enable_off_mode);
+	else if (attr == &enable_oswr_ret_attr)
+		return sprintf(buf, "%hu\n", enable_oswr_ret);
 	else if (attr == &voltage_off_while_idle_attr)
 		return sprintf(buf, "%hu\n", voltage_off_while_idle);
 	else if (attr == &wakeup_timer_seconds_attr)
@@ -113,7 +119,9 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
 	} else if (attr == &enable_off_mode_attr) {
 		enable_off_mode = value;
 		omap3_pm_off_mode_enable(enable_off_mode);
-	} else if (attr == &wakeup_timer_seconds_attr) {
+	} else if (attr == &enable_oswr_ret_attr)
+		enable_oswr_ret = value;
+	else if (attr == &wakeup_timer_seconds_attr) {
 		wakeup_timer_seconds = value;
 	} else if (attr == &voltage_off_while_idle_attr) {
 		voltage_off_while_idle = value;
@@ -240,6 +248,12 @@ static int __init omap_pm_init(void)
 		return error;
 	}
 	error = sysfs_create_file(power_kobj,
+				&enable_oswr_ret_attr.attr);
+	if (error) {
+		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
+		return error;
+	}
+	error = sysfs_create_file(power_kobj,
 				  &wakeup_timer_seconds_attr.attr);
 	if (error)
 		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 052c601..1e5eb74 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -16,6 +16,7 @@
 extern void *omap3_secure_ram_storage;
 extern unsigned short enable_dyn_sleep;
 extern unsigned short enable_off_mode;
+extern unsigned short enable_oswr_ret;
 extern unsigned short voltage_off_while_idle;
 
 struct prm_setup_vc {
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0150f29..99605e7 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -132,31 +132,41 @@ static void omap3_disable_io_chain(void)
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN, WKUP_MOD, PM_WKEN);
 }
 
-static void omap3_core_save_context(void)
+static void omap3_core_save_context(int core_state)
 {
-	u32 control_padconf_off;
-	/* Save the padconf registers */
-	control_padconf_off =
-	omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
-	control_padconf_off |= START_PADCONF_SAVE;
-	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
-	/* wait for the save to complete */
-	while (!omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
-			& PADCONF_SAVE_DONE)
-		;
+	if (core_state == PWRDM_POWER_OFF) {
+		u32 control_padconf_off;
+		/* Save the padconf registers */
+		control_padconf_off =
+		omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
+		control_padconf_off |= START_PADCONF_SAVE;
+		omap_ctrl_writel(control_padconf_off,
+				OMAP343X_CONTROL_PADCONF_OFF);
+		/* wait for the save to complete */
+		while (!omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
+				& PADCONF_SAVE_DONE)
+			;
+		/* Save the system control module context,
+		 * padconf already save above
+		 */
+		omap3_control_save_context();
+
+	}
 	/* Save the Interrupt controller context */
 	omap3_intc_save_context();
 	/* Save the GPMC context */
 	omap3_gpmc_save_context();
-	/* Save the system control module context, padconf already save above*/
-	omap3_control_save_context();
 	omap_dma_global_context_save();
 }
 
-static void omap3_core_restore_context(void)
+static void omap3_core_restore_context(int core_state)
 {
-	/* Restore the control module context, padconf restored by h/w */
-	omap3_control_restore_context();
+	if (core_state == PWRDM_POWER_OFF)
+		/* Restore the control module context,
+		 * padconf restored by h/w
+		 */
+		omap3_control_restore_context();
+
 	/* Restore the GPMC context */
 	omap3_gpmc_restore_context();
 	/* Restore the interrupt controller context */
@@ -343,7 +353,8 @@ void omap_sram_idle(void)
 	int mpu_next_state = PWRDM_POWER_ON;
 	int per_next_state = PWRDM_POWER_ON;
 	int core_next_state = PWRDM_POWER_ON;
-	int core_prev_state, per_prev_state;
+	int mpu_prev_state, core_prev_state, per_prev_state;
+	int mpu_logic_state, mpu_mem_state, core_logic_state, core_mem_state;
 	u32 sdrc_pwr = 0;
 	int per_state_modified = 0;
 
@@ -356,11 +367,24 @@ void omap_sram_idle(void)
 	pwrdm_clear_all_prev_pwrst(per_pwrdm);
 
 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
+	mpu_logic_state = pwrdm_read_next_logic_pwrst(mpu_pwrdm);
+	mpu_mem_state = pwrdm_read_next_mem_pwrst(mpu_pwrdm, 0);
+
 	switch (mpu_next_state) {
 	case PWRDM_POWER_ON:
+			/* No need to save context */
+			save_state = 0;
+			break;
 	case PWRDM_POWER_RET:
-		/* No need to save context */
-		save_state = 0;
+		if (!mpu_logic_state && !mpu_mem_state)
+			save_state = 3;
+		else if (!mpu_mem_state)
+			save_state = 2;
+		else if (!mpu_logic_state)
+			save_state = 1;
+		else
+			/* No need to save context */
+			save_state = 0;
 		break;
 	case PWRDM_POWER_OFF:
 		save_state = 3;
@@ -380,8 +404,11 @@ void omap_sram_idle(void)
 	/* PER */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
+	core_logic_state = pwrdm_read_next_logic_pwrst(core_pwrdm);
+	core_mem_state = pwrdm_read_next_mem_pwrst(core_pwrdm, 0) |
+				pwrdm_read_next_mem_pwrst(core_pwrdm, 1);
 	if (per_next_state < PWRDM_POWER_ON) {
-		omap_uart_prepare_idle(2);
+		omap_uart_prepare_idle(2, per_next_state);
 		omap2_gpio_prepare_for_idle(per_next_state);
 		if (per_next_state == PWRDM_POWER_OFF) {
 			if (core_next_state == PWRDM_POWER_ON) {
@@ -401,24 +428,45 @@ void omap_sram_idle(void)
 		/* Disable smartreflex before entering WFI */
 		disable_smartreflex(SR1);
 		disable_smartreflex(SR2);
-		omap_uart_prepare_idle(0);
-		omap_uart_prepare_idle(1);
+		omap_uart_prepare_idle(0, core_next_state & core_logic_state);
+		omap_uart_prepare_idle(1, core_next_state & core_logic_state);
 		if (core_next_state == PWRDM_POWER_OFF) {
 			prm_set_mod_reg_bits(OMAP3430_AUTO_OFF,
 					     OMAP3430_GR_MOD,
 					     OMAP3_PRM_VOLTCTRL_OFFSET);
-			omap3_core_save_context();
+			omap3_core_save_context(PWRDM_POWER_OFF);
+			omap3_prcm_save_context();
+		} else if ((core_next_state == PWRDM_POWER_RET) &&
+				(core_logic_state == PWRDM_POWER_OFF) &&
+				(core_mem_state == PWRDM_POWER_OFF)) {
+			omap3_core_save_context(PWRDM_POWER_RET);
 			omap3_prcm_save_context();
+			/*
+			 * This is a hack. Currently OSWR does not
+			 * work if rom code restores DPLL4 to non
+			 * auto idle mode.
+			 * ROM restore takes 20mS longer if PER/DPLL4
+			 * idle is enabled before OFF.So it is typically
+			 * not enabled. Since OSWR hangs if it is not enabled
+			 * enable it for OSWR alone. Later in the restore path
+			 * it is disabled again
+			 */
+
+			omap3_scratchpad_dpll4autoidle(1);
+			prm_set_mod_reg_bits(OMAP3430_AUTO_RET,
+						OMAP3430_GR_MOD,
+						OMAP3_PRM_VOLTCTRL_OFFSET);
+
 		} else if (core_next_state == PWRDM_POWER_RET) {
 			prm_set_mod_reg_bits(OMAP3430_AUTO_RET,
 						OMAP3430_GR_MOD,
 						OMAP3_PRM_VOLTCTRL_OFFSET);
 		}
+
 		/* Enable IO-PAD and IO-CHAIN wakeups */
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 		omap3_enable_io_chain();
 	}
-
 	/*
 	* On EMU/HS devices ROM code restores a SRDC value
 	* from scratchpad which has automatic self refresh on timeout
@@ -447,18 +495,33 @@ void omap_sram_idle(void)
 	    core_next_state == PWRDM_POWER_OFF)
 		sdrc_write_reg(sdrc_pwr, SDRC_POWER);
 
+	mpu_prev_state = pwrdm_read_prev_pwrst(mpu_pwrdm);
+
 	/* Restore table entry modified during MMU restoration */
-	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
+	if (((mpu_prev_state == PWRDM_POWER_RET) &&
+			(pwrdm_read_prev_logic_pwrst(mpu_pwrdm) ==
+			 PWRDM_POWER_OFF)) ||
+			(mpu_prev_state == PWRDM_POWER_OFF))
 		restore_table_entry();
-
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
 		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
-		if (core_prev_state == PWRDM_POWER_OFF) {
-			omap3_core_restore_context();
+		if ((core_prev_state == PWRDM_POWER_OFF) ||
+				(core_prev_state == PWRDM_POWER_RET &&
+				 pwrdm_read_prev_logic_pwrst(core_pwrdm) ==
+				 PWRDM_POWER_OFF)) {
+			omap3_core_restore_context(core_prev_state);
 			omap3_prcm_restore_context();
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
+			/*
+			 * For OSWR to work we put PER DPLL in auto
+			 * idle mode in scratchpad. Clear it so that
+			 * next time if a OFF is attempted the ROM restore
+			 * does nt take long
+			 */
+			if (core_prev_state == PWRDM_POWER_RET)
+				omap3_scratchpad_dpll4autoidle(0);
 		}
 		omap_uart_resume_idle(0);
 		omap_uart_resume_idle(1);
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 6c5fee9..ebd8649 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -128,6 +128,16 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 		prev = pwrdm_read_prev_pwrst(pwrdm);
 		if (pwrdm->state != prev)
 			pwrdm->state_counter[prev]++;
+		if (prev == PWRDM_POWER_RET) {
+			if ((pwrdm->pwrsts_logic_ret == PWRSTS_OFF_RET) &&
+					(pwrdm_read_prev_logic_pwrst(pwrdm) ==
+					 PWRDM_POWER_OFF))
+				pwrdm->ret_logic_off_counter++;
+			if ((pwrdm->pwrsts_mem_ret[0] == PWRSTS_OFF_RET) &&
+					(pwrdm_read_prev_mem_pwrst(pwrdm, 0) ==
+					PWRDM_POWER_OFF))
+				pwrdm->ret_mem_off_counter++;
+		}
 		break;
 	default:
 		return -EINVAL;
@@ -162,7 +172,8 @@ static __init void _pwrdm_setup(struct powerdomain *pwrdm)
 
 	for (i = 0; i < 4; i++)
 		pwrdm->state_counter[i] = 0;
-
+	pwrdm->ret_logic_off_counter = 0;
+	pwrdm->ret_mem_off_counter = 0;
 	pwrdm_wait_transition(pwrdm);
 	pwrdm->state = pwrdm_read_pwrst(pwrdm);
 	pwrdm->state_counter[pwrdm->state] = 1;
@@ -951,6 +962,30 @@ int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_read_next_logic_pwrst - get next powerdomain logic power state
+ * @pwrdm: struct powerdomain * to get next logic power state
+ *
+ * Return the powerdomain pwrdm's logic power state.  Returns -EINVAL
+ * if the powerdomain pointer is null or returns the next logic
+ * power state upon success.
+ */
+int pwrdm_read_next_logic_pwrst(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	/*
+	 * The register bit names below may not correspond to the
+	 * actual names of the bits in each powerdomain's register,
+	 * but the type of value returned is the same for each
+	 * powerdomain.
+	 */
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTCTRL,
+					OMAP3430_LOGICSTATEST);
+}
+
+
+/**
  * pwrdm_read_mem_pwrst - get current memory bank power state
  * @pwrdm: struct powerdomain * to get current memory bank power state
  * @bank: memory bank number (0-3)
@@ -976,7 +1011,7 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 	 * in PWST  . So the hack. Think of a cleaner
 	 * way of doing this
 	 */
-	if (cpu_is_omap34xx)
+	if (cpu_is_omap34xx())
 		if (!strcmp("mpu_pwrdm", pwrdm->name))
 			bank = 1;
 
@@ -1033,7 +1068,7 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 	 * in PREPWST  . So the hack. Think of a cleaner
 	 * way of doing this
 	 */
-	if (cpu_is_omap34xx)
+	if (cpu_is_omap34xx())
 		if (!strcmp("mpu_pwrdm", pwrdm->name))
 			bank = 1;
 	/*
@@ -1065,6 +1100,54 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 }
 
 /**
+ * pwrdm_read_next_mem_pwrst - get next memory bank power state
+ * @pwrdm: struct powerdomain * to get mext memory bank power state
+ * @bank: memory bank number (0-3)
+ *
+ * Return the powerdomain pwrdm's next memory power state for bank
+ * x.  Returns -EINVAL if the powerdomain pointer is null, -EEXIST if
+ * the target memory bank does not exist or is not controllable, or
+ * returns the next memory power state upon success.
+ */
+int pwrdm_read_next_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
+{
+	u32 m;
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (pwrdm->banks < (bank + 1))
+		return -EEXIST;
+
+	/*
+	 * The register bit names below may not correspond to the
+	 * actual names of the bits in each powerdomain's register,
+	 * but the type of value returned is the same for each
+	 * powerdomain.
+	 */
+	switch (bank) {
+	case 0:
+		m = OMAP3430_SHAREDL1CACHEFLATRETSTATE;
+		break;
+	case 1:
+		m = OMAP3430_L1FLATMEMRETSTATE;
+		break;
+	case 2:
+		m = OMAP3430_SHAREDL2CACHEFLATRETSTATE;
+		break;
+	case 3:
+		m = OMAP3430_SHAREDL2CACHEFLATRETSTATE;
+		break;
+	default:
+		WARN_ON(1); /* should never happen */
+		return -EEXIST;
+	}
+
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					PM_PWSTCTRL, m);
+}
+
+/**
  * pwrdm_clear_all_prev_pwrst - clear previous powerstate register for a pwrdm
  * @pwrdm: struct powerdomain * to clear
  *
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index aa557b2..e3d470d 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -207,6 +207,7 @@ static struct powerdomain core_34xx_pre_es3_1_pwrdm = {
 					   CHIP_IS_OMAP3430ES2 |
 					   CHIP_IS_OMAP3430ES3_0),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.dep_bit	  = OMAP3430_EN_CORE_SHIFT,
 	.banks		  = 2,
 	.pwrsts_mem_ret	  = {
@@ -225,6 +226,7 @@ static struct powerdomain core_34xx_es3_1_pwrdm = {
 	.prcm_offs	  = CORE_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.dep_bit	  = OMAP3430_EN_CORE_SHIFT,
 	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBTLL only */
 	.banks		  = 2,
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 858447f..4b139b7 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -164,9 +164,6 @@ static void omap_uart_save_context(struct omap_uart_state *uart)
 	u16 lcr = 0;
 	struct plat_serial8250_port *p = uart->p;
 
-	if (!enable_off_mode)
-		return;
-
 	lcr = serial_read_reg(p, UART_LCR);
 	serial_write_reg(p, UART_LCR, 0xBF);
 	uart->dll = serial_read_reg(p, UART_DLL);
@@ -185,9 +182,6 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
 	u16 efr = 0;
 	struct plat_serial8250_port *p = uart->p;
 
-	if (!enable_off_mode)
-		return;
-
 	if (!uart->context_valid)
 		return;
 
@@ -231,12 +225,13 @@ static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
 
 #ifdef CONFIG_PM
 
-static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
+static inline void omap_uart_disable_clocks(struct omap_uart_state *uart,
+							int power_state)
 {
 	if (!uart->clocked)
 		return;
-
-	omap_uart_save_context(uart);
+	if (power_state == PWRDM_POWER_OFF)
+		omap_uart_save_context(uart);
 	uart->clocked = 0;
 	clk_disable(uart->ick);
 	clk_disable(uart->fck);
@@ -325,13 +320,13 @@ static void omap_uart_idle_timer(unsigned long data)
 	omap_uart_allow_sleep(uart);
 }
 
-void omap_uart_prepare_idle(int num)
+void omap_uart_prepare_idle(int num, int power_state)
 {
 	struct omap_uart_state *uart;
 
 	list_for_each_entry(uart, &uart_list, node) {
 		if (num == uart->num && uart->can_sleep) {
-			omap_uart_disable_clocks(uart);
+			omap_uart_disable_clocks(uart, power_state);
 			return;
 		}
 	}
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index de31919..aabcd1f 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -256,8 +256,13 @@ restore:
 	and     r2, r2, #0x3
 	cmp     r2, #0x0	@ Check if target power state was OFF or RET
         moveq   r9, #0x3        @ MPU OFF => L1 and L2 lost
+	beq	restore_from_off
+	cmp	r2, #0x1
+	moveq	r9, #0x3
 	movne	r9, #0x1	@ Only L1 and L2 lost => avoid L2 invalidation
 	bne	logic_l1_restore
+restore_from_off:
+/*	b	restore_from_off*/
 	ldr	r0, control_stat
 	ldr	r1, [r0]
 	and	r1, #0x700
@@ -418,7 +423,7 @@ usettbr0:
 
 	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
 save_context_wfi:
-	/*b	save_context_wfi*/	@ enable to debug save code
+	/* b	save_context_wfi*/	@ enable to debug save code
 	mov	r8, r0 /* Store SDRAM address in r8 */
         /* Check what that target sleep state is:stored in r1*/
         /* 1 - Only L1 and logic lost */
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index debe3f7..0c012a1 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -287,6 +287,7 @@ extern u32 *get_es3_restore_pointer(void);
 extern u32 omap3_arm_context[128];
 extern void omap3_control_save_context(void);
 extern void omap3_control_restore_context(void);
+extern void omap3_scratchpad_dpll4autoidle(int enable);
 
 #else
 #define omap_ctrl_base_get()		0
diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h b/arch/arm/plat-omap/include/mach/powerdomain.h
index 6271d85..9960dcc 100644
--- a/arch/arm/plat-omap/include/mach/powerdomain.h
+++ b/arch/arm/plat-omap/include/mach/powerdomain.h
@@ -119,6 +119,8 @@ struct powerdomain {
 
 	int state;
 	unsigned state_counter[4];
+	unsigned ret_logic_off_counter;
+	unsigned ret_mem_off_counter;
 
 #ifdef CONFIG_PM_DEBUG
 	s64 timer;
@@ -163,8 +165,10 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
 
 int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_next_logic_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
 int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
+int pwrdm_read_next_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
 
 int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm);
 int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/plat-omap/include/mach/serial.h
index e249186..92c1199 100644
--- a/arch/arm/plat-omap/include/mach/serial.h
+++ b/arch/arm/plat-omap/include/mach/serial.h
@@ -60,7 +60,7 @@ extern void omap_serial_init(void);
 extern int omap_uart_can_sleep(void);
 extern void omap_uart_check_wakeup(void);
 extern void omap_uart_prepare_suspend(void);
-extern void omap_uart_prepare_idle(int num);
+extern void omap_uart_prepare_idle(int num, int power_state);
 extern void omap_uart_resume_idle(int num);
 extern void omap_uart_enable_irqs(int enable);
 #endif
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index dcf77fa..8ec8300 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -17,7 +17,7 @@
 #include <linux/kobject.h>
 #include <linux/completion.h>
 
-#define CPUIDLE_STATE_MAX	8
+#define CPUIDLE_STATE_MAX	16
 #define CPUIDLE_NAME_LEN	16
 #define CPUIDLE_DESC_LEN	32
 
-- 
1.5.4.7

