From: Tony Lindgren <tony@atomide.com>
Subject: Re: omapfb: help from userspace
Date: Thu, 16 Oct 2008 13:57:43 -0700
Message-ID: <20081016205743.GS15820@atomide.com>
References: <e5e6ade50810081136n2067600csf3c77195da0ef110@mail.gmail.com> <e5e6ade50810081321h6f638cafjbe00f4c8a3a50f2c@mail.gmail.com> <13B9B4C6EF24D648824FF11BE89671620365B58844@dlee02.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301B0108CAB@dbde02.ent.ti.com> <20081009124357.GF26230@atomide.com> <e5e6ade50810091055se7af4aasc404eb92f176dfeb@mail.gmail.com> <alpine.DEB.2.00.0810150556140.14740@utopia.booyaka.com> <e5e6ade50810152349x38b6f5e2oe59780cc2008c837@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5/uDoXvLw7AC5HRs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60644 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbYJPU5s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 16:57:48 -0400
Content-Disposition: inline
In-Reply-To: <e5e6ade50810152349x38b6f5e2oe59780cc2008c837@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, "TK, Pratheesh Gangadhar" <pratheesh@ti.com>, Rick Bronson <rick@efn.org>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Nathan Monson <nmonson@gmail.com> [081016 07:52]:
> On Wed, Oct 15, 2008 at 4:57 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > Hi Nathan,
> >
> > could you try Lauri's patch posted here:
> > http://marc.info/?l=linux-omap&m=122407150608770&w=2
> > without the strongly-ordered memory patches?
> 
> This patch works for my DSP test case.
> 
> I receive 10-20 kernel messages per second as follows:
> irq -33, desc: c0414580, depth: 0, count: 0, unhandled: 0
> 
> However, DSP Bridge continues to function normally without errors.

Here's my patch to attempt to fix this issue, could you all give it a
try please? So far it has worked for me, I'd like to hear what Nathan's
dsp test case does!

Basically it's modified patch from Russell, except reading back the
revision register is not enough. Looks like we need to read back the
same register we're writing.

I guess the L3/L4 is finer grained than ARM memory attributes?

Regards,

Tony

--5/uDoXvLw7AC5HRs
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="write-posting.patch"

>From e708817b51069acf8a9bce20713243741981bd43 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 16 Oct 2008 10:52:51 -0700
Subject: [PATCH] ARM: OMAP: Read back the interrupt registers after write to ensure posting

On 34xx interrupts would occasionally get stuck in spurious interrupt
loop. Spurious interrupts are triggered on 34xx if the interrupt mask or
priority registers are changed while the interrupt is asserted, see
"10.5.4 MPU INTC Spurious Interrupt Handling" in the 34xx TRM.

TI's suggestion was to map L3 and L4 as strongly ordered, while Russell's
suggestion was to read back the revision register to ensure posting:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg02904.html

However, looks like reading back INTC_REVISION is not enough with L3 and L4
busses. We need to read back the same register as we're writing to ensure
it gets posted. See also "7.3 Memory attributes" in Cortex-A8 TRM.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 4ffb4f1..facf886 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -64,6 +64,7 @@ static u32 intc_bank_read_reg(struct omap_irq_bank *bank, u16 reg)
 static void omap_ack_irq(unsigned int irq)
 {
 	intc_bank_write_reg(0x1, &irq_banks[0], INTC_CONTROL);
+	intc_bank_read_reg(&irq_banks[0], INTC_CONTROL);
 }
 
 static void omap_mask_irq(unsigned int irq)
@@ -73,6 +74,7 @@ static void omap_mask_irq(unsigned int irq)
 	irq &= (IRQ_BITS_PER_REG - 1);
 
 	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);
+	intc_bank_read_reg(&irq_banks[0], INTC_MIR_SET0 + offset);
 }
 
 static void omap_unmask_irq(unsigned int irq)

--5/uDoXvLw7AC5HRs--
