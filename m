From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/17] ARM: OMAP2+: Make INTCPS_NR_IRQS local for
 mach-omap2/irq.c
Date: Mon, 10 Sep 2012 22:30:47 -0700
Message-ID: <20120911053047.29637.77771.stgit@muffinssi.local>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47933 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751636Ab2IKFas (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 01:30:48 -0400
In-Reply-To: <20120911052934.29637.9190.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Make INTCPS_NR_IRQS local for mach-omap2/irq.c

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/irq.c              |    2 ++
 arch/arm/plat-omap/include/plat/irqs.h |    3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index bcd83db..ac59f96 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -49,6 +49,8 @@
 #define OMAP3_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
 #define INTCPS_SIR_IRQ_OFFSET	0x0040	/* omap2/3 active interrupt offset */
 #define ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
+#define INTCPS_NR_MIR_REGS	3
+#define INTCPS_NR_IRQS		96
 
 /*
  * OMAP2 has a number of different interrupt controllers, each interrupt
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 15f497c..fc3959c 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -440,9 +440,6 @@
 
 #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
 
-#define INTCPS_NR_MIR_REGS	3
-#define INTCPS_NR_IRQS		96
-
 #include <mach/hardware.h>
 
 #ifdef CONFIG_FIQ

