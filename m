From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v2] OMAP:GPTIMER:1ms tick generation correction
Date: Tue, 22 Jun 2010 01:53:18 +0530
Message-ID: <1277151798-26232-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41602 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066Ab0FUJ0u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 05:26:50 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5L9QllF015129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Jun 2010 04:26:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, R Sricharan <r.sricharan@ti.com>

Generation of 1ms granular GPTIMER events using 32KHz or system
clocks as inputs does not have whole number count value to load
into the register. This inaccurate count value with respect to 1ms
period leads to time drift subsequently. OMAP3 and later silicons
have dedicated registers for GPTIMER1, GPTIMER2 and GPTIMER10,
which can be programmed with computed values to keep this error
controlled within specified limit.

Version 2:
(i) optimized omap_dm_timer_ms_correction() function and corrected
error in computing the positive and negative increments.
(ii) typo corrections in comment section and warning removal related
to 80-character limit

Tested on Zoom3 using Linus tree.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |  131 +++++++++++++++++++++--------
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 +
 2 files changed, 96 insertions(+), 36 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index c64875f..42344a7
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -160,6 +160,9 @@ struct omap_dm_timer {
 	unsigned reserved:1;
 	unsigned enabled:1;
 	unsigned posted:1;
+#ifdef CONFIG_ARCH_OMAP2PLUS
+	unsigned ms_correction:1;
+#endif
 };
 
 static int dm_timer_count;
