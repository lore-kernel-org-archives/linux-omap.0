From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 15/59] omap: namespace cleanup to arch/arm/mach-omap1/pm.c
Date: Wed, 12 Nov 2008 00:56:34 +0200
Message-ID: <1226444238-14614-16-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40138 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbYKKXBn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:01:43 -0500
In-Reply-To: <1226444238-14614-15-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/pm.c |   54 +++++++++++++++++++++++-----------------------
 1 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 9774c1f..3876ac2 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -146,21 +146,21 @@ void omap_pm_idle(void)
 	 * Even the sleep block count should become obsolete. */
 	if ((use_idlect1 != ~0) || !do_sleep) {
 
-		__u32 saved_idlect1 = omap_readl(ARM_IDLECT1);
+		__u32 saved_idlect1 = __raw_readl(ARM_IDLECT1);
 		if (cpu_is_omap15xx())
 			use_idlect1 &= OMAP1510_BIG_SLEEP_REQUEST;
 		else
 			use_idlect1 &= OMAP1610_IDLECT1_SLEEP_VAL;
-		omap_writel(use_idlect1, ARM_IDLECT1);
+		__raw_writel(use_idlect1, ARM_IDLECT1);
 		__asm__ volatile ("mcr	p15, 0, r0, c7, c0, 4");
-		omap_writel(saved_idlect1, ARM_IDLECT1);
+		__raw_writel(saved_idlect1, ARM_IDLECT1);
 
 		local_fiq_enable();
 		local_irq_enable();
 		return;
 	}
-	omap_sram_suspend(omap_readl(ARM_IDLECT1),
-			  omap_readl(ARM_IDLECT2));
+	omap_sram_suspend(__raw_readl(ARM_IDLECT1),
+			  __raw_readl(ARM_IDLECT2));
 
 	local_fiq_enable();
 	local_irq_enable();
@@ -192,30 +192,30 @@ static void omap_pm_wakeup_setup(void)
 		level1_wake = OMAP_IRQ_BIT(INT_GPIO_BANK1) |
 			OMAP_IRQ_BIT(INT_1610_IH2_IRQ);
 
