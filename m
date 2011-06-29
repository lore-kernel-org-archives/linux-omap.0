From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 9/9] OMAP3: PM: Disable / enable PRCM chain interrupts during wakeup from suspend
Date: Wed, 29 Jun 2011 12:05:03 +0300
Message-ID: <1309338303-2086-10-git-send-email-t-kristo@ti.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48937 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab1F2JFV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 05:05:21 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5T95LH7030703
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:21 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep35.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5T95LMe001822
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:21 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5T95KNr009264
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:20 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This prevents system hang while attempting to access suspended console.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e626a3d..dae0a8a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -418,6 +418,10 @@ void omap_sram_idle(void)
 	pwrdm_post_transition();
 
 	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
+	if (suspend_state != PM_SUSPEND_ON) {
+		disable_irq(prcm_io_irq);
+		disable_irq(prcm_wkup_irq);
+	}
 }
 
 int omap3_can_sleep(void)
@@ -524,6 +528,8 @@ static void omap3_pm_end(void)
 	suspend_state = PM_SUSPEND_ON;
 	omap_uart_enable_irqs(1);
 	enable_hlt();
+	enable_irq(prcm_io_irq);
+	enable_irq(prcm_wkup_irq);
 	return;
 }
 
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

