From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/9] ARM: OMAP: Mask interrupts when disabling
	interrupts, v2
Date: Wed, 28 Jan 2009 11:07:01 -0800
Message-ID: <20090128190700.GT32148@atomide.com>
References: <20090128181931.21007.73744.stgit@localhost> <20090128183209.21007.86828.stgit@localhost> <20090128185827.GD23301@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49845 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbZA1THJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 14:07:09 -0500
Content-Disposition: inline
In-Reply-To: <20090128185827.GD23301@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Kim Kyuwon <chammoru@gmail.com>, linux-omap@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090128 11:00]:
> On Wed, Jan 28, 2009 at 10:32:09AM -0800, Tony Lindgren wrote:
> > From: 김규원 <chammoru@gmail.com>
> > 
> > By Ingo Molnar, interrupts are not masked by default.
> > (refer to 76d2160147f43f982dfe881404cfde9fd0a9da21)
> > 
> > But if interrupts are not masked, the processor can wake up while in
> > Suspend-to-RAM state by an external interrupt. For example, if an
> > OMAP3 board is connected to Host PC by USB and entered to Suspend-to-RAM
> > state, it wake up automatically by M_IRQ_92. The disable_irq() function
> > can't disable the interrupt in H/W level, So I modified
> > arch/arm/mach-omap2/irq.c
> > 
> > Signed-off-by: Kim Kyuwon <chammoru@gmail.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/irq.c |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> > index 636e282..52772f9 100644
> > --- a/arch/arm/mach-omap2/irq.c
> > +++ b/arch/arm/mach-omap2/irq.c
> > @@ -123,6 +123,11 @@ static void omap_unmask_irq(unsigned int irq)
> >  	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_CLEAR0 + offset);
> >  }
> >  
> > +static void omap_disable_irq(unsigned int irq)
> > +{
> > +	omap_mask_irq(irq);
> > +}
> > +
> >  static void omap_mask_ack_irq(unsigned int irq)
> >  {
> >  	omap_mask_irq(irq);
> > @@ -134,6 +139,7 @@ static struct irq_chip omap_irq_chip = {
> >  	.ack	= omap_mask_ack_irq,
> >  	.mask	= omap_mask_irq,
> >  	.unmask	= omap_unmask_irq,
> > +	.disable = omap_disable_irq,
> 
> There's no need for the indirection - omap_mask_irq() already has the
> required prototype for the .disable function.  So this patch should just
> be adding:
> 
> 	.disable = omap_mask_irq,

OK, here's the updated patch.

Tony

--PEIAKu/WMn1b1Hv9
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="disable-irq-v2.patch"

>From 12db1a5a7e0de12b643c2666f95f4840942aad49 Mon Sep 17 00:00:00 2001
From: =?utf-8?q?=EA=B9=80=EA=B7=9C=EC=9B=90?= <chammoru@gmail.com>
Date: Tue, 27 Jan 2009 12:58:16 -0800
Subject: [PATCH] ARM: OMAP: Mask interrupts when disabling interrupts, v2

By Ingo Molnar, interrupts are not masked by default.
(refer to 76d2160147f43f982dfe881404cfde9fd0a9da21)

But if interrupts are not masked, the processor can wake up while in
Suspend-to-RAM state by an external interrupt. For example, if an
OMAP3 board is connected to Host PC by USB and entered to Suspend-to-RAM
state, it wake up automatically by M_IRQ_92. The disable_irq() function
can't disable the interrupt in H/W level, So I modified
arch/arm/mach-omap2/irq.c

Signed-off-by: Kim Kyuwon <chammoru@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 636e282..9ba20d9 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -134,6 +134,7 @@ static struct irq_chip omap_irq_chip = {
 	.ack	= omap_mask_ack_irq,
 	.mask	= omap_mask_irq,
 	.unmask	= omap_unmask_irq,
+	.disable = omap_mask_irq,
 };
 
 static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)

--PEIAKu/WMn1b1Hv9--