-	omap_writel(~level1_wake, OMAP_IH1_MIR);
+	__raw_writel(~level1_wake, OMAP_IH1_MIR);
 
 	if (cpu_is_omap730()) {
-		omap_writel(~level2_wake, OMAP_IH2_0_MIR);
-		omap_writel(~(OMAP_IRQ_BIT(INT_730_WAKE_UP_REQ) |
+		__raw_writel(~level2_wake, OMAP_IH2_0_MIR);
+		__raw_writel(~(OMAP_IRQ_BIT(INT_730_WAKE_UP_REQ) |
 				OMAP_IRQ_BIT(INT_730_MPUIO_KEYPAD)),
 				OMAP_IH2_1_MIR);
 	} else if (cpu_is_omap15xx()) {
 		level2_wake |= OMAP_IRQ_BIT(INT_KEYBOARD);
-		omap_writel(~level2_wake,  OMAP_IH2_MIR);
+		__raw_writel(~level2_wake,  OMAP_IH2_MIR);
 	} else if (cpu_is_omap16xx()) {
 		level2_wake |= OMAP_IRQ_BIT(INT_KEYBOARD);
-		omap_writel(~level2_wake, OMAP_IH2_0_MIR);
+		__raw_writel(~level2_wake, OMAP_IH2_0_MIR);
 
 		/* INT_1610_WAKE_UP_REQ is needed for GPIO wakeup... */
-		omap_writel(~OMAP_IRQ_BIT(INT_1610_WAKE_UP_REQ),
+		__raw_writel(~OMAP_IRQ_BIT(INT_1610_WAKE_UP_REQ),
 			    OMAP_IH2_1_MIR);
-		omap_writel(~0x0, OMAP_IH2_2_MIR);
-		omap_writel(~0x0, OMAP_IH2_3_MIR);
+		__raw_writel(~0x0, OMAP_IH2_2_MIR);
+		__raw_writel(~0x0, OMAP_IH2_3_MIR);
 	}
 
 	/*  New IRQ agreement, recalculate in cascade order */
-	omap_writel(1, OMAP_IH2_CONTROL);
-	omap_writel(1, OMAP_IH1_CONTROL);
+	__raw_writel(1, OMAP_IH2_CONTROL);
+	__raw_writel(1, OMAP_IH1_CONTROL);
 }
 
 #define EN_DSPCK	13	/* ARM_CKCTL */
@@ -232,7 +232,7 @@ void omap_pm_suspend(void)
 	omap_serial_wake_trigger(1);
 
 	if (!cpu_is_omap15xx())
-		omap_writew(0xffff, ULPD_SOFT_DISABLE_REQ_REG);
+		__raw_writew(0xffff, ULPD_SOFT_DISABLE_REQ_REG);
 
 	/*
 	 * Step 1: turn off interrupts (FIXME: NOTE: already disabled)
@@ -302,14 +302,14 @@ void omap_pm_suspend(void)
 	 */
 
 	/* stop DSP */
-	omap_writew(omap_readw(ARM_RSTCT1) & ~(1 << DSP_EN), ARM_RSTCT1);
+	__raw_writew(__raw_readw(ARM_RSTCT1) & ~(1 << DSP_EN), ARM_RSTCT1);
 
 		/* shut down dsp_ck */
 	if (!cpu_is_omap730())
-		omap_writew(omap_readw(ARM_CKCTL) & ~(1 << EN_DSPCK), ARM_CKCTL);
+		__raw_writew(__raw_readw(ARM_CKCTL) & ~(1 << EN_DSPCK), ARM_CKCTL);
 
 	/* temporarily enabling api_ck to access DSP registers */
-	omap_writew(omap_readw(ARM_IDLECT2) | 1 << EN_APICK, ARM_IDLECT2);
+	__raw_writew(__raw_readw(ARM_IDLECT2) | 1 << EN_APICK, ARM_IDLECT2);
 
 	/* save DSP registers */
 	DSP_SAVE(DSP_IDLECT2);
@@ -328,8 +328,8 @@ void omap_pm_suspend(void)
 	 */
 
 	/* disable ARM watchdog */
-	omap_writel(0x00F5, OMAP_WDT_TIMER_MODE);
-	omap_writel(0x00A0, OMAP_WDT_TIMER_MODE);
+	__raw_writel(0x00F5, OMAP_WDT_TIMER_MODE);
+	__raw_writel(0x00A0, OMAP_WDT_TIMER_MODE);
 
 	/*
 	 * Step 6b: ARM and Traffic controller shutdown
@@ -363,7 +363,7 @@ void omap_pm_suspend(void)
 	 */
 
 	/* again temporarily enabling api_ck to access DSP registers */
-	omap_writew(omap_readw(ARM_IDLECT2) | 1 << EN_APICK, ARM_IDLECT2);
+	__raw_writew(__raw_readw(ARM_IDLECT2) | 1 << EN_APICK, ARM_IDLECT2);
 
 	/* Restore DSP domain clocks */
 	DSP_RESTORE(DSP_IDLECT2);
@@ -411,7 +411,7 @@ void omap_pm_suspend(void)
 	}
 
 	if (!cpu_is_omap15xx())
-		omap_writew(0, ULPD_SOFT_DISABLE_REQ_REG);
+		__raw_writew(0, ULPD_SOFT_DISABLE_REQ_REG);
 
 	/*
 	 * Re-enable interrupts
@@ -693,16 +693,16 @@ static int __init omap_pm_init(void)
 	/* Program new power ramp-up time
 	 * (0 for most boards since we don't lower voltage when in deep sleep)
 	 */
-	omap_writew(ULPD_SETUP_ANALOG_CELL_3_VAL, ULPD_SETUP_ANALOG_CELL_3);
+	__raw_writew(ULPD_SETUP_ANALOG_CELL_3_VAL, ULPD_SETUP_ANALOG_CELL_3);
 
 	/* Setup ULPD POWER_CTRL_REG - enter deep sleep whenever possible */
-	omap_writew(ULPD_POWER_CTRL_REG_VAL, ULPD_POWER_CTRL);
+	__raw_writew(ULPD_POWER_CTRL_REG_VAL, ULPD_POWER_CTRL);
 
 	/* Configure IDLECT3 */
 	if (cpu_is_omap730())
-		omap_writel(OMAP730_IDLECT3_VAL, OMAP730_IDLECT3);
+		__raw_writel(OMAP730_IDLECT3_VAL, OMAP730_IDLECT3);
 	else if (cpu_is_omap16xx())
-		omap_writel(OMAP1610_IDLECT3_VAL, OMAP1610_IDLECT3);
+		__raw_writel(OMAP1610_IDLECT3_VAL, OMAP1610_IDLECT3);
 
 	suspend_set_ops(&omap_pm_ops);
 
-- 
1.6.0.2.307.gc427

