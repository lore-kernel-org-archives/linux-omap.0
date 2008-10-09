From: Tony Lindgren <tony@atomide.com>
Subject: Re: omapfb: help from userspace
Date: Thu, 9 Oct 2008 15:43:58 +0300
Message-ID: <20081009124357.GF26230@atomide.com>
References: <e5e6ade50810081136n2067600csf3c77195da0ef110@mail.gmail.com> <e5e6ade50810081321h6f638cafjbe00f4c8a3a50f2c@mail.gmail.com> <13B9B4C6EF24D648824FF11BE89671620365B58844@dlee02.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301B0108CAB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PmA2V3Z32TCmWXqI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65224 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757555AbYJIMoE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 08:44:04 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301B0108CAB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, "TK, Pratheesh Gangadhar" <pratheesh@ti.com>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* TK, Pratheesh Gangadhar <pratheesh@ti.com> [081009 09:20]:
> >The need for this has been discussed on this list a few times in the past.  >Not having it is a bug to me for OMAP3.
> >
> >There shouldn't really be any performance side effects the way it is being >used.
> 
> I agree, I did not notice any performance impact - we are using this setting for couple of months now without any problem. But there are some future compatibility concerns in below thread - it should be fine for OMAP3 though 
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg02949.html
> 
> > Let's go back to having a strongly ordered memory model.  Please.
> 
> On pre-ARMv6, updates to CPSR are guaranteed to take place in program
> order with a strongly-ordered memory access. This is still true on
> ARMv6/v7 for backward compatibility but the feature is deprecated and it
> might not be true for future architecture versions. At some point
> barriers might be needed.

Nathan, good to hear that the SO mode helps. But since you seem to
have it easily reproducable..

Could you try the following patch based on RMK's earlier patch
without the strongly ordered patch and see if that makes any
difference?

If this patch alone does not do anything, maybe try reading back
something from the dsp interrupt registers after write also
in the dsp interrupt handler?

Also you might want to read through the thread linked in the
patch description.

And, if that still does not work, I'm suspecting that in some cases
write-read is not enough, and only write-write ensures that it gets
posted. Some ARM docs say that writes are only posted relative to
other writes, but I don't know if it can be really that way.

At least we have at least one hack like that in the
drivers/mmc/host/omap.c.

Anyways, it would be nice to solve this issue for good. The problem
has been making it easily reproducable.

Thanks,

Tony

--PmA2V3Z32TCmWXqI
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="irq-read.patch"

>From 5732ab12201cff25f036e1e20dc23fdb779c8589 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 9 Oct 2008 15:25:16 +0300
Subject: [PATCH] Read INTC_REVISION after write to ensure write is posted

Based on Russell's earlier patch at:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg02904.html

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 4ffb4f1..3ae3c8c 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -64,6 +64,7 @@ static u32 intc_bank_read_reg(struct omap_irq_bank *bank, u16 reg)
 static void omap_ack_irq(unsigned int irq)
 {
 	intc_bank_write_reg(0x1, &irq_banks[0], INTC_CONTROL);
+	intc_bank_read_reg(&irq_banks[0], INTC_REVISION);
 }
 
 static void omap_mask_irq(unsigned int irq)
@@ -73,6 +74,7 @@ static void omap_mask_irq(unsigned int irq)
 	irq &= (IRQ_BITS_PER_REG - 1);
 
 	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);
+	intc_bank_read_reg(&irq_banks[0], INTC_REVISION);
 }
 
 static void omap_unmask_irq(unsigned int irq)

--PmA2V3Z32TCmWXqI--
