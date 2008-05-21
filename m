From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] IRQ: simplify OMAP2 mask_irq/unmask_irq code
Date: Tue, 20 May 2008 18:12:04 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0805201802040.9463@utopia.booyaka.com>
References: <alpine.DEB.1.00.0805201220090.9463@utopia.booyaka.com> <9c9fda240805201618y43d65160h246ea69a43785515@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43722 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbYEUAMI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 20:12:08 -0400
In-Reply-To: <9c9fda240805201618y43d65160h246ea69a43785515@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-omap@vger.kernel.org, lethal@linux-sh.org

Hello Kyungmin,

On Wed, 21 May 2008, Kyungmin Park wrote:

> On Wed, May 21, 2008 at 3:21 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> >  static void omap_mask_irq(unsigned int irq)
> >  {
> > -       int offset = (irq >> 5) << 5;
> > +       int offset = irq & (~(IRQ_BITS_PER_REG - 1));
> >
> > -       if (irq >= 64)
> > -               irq %= 64;
> > -       else if (irq >= 32)
> > -               irq %= 32;
> > +       irq %= IRQ_BITS_PER_REG;
> 
> Is it the right conversion?
> If the irq is greater then 32 and less then or equal to  64 it's
> result is different.
> E.g, If irq is 63 then original irq is 63, but new code is 31

Hmm, in that condition, the result looks the same to me: irq % 32, either 
way?

More practically, if you look at what it does with that irq variable 
afterwards, it seems to be a bug if irq is ever greater than 31:

        intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_CLEAR0 + 
                            offset);

I think the only case where the new code would work differently than the 
previous code is if irq > 95.  But that would be a bug, since the shift 
value would then be > 32, for a 32-bit register.

> And if this code is right, how about to use mask instead of modulo op?
> irq &= (IRQ_BITS_PER_REG - 1);

Hehe, very good point, that would probably save even more cycles!  If you 
agree with the above, perhaps I can convert the code to use that also, 
and add your Signed-off-by also?


- Paul
