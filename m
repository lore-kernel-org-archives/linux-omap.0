From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2/3/4: DMA: reset controller during init
Date: Tue, 11 May 2010 08:13:12 -0700
Message-ID: <87632ueak7.fsf@deeprootsystems.com>
References: <1272891357-27400-1-git-send-email-ext-mika.1.westerberg@nokia.com>
	<20100503165817.GR29604@atomide.com>
	<20100504074006.GK12682@esdhcp04058.research.nokia.com>
	<20100511092731.GG11783@esdhcp04058.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48645 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756452Ab0EKPNP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 11:13:15 -0400
Received: by pva18 with SMTP id 18so27249pva.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 08:13:14 -0700 (PDT)
In-Reply-To: <20100511092731.GG11783@esdhcp04058.research.nokia.com> (Mika Westerberg's message of "Tue\, 11 May 2010 12\:27\:31 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:

> On Tue, May 04, 2010 at 10:40:06AM +0300, Mika Westerberg wrote:
>> On Mon, May 03, 2010 at 06:58:18PM +0200, ext Tony Lindgren wrote:
>> > * Mika Westerberg <ext-mika.1.westerberg@nokia.com> [100503 05:52]:
>> (...)
>> > > +/**
>> > > + * omap_dma_reset() - perform software reset for the DMA controller
>> > > + */
>> > > +static void omap_dma_reset(void)
>> > > +{
>> > > +	u32 v;
>> > > +
>> > > +	if (cpu_class_is_omap1())
>> > > +		return;
>> > > +
>> > > +	v = dma_read(OCP_SYSCONFIG);
>> > > +	v |= 0x2; /* software reset */
>> > > +	dma_write(v, OCP_SYSCONFIG);
>> > > +
>> > > +	/* wait until reset is complete */
>> > > +	while ((dma_read(SYSSTATUS) & 0x1) == 0)
>> > > +		cpu_relax();
>> > 
>> > This reset part seems to be mach-omap2 specific.
>> > 
>> > > +	/* disable per channel interrupts */
>> > > +	dma_write(0, IRQENABLE_L0);
>> > > +	dma_write(0, IRQENABLE_L1);
>> > > +	dma_write(0, IRQENABLE_L2);
>> > > +	dma_write(0, IRQENABLE_L3);
>> > > +}
>> > 
>> > For a minimal fix, how about just disable the interrupt in omap_clear_dma()?
>> > We are already calling that from omap_init_dma().
>> 
>> If we do it in omap_clear_dma() then omap_dma_global_context_restore() will
>> return with interrupts masked which probably breaks things.
>> 
>> How about something like following patch?
>
> Tony, Kevin
>
> Any comments on this patch?

Looks good to me.

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

