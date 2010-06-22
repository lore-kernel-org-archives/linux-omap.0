From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3]OMAP:GPTIMER:1ms tick generation correction
Date: Wed, 23 Jun 2010 02:07:58 +0530
Message-ID: <1277239078-31386-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55258 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758965Ab0FVJle (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jun 2010 05:41:34 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5M9fVJk027093
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 22 Jun 2010 04:41:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: R Sricharan <r.sricharan@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

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

Version 3:
(i) removed un-necessary initialization of ms_correction variable.
(ii) convert omap_dm_timer_ms_correction(...) to static since it
is used locally ONLY.
(iii) use DIV_ROUND_UP() macro in the positive and negative increment
computation to avoid underflow.
(iv) correct coding violations: space around mathematical operators
like *, +, etc. and further 80-character violations.

Version 4:
[In-progress]
(i) coordination with GPTIMER hwmod changes
(ii) investigate generic clock code for similar functionality/
implementation

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   43 ++++++++++++++++++++++++++++++++++++-----
 1 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index c64875f..03ea90d 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -40,6 +40,7 @@
 #include <mach/hardware.h>
 #include <plat/dmtimer.h>
 #include <mach/irqs.h>
+#include <linux/kernel.h>
 
 /* register offsets */
 #define _OMAP_TIMER_ID_OFFSET		0x00
@@ -160,6 +161,9 @@ struct omap_dm_timer {
 	unsigned reserved:1;
 	unsigned enabled:1;
 	unsigned posted:1;
+#ifdef CONFIG_ARCH_OMAP2PLUS
+	unsigned ms_correction:1;
+#endif
 };
 
 static int dm_timer_count;
@@ -218,8 +222,10 @@ static const int omap2_dm_timer_count = ARRAY_SIZE(omap2_dm_timers);
 
 #ifdef CONFIG_ARCH_OMAP3
 static struct omap_dm_timer omap3_dm_timers[] = {
-	{ .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1 },
-	{ .phys_base = 0x49032000, .irq = INT_24XX_GPTIMER2 },
+	{ .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1,
+					.ms_correction = 1 },
+	{ .phys_base = 0x49032000, .irq = INT_24XX_GPTIMER2,
+					.ms_correction = 1 },
 	{ .phys_base = 0x49034000, .irq = INT_24XX_GPTIMER3 },
 	{ .phys_base = 0x49036000, .irq = INT_24XX_GPTIMER4 },
 	{ .phys_base = 0x49038000, .irq = INT_24XX_GPTIMER5 },
@@ -227,7 +233,8 @@ static struct omap_dm_timer omap3_dm_timers[] = {
 	{ .phys_base = 0x4903C000, .irq = INT_24XX_GPTIMER7 },
 	{ .phys_base = 0x4903E000, .irq = INT_24XX_GPTIMER8 },
 	{ .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9 },
-	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
+	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10,
+					.ms_correction = 1 },
 	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
 	{ .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ },
 };
@@ -250,8 +257,10 @@ static const int omap3_dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
 
 #ifdef CONFIG_ARCH_OMAP4
 static struct omap_dm_timer omap4_dm_timers[] = {
-	{ .phys_base = 0x4a318000, .irq = OMAP44XX_IRQ_GPT1 },
-	{ .phys_base = 0x48032000, .irq = OMAP44XX_IRQ_GPT2 },
+	{ .phys_base = 0x4a318000, .irq = OMAP44XX_IRQ_GPT1,
+					.ms_correction = 1 },
+	{ .phys_base = 0x48032000, .irq = OMAP44XX_IRQ_GPT2,
+					.ms_correction = 1 },
 	{ .phys_base = 0x48034000, .irq = OMAP44XX_IRQ_GPT3 },
 	{ .phys_base = 0x48036000, .irq = OMAP44XX_IRQ_GPT4 },
 	{ .phys_base = 0x40138000, .irq = OMAP44XX_IRQ_GPT5 },
@@ -259,7 +268,8 @@ static struct omap_dm_timer omap4_dm_timers[] = {
 	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT7 },
 	{ .phys_base = 0x4013e000, .irq = OMAP44XX_IRQ_GPT8 },
 	{ .phys_base = 0x4803e000, .irq = OMAP44XX_IRQ_GPT9 },
-	{ .phys_base = 0x48086000, .irq = OMAP44XX_IRQ_GPT10 },
+	{ .phys_base = 0x48086000, .irq = OMAP44XX_IRQ_GPT10,
+					.ms_correction = 1 },
 	{ .phys_base = 0x48088000, .irq = OMAP44XX_IRQ_GPT11 },
 	{ .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12 },
 };
@@ -360,6 +370,23 @@ static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
 	omap_dm_timer_enable(timer);
 	omap_dm_timer_reset(timer);
 }
+/**
+ * omap_dm_timer_ms_correction - hardware correction for millisecond timer
+ * @timer: GPTIMER on which the correction support is to be applied
+ * @load: timer load value, used here to extract the expiry count
+ */
+static void omap_dm_timer_ms_correction(struct omap_dm_timer *timer, u32 load)
+{
+	int pos_increment, neg_increment;
+	unsigned int count = (0xFFFFFFFF - load) * 1024;
+
+	pos_increment = (DIV_ROUND_UP(count, 1000) * 1000000) \
+			- (count * 1000);
+	neg_increment = ((DIV_ROUND_UP(count, 1000) - 1) * 1000000) \
+			- (count * 1000);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_TICK_POS_REG, pos_increment);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_TICK_NEG_REG, neg_increment);
+}
 
 struct omap_dm_timer *omap_dm_timer_request(void)
 {
@@ -612,6 +639,10 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 {
 	u32 l;
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
+	if (timer->ms_correction)
+		omap_dm_timer_ms_correction(timer, load);
+#endif
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (autoreload) {
 		l |= OMAP_TIMER_CTRL_AR;
-- 
1.6.0.4

