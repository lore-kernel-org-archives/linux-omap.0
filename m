From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 02/13] OMAP3: PM: Ack pending interrupts before entering suspend
Date: Fri,  8 Jan 2010 09:59:20 -0800
Message-ID: <1262973571-25796-3-git-send-email-khilman@deeprootsystems.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:63991 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab0AHR7i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:59:38 -0500
Received: by pzk1 with SMTP id 1so3897390pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 09:59:38 -0800 (PST)
In-Reply-To: <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Suspending drivers may still generate interrupts just before their suspend is
completed. Any pending interrupts here will prevent sleep.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/irq.c              |    6 ++++++
 arch/arm/mach-omap2/pm34xx.c           |    2 ++
 arch/arm/plat-omap/include/plat/irqs.h |    1 +
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index e9bc782..54c5f0d 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -274,4 +274,10 @@ void omap_intc_restore_context(void)
 	}
 	/* MIRs are saved and restore with other PRCM registers */
 }
+
+void omap3_intc_suspend(void)
+{
+	/* A pending interrupt would prevent OMAP from entering suspend */
+	omap_ack_irq(0);
+}
 #endif /* CONFIG_ARCH_OMAP3 */
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c6cc809..b26418d 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -578,6 +578,8 @@ static int omap3_pm_suspend(void)
 	}
 
 	omap_uart_prepare_suspend();
+	omap3_intc_suspend();
+
 	omap_sram_idle();
 
 restore:
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 97d6c50..0082036 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -499,6 +499,7 @@ extern void omap_init_irq(void);
 extern int omap_irq_pending(void);
 void omap_intc_save_context(void);
 void omap_intc_restore_context(void);
+void omap3_intc_suspend(void);
 #endif
 
 #include <mach/hardware.h>
-- 
1.6.6.rc2.1.g42108

