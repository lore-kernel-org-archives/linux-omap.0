From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2] ARM: OMAP2+: wakeupgen: AM43x adaptation
Date: Wed, 9 Oct 2013 12:42:33 +0530
Message-ID: <1381302753-7045-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47751 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756441Ab3JIHNA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 03:13:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>

AM43x has 224 interrupts and 7 banks, make it as maximum values. Keep
default values as earlier, if am43x is detected, update interrupts and
banks accordingly.

Also AM43x has only one cpu, ensure that clearing bitmask at wakeupgen
is done only for the single existing cpu, existing code assumes that
there are two cpu's.

If bitmask is cleared in wakeupgen for the nonexistent second cpu,
an imprecise abort happens as soon as Kernel switches to user space.
It was rootcaused by Sekhar Nori <nsekhar@ti.com>.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

v2:
1. make AM43x adaptation such that changes required for new SoC addition is less
2. avoid usage of am43x local variable, use soc_is_am43xx() instead

 arch/arm/mach-omap2/omap-wakeupgen.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 813c615..3664562 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -33,8 +33,12 @@
 #include "omap4-sar-layout.h"
 #include "common.h"
 
-#define MAX_NR_REG_BANKS	5
-#define MAX_IRQS		160
+#define AM43XX_NR_REG_BANKS	7
+#define AM43XX_IRQS		224
+#define MAX_NR_REG_BANKS	AM43XX_NR_REG_BANKS
+#define MAX_IRQS		AM43XX_IRQS
+#define DEFAULT_NR_REG_BANKS	5
+#define DEFAULT_IRQS		160
 #define WKG_MASK_ALL		0x00000000
 #define WKG_UNMASK_ALL		0xffffffff
 #define CPU_ENA_OFFSET		0x400
@@ -47,8 +51,8 @@ static void __iomem *wakeupgen_base;
 static void __iomem *sar_base;
 static DEFINE_RAW_SPINLOCK(wakeupgen_lock);
 static unsigned int irq_target_cpu[MAX_IRQS];
-static unsigned int irq_banks = MAX_NR_REG_BANKS;
-static unsigned int max_irqs = MAX_IRQS;
+static unsigned int irq_banks = DEFAULT_NR_REG_BANKS;
+static unsigned int max_irqs = DEFAULT_IRQS;
 static unsigned int omap_secure_apis;
 
 /*
@@ -418,12 +422,16 @@ int __init omap_wakeupgen_init(void)
 		irq_banks = OMAP4_NR_BANKS;
 		max_irqs = OMAP4_NR_IRQS;
 		omap_secure_apis = 1;
+	} else if (soc_is_am43xx()) {
+		irq_banks = AM43XX_NR_REG_BANKS;
+		max_irqs = AM43XX_IRQS;
 	}
 
 	/* Clear all IRQ bitmasks at wakeupGen level */
 	for (i = 0; i < irq_banks; i++) {
 		wakeupgen_writel(0, i, CPU0_ID);
-		wakeupgen_writel(0, i, CPU1_ID);
+		if (!soc_is_am43xx())
+			wakeupgen_writel(0, i, CPU1_ID);
 	}
 
 	/*
-- 
1.8.3.4