@@ -185,18 +188,30 @@ static const int omap1_dm_timer_count = ARRAY_SIZE(omap1_dm_timers);
 
 #ifdef CONFIG_ARCH_OMAP2
 static struct omap_dm_timer omap2_dm_timers[] = {
-	{ .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1 },
-	{ .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2 },
-	{ .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3 },
-	{ .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4 },
-	{ .phys_base = 0x4807c000, .irq = INT_24XX_GPTIMER5 },
-	{ .phys_base = 0x4807e000, .irq = INT_24XX_GPTIMER6 },
-	{ .phys_base = 0x48080000, .irq = INT_24XX_GPTIMER7 },
-	{ .phys_base = 0x48082000, .irq = INT_24XX_GPTIMER8 },
-	{ .phys_base = 0x48084000, .irq = INT_24XX_GPTIMER9 },
-	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
-	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
-	{ .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12 },
+	{ .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1,
+						.ms_correction = 0 },
+	{ .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2,
+						.ms_correction = 0 },
+	{ .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3,
+						.ms_correction = 0 },
+	{ .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4,
+						.ms_correction = 0 },
+	{ .phys_base = 0x4807c000, .irq = INT_24XX_GPTIMER5,
+						.ms_correction = 0 },
+	{ .phys_base = 0x4807e000, .irq = INT_24XX_GPTIMER6,
+						.ms_correction = 0 },
+	{ .phys_base = 0x48080000, .irq = INT_24XX_GPTIMER7,
+						.ms_correction = 0 },
+	{ .phys_base = 0x48082000, .irq = INT_24XX_GPTIMER8,
+						.ms_correction = 0 },
+	{ .phys_base = 0x48084000, .irq = INT_24XX_GPTIMER9,
+						.ms_correction = 0 },
+	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10,
+						.ms_correction = 0 },
+	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11,
+						.ms_correction = 0 },
+	{ .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12,
+						.ms_correction = 0 },
 };
 
 static const char *omap2_dm_source_names[] __initdata = {
@@ -218,18 +233,30 @@ static const int omap2_dm_timer_count = ARRAY_SIZE(omap2_dm_timers);
 
 #ifdef CONFIG_ARCH_OMAP3
 static struct omap_dm_timer omap3_dm_timers[] = {
-	{ .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1 },
-	{ .phys_base = 0x49032000, .irq = INT_24XX_GPTIMER2 },
-	{ .phys_base = 0x49034000, .irq = INT_24XX_GPTIMER3 },
-	{ .phys_base = 0x49036000, .irq = INT_24XX_GPTIMER4 },
-	{ .phys_base = 0x49038000, .irq = INT_24XX_GPTIMER5 },
-	{ .phys_base = 0x4903A000, .irq = INT_24XX_GPTIMER6 },
-	{ .phys_base = 0x4903C000, .irq = INT_24XX_GPTIMER7 },
-	{ .phys_base = 0x4903E000, .irq = INT_24XX_GPTIMER8 },
-	{ .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9 },
-	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
-	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
-	{ .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ },
+	{ .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1,
+						.ms_correction = 1 },
+	{ .phys_base = 0x49032000, .irq = INT_24XX_GPTIMER2,
+						.ms_correction = 1 },
+	{ .phys_base = 0x49034000, .irq = INT_24XX_GPTIMER3,
+						.ms_correction = 0 },
+	{ .phys_base = 0x49036000, .irq = INT_24XX_GPTIMER4,
+						.ms_correction = 0 },
+	{ .phys_base = 0x49038000, .irq = INT_24XX_GPTIMER5,
+						.ms_correction = 0 },
+	{ .phys_base = 0x4903A000, .irq = INT_24XX_GPTIMER6,
+						.ms_correction = 0 },
+	{ .phys_base = 0x4903C000, .irq = INT_24XX_GPTIMER7,
+						.ms_correction = 0 },
+	{ .phys_base = 0x4903E001, .irq = INT_24XX_GPTIMER8,
+						.ms_correction = 0 },
+	{ .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9,
+						.ms_correction = 0 },
+	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10,
+						.ms_correction = 1 },
+	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11,
+						.ms_correction = 0 },
+	{ .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ,
+						.ms_correction = 0 },
 };
 
 static const char *omap3_dm_source_names[] __initdata = {
@@ -250,18 +277,30 @@ static const int omap3_dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
 
 #ifdef CONFIG_ARCH_OMAP4
 static struct omap_dm_timer omap4_dm_timers[] = {
-	{ .phys_base = 0x4a318000, .irq = OMAP44XX_IRQ_GPT1 },
-	{ .phys_base = 0x48032000, .irq = OMAP44XX_IRQ_GPT2 },
-	{ .phys_base = 0x48034000, .irq = OMAP44XX_IRQ_GPT3 },
-	{ .phys_base = 0x48036000, .irq = OMAP44XX_IRQ_GPT4 },
-	{ .phys_base = 0x40138000, .irq = OMAP44XX_IRQ_GPT5 },
-	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT6 },
-	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT7 },
-	{ .phys_base = 0x4013e000, .irq = OMAP44XX_IRQ_GPT8 },
-	{ .phys_base = 0x4803e000, .irq = OMAP44XX_IRQ_GPT9 },
-	{ .phys_base = 0x48086000, .irq = OMAP44XX_IRQ_GPT10 },
-	{ .phys_base = 0x48088000, .irq = OMAP44XX_IRQ_GPT11 },
-	{ .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12 },
+	{ .phys_base = 0x4a318000, .irq = OMAP44XX_IRQ_GPT1,
+						.ms_correction = 1 },
+	{ .phys_base = 0x48032000, .irq = OMAP44XX_IRQ_GPT2,
+						.ms_correction = 1 },
+	{ .phys_base = 0x48034000, .irq = OMAP44XX_IRQ_GPT3,
+						.ms_correction = 0 },
+	{ .phys_base = 0x48036000, .irq = OMAP44XX_IRQ_GPT4,
+						.ms_correction = 0 },
+	{ .phys_base = 0x40138000, .irq = OMAP44XX_IRQ_GPT5,
+						.ms_correction = 0 },
+	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT6,
+						.ms_correction = 0 },
+	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT7,
+						.ms_correction = 0 },
+	{ .phys_base = 0x4013e000, .irq = OMAP44XX_IRQ_GPT8,
+						.ms_correction = 0 },
+	{ .phys_base = 0x4803e000, .irq = OMAP44XX_IRQ_GPT9,
+						.ms_correction = 0 },
+	{ .phys_base = 0x48086000, .irq = OMAP44XX_IRQ_GPT10,
+						.ms_correction = 1 },
+	{ .phys_base = 0x48088000, .irq = OMAP44XX_IRQ_GPT11,
+						.ms_correction = 0 },
+	{ .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12,
+						.ms_correction = 0 },
 };
 static const char *omap4_dm_source_names[] __initdata = {
 	"sys_clkin_ck",
@@ -612,6 +651,10 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 {
 	u32 l;
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
+	if (timer->ms_correction)
+		omap_dm_timer_ms_correction(timer, load);
+#endif
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (autoreload) {
 		l |= OMAP_TIMER_CTRL_AR;
@@ -733,6 +776,22 @@ int omap_dm_timers_active(void)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timers_active);
 
+/**
+ * omap_dm_timer_ms_correction - hardware correction for millisecond timer
+ * @timer: GPTIMER on which the correction support is to be applied
+ * @load: timer load value, used here to extract the expiry count
+ */
+void omap_dm_timer_ms_correction(struct omap_dm_timer *timer, u32 load)
+{
+	int pos_increment, neg_increment;
+	unsigned int count = (0xFFFFFFFF - load)*1024;
+
+	pos_increment = (((count/1000)+1)*1000000) - (count*1000);
+	neg_increment = ((count/1000)*1000000) - (count*1000);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_TICK_POS_REG, pos_increment);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_TICK_NEG_REG, neg_increment);
+}
+
 int __init omap_dm_timer_init(void)
 {
 	struct omap_dm_timer *timer;
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 20f1054..ad37bcc 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -80,5 +80,6 @@ void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value
 
 int omap_dm_timers_active(void);
 
+void omap_dm_timer_ms_correction(struct omap_dm_timer *timer, u32 load);
 
 #endif /* __ASM_ARCH_DMTIMER_H */
-- 
1.6.0.4

