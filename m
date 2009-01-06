From: "=?EUC-KR?B?seix1L/4?=" <chammoru@gmail.com>
Subject: Questions about masking interrupts when disabling interrupts
Date: Tue, 6 Jan 2009 11:59:42 +0900
Message-ID: <4d34a0a70901051859i792725b3t4563971070f886fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:27780 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbZAFC7o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jan 2009 21:59:44 -0500
Received: by wf-out-1314.google.com with SMTP id 27so7923128wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 05 Jan 2009 18:59:42 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, =?EUC-KR?B?x+O8urD8?= <sk.heo@samsung.com>

Greetings,

I'm enabling the Suspend-to-RAM state in our new OMAP3 Board.
But I had some problems because of USB Interrupt.

Although I disabled USB interrupt by disable_irq() function while
entering the Suspend,
M_IRQ_92 irq continuously wake up the OMAP3430 Processor.

So, I fixed this problem as following patch.

My Questions are:
1. Could anyone suggest the better solution for this problem?
2. If there is no better solution, can I be applied this patch to omap-tree?

Thank you!

commit bbb49321b161e6a9ff2b73326d4012d8eb8bbf23
Author: Kim Kyuwon <chammoru@gmail.com>
Date:   Tue Jan 6 10:11:46 2009 +0900

    ARM: OMAP3: Mask interrupts when disabling interrupts

    By Ingo Molnar, interrupts are not masked by default.
    (refer to 76d2160147f43f982dfe881404cfde9fd0a9da21)

    But if interrupts are not masked, the processor can wake up while in
    Suspend-to-RAM state by an external interrupt. For example, if an
OMAP3 board
    is connected to Host PC by USB and entered to Suspend-to-RAM
state, it wake up
    automatically by M_IRQ_92. The disable_irq() function can't disable the
    interrupt in H/W level, So I modified arch/arm/mach-omap2/irq.c

    Signed-off-by: Kim Kyuwon <chammoru@gmail.com>

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 110acb9..b44dcae 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -123,6 +123,11 @@ static void omap_unmask_irq(unsigned int irq)
 	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_CLEAR0 + offset);
 }

+static void omap_disable_irq(unsigned int irq)
+{
+	omap_mask_irq(irq);
+}
+
 static void omap_mask_ack_irq(unsigned int irq)
 {
 	omap_mask_irq(irq);
@@ -134,6 +139,7 @@ static struct irq_chip omap_irq_chip = {
 	.ack	= omap_mask_ack_irq,
 	.mask	= omap_mask_irq,
 	.unmask	= omap_unmask_irq,
+	.disable = omap_disable_irq,
 };

 static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
-- 
Kim Kyuwon
