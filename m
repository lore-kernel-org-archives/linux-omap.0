From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] ARM: OMAP2+: remove incorrect irq_chip ack field
Date: Sun,  6 May 2012 02:56:52 +0300
Message-ID: <1336262212-4455-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42624 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab2EEX47 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 May 2012 19:56:59 -0400
Received: by wgbdr13 with SMTP id dr13so3783998wgb.1
        for <linux-omap@vger.kernel.org>; Sat, 05 May 2012 16:56:58 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>

Each irq_chip for the main interrupt controller has offsets set for irq
masking registers, which added to respective base results in a pointer
to appropriate hardware register. However this is not correct for
INTC_CONTROL as there is only one INTC_CONTROL register. This does not
cause problems because generic ack code is never called, but remove
this assignment to avoid confusion.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/irq.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 65f0d25..c11e8a8 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -149,7 +149,6 @@ omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
 	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
 
-	ct->regs.ack = INTC_CONTROL;
 	ct->regs.enable = INTC_MIR_CLEAR0;
 	ct->regs.disable = INTC_MIR_SET0;
 	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
-- 
1.7.0.4

