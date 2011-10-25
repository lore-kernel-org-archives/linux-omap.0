From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: remove NR_IRQS dependency for ARM-specific HARDIRQ_BITS definition
Date: Tue, 25 Oct 2011 13:25:48 +0200
Message-ID: <1319541948-10035-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:47025 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754493Ab1JYLZ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Oct 2011 07:25:56 -0400
Received: by mail-ey0-f180.google.com with SMTP id 5so406970eyg.39
        for <linux-omap@vger.kernel.org>; Tue, 25 Oct 2011 04:25:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

As a first step towards removing NR_IRQS, remove the ARM customization
of HARDIRQ_BITS based on NR_IRQS.

The generic code in <linux/hardirq.h> already has a default value of
10 for HARDIRQ_BITS which is the max used on ARM, so let's just remove
the NR_IRQS based customization and use the generic default.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/include/asm/hardirq.h |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 89ad180..96cb097 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -30,23 +30,6 @@ u64 smp_irq_stat_cpu(unsigned int cpu);
 
 #define arch_irq_stat_cpu	smp_irq_stat_cpu
 
-#if NR_IRQS > 512
-#define HARDIRQ_BITS	10
-#elif NR_IRQS > 256
-#define HARDIRQ_BITS	9
-#else
-#define HARDIRQ_BITS	8
-#endif
-
-/*
- * The hardirq mask has to be large enough to have space
- * for potentially all IRQ sources in the system nesting
- * on a single CPU:
- */
-#if (1 << HARDIRQ_BITS) < NR_IRQS
-# error HARDIRQ_BITS is too low!
-#endif
-
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
 #endif /* __ASM_HARDIRQ_H */
-- 
1.7.3.4

