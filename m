From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 4/6] OMAP3: PM: Use PRCM chain handler
Date: Wed, 22 Jun 2011 19:42:12 +0300
Message-ID: <1308760934-9757-5-git-send-email-t-kristo@ti.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34851 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757493Ab1FVQmk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jun 2011 12:42:40 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5MGgeFN023002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 11:42:40 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5MGgeKn005638
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 11:42:40 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5MGgd7Z012136
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 11:42:39 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

PRCM interrupts are now handled with the chained handler mechanism. This patch
also changes the PRCM interrupts to be of one-shot type, and the interrupt
does not clear the wakeup statuses anymore. Clearing of the wakeup interrupts
is done just before entering idle, as we probably have more time to do this
during this time. Changing the wakeup handling logic also fixes an issue
with the chained PRCM serial interrupts, that prevents clearing of the
UART wakeup status and hangs the device.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index adab4d5..ff0811a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -90,6 +90,7 @@ static int (*_omap_save_secure_sram)(u32 *addr);
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
 static struct powerdomain *cam_pwrdm;
+static int wkup_event, io_event;
 
 static inline void omap3_per_save_context(void)
 {
@@ -242,20 +243,18 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
 
 static irqreturn_t _prcm_int_handle_wakeup(int irq, void *unused)
 {
-	int c;
+	return IRQ_HANDLED;
+}
 
-	c = prcm_clear_mod_irqs(WKUP_MOD, 1);
-	c += prcm_clear_mod_irqs(CORE_MOD, 1);
-	c += prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1);
+static void prcm_clear_wakeups(void)
+{
+	prcm_clear_mod_irqs(WKUP_MOD, 1);
+	prcm_clear_mod_irqs(CORE_MOD, 1);
+	prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1);
 	if (omap_rev() > OMAP3430_REV_ES1_0) {
-		c += prcm_clear_mod_irqs(CORE_MOD, 3);
-		c += prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
+		prcm_clear_mod_irqs(CORE_MOD, 3);
+		prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
 	}
-
-	if (c)
-		return IRQ_HANDLED;
-	else
-		return IRQ_NONE;
 }
 
 /* Function to restore the table entry that was modified for enabling MMU */
@@ -301,6 +300,10 @@ void omap_sram_idle(void)
 	if (!_omap_sram_idle)
 		return;
 
+	prcm_clear_wakeups();
+	omap3_prcm_unmask_event(wkup_event);
+	omap3_prcm_unmask_event(io_event);
+
 	pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
 	pwrdm_clear_all_prev_pwrst(neon_pwrdm);
 	pwrdm_clear_all_prev_pwrst(core_pwrdm);
@@ -832,17 +835,19 @@ static int __init omap3_pm_init(void)
 		goto err_prcm_irq_init;
 	}
 
+	wkup_event = omap_prcm_event_to_id("wkup");
 	ret = request_irq(omap_prcm_event_to_irq("wkup"),
 			  _prcm_int_handle_wakeup,
-			  IRQF_NO_SUSPEND, "prcm_wkup", NULL);
+			  IRQF_NO_SUSPEND | IRQF_ONESHOT, "prcm_wkup", NULL);
 	if (ret) {
 		pr_err("request_irq failed to register for PRCM wakeup\n");
 		goto err_prcm_irq_wkup;
 	}
 
+	io_event = omap_prcm_event_to_id("io");
 	ret = request_irq(omap_prcm_event_to_irq("io"),
 			  _prcm_int_handle_wakeup,
-			  IRQF_NO_SUSPEND, "prcm_io", NULL);
+			  IRQF_NO_SUSPEND | IRQF_ONESHOT, "prcm_io", NULL);
 	if (ret) {
 		pr_err("request_irq failed to register for PRCM io\n");
 		goto err_prcm_irq_io;
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

