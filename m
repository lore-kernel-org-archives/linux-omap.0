From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 09/17] OMAP3: PM: Ack pending interrupts before entering suspend
Date: Fri, 16 Oct 2009 13:49:02 +0300
Message-ID: <1255690150-16853-10-git-send-email-tero.kristo@nokia.com>
References: <>
 <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51342 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435AbZJPLE3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 07:04:29 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB2WH6001694
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:03:00 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB2fa3022261
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:02:53 +0300
In-Reply-To: <1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Suspending drivers may still generate interrupts just before their suspend is
completed. Any pending interrupts here will prevent sleep.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/irq.c              |    2 +-
 arch/arm/mach-omap2/pm34xx.c           |    2 ++
 arch/arm/plat-omap/include/mach/irqs.h |    1 +
 3 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index aceedd8..4ed05e9 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -101,7 +101,7 @@ static int omap_check_spurious(unsigned int irq)
 }
 
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */
-static void omap_ack_irq(unsigned int irq)
+void omap_ack_irq(unsigned int irq)
 {
 	intc_bank_write_reg(0x1, &irq_banks[0], INTC_CONTROL);
 }
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5854fa7..6a41811 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -778,6 +778,8 @@ static int omap3_pm_suspend(void)
 
 	omap_uart_prepare_suspend();
 
+	/* Ack pending IRQs, as a pending IRQ will cause the suspend to fail */
+	omap_ack_irq(0);
 	regset_save_on_suspend = 1;
 	omap_sram_idle();
 	regset_save_on_suspend = 0;
diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
index 2473910..d56be1c 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -483,6 +483,7 @@
 #ifndef __ASSEMBLY__
 extern void omap_init_irq(void);
 extern int omap_irq_pending(void);
+extern void omap_ack_irq(unsigned int irq);
 void omap3_intc_save_context(void);
 void omap3_intc_restore_context(void);
 #endif
-- 
1.5.4.3

