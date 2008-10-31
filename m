From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM: OMAP3: Print debug info on spurious interrupts
Date: Fri, 31 Oct 2008 13:55:52 -0700
Message-ID: <20081031205552.GD28924@atomide.com>
References: <1225480873-30835-1-git-send-email-tony@atomide.com> <1225480873-30835-2-git-send-email-tony@atomide.com> <1225480873-30835-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53916 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbYJaUzy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 16:55:54 -0400
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1Kw129-0005If-Eh
	for linux-omap@vger.kernel.org; Fri, 31 Oct 2008 20:55:53 +0000
Content-Disposition: inline
In-Reply-To: <1225480873-30835-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [081031 12:21]:
> In the case of spurious interrupt, the handler for previous irq most likely
> needs a read back of some register to ensure write posting.

Here's a better version to kill the checkpatch.pl warning. Later on we
might want to add also a check for "irq == 95" to the test in
omap_mask_irq() so we can keep this patch around with minimal overhead.

Tony

--Qxx1br4bt0+wmkIi
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="irq-debug-v2.patch"

>From 7410bd58cbf8b9d60a7b368a73b34fe03cdaa086 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 31 Oct 2008 12:01:25 -0700
Subject: [PATCH] ARM: OMAP3: Print debug info on spurious interrupts

In the case of spurious interrupt, the handler for previous irq most likely
needs to flush posted writes with a read back of the interrupt ack register.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 68aff9a..07aa0f5 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -23,6 +23,7 @@
 #define INTC_REVISION		0x0000
 #define INTC_SYSCONFIG		0x0010
 #define INTC_SYSSTATUS		0x0014
+#define INTC_SIR		0x0040
 #define INTC_CONTROL		0x0048
 #define INTC_MIR_CLEAR0		0x0088
 #define INTC_MIR_SET0		0x008c
@@ -60,6 +61,25 @@ static u32 intc_bank_read_reg(struct omap_irq_bank *bank, u16 reg)
 	return __raw_readl(bank->base_reg + reg);
 }
 
+static int previous_irq;
+
+static int omap_check_spurious(unsigned int irq)
+{
+	u32 sir, spurious;
+
+	sir = intc_bank_read_reg(&irq_banks[0], INTC_SIR);
+	spurious = sir >> 6;
+
+	if (spurious > 1) {
+		printk(KERN_WARNING "Spurious irq %i: 0x%08x, please flush "
+					"posted write for irq %i\n",
+					irq, sir, previous_irq);
+		return spurious;
+	}
+
+	return 0;
+}
+
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */
 static void omap_ack_irq(unsigned int irq)
 {
@@ -70,6 +90,9 @@ static void omap_mask_irq(unsigned int irq)
 {
 	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
 
+	if (cpu_is_omap34xx() && !omap_check_spurious(irq))
+		previous_irq = irq;
+
 	irq &= (IRQ_BITS_PER_REG - 1);
 
 	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);

--Qxx1br4bt0+wmkIi--
