From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 02/10] ARM: OMAP3+: voltage: add support for
 voltagedomain usecounts
Date: Tue, 25 Sep 2012 15:02:35 +0300
Message-ID: <1348574555.10702.298.camel@sokoban>
References: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
	 <1348565565-14744-3-git-send-email-t-kristo@ti.com>
	 <20120925094100.GK31374@n2100.arm.linux.org.uk>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52759 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755226Ab2IYMCs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 08:02:48 -0400
In-Reply-To: <20120925094100.GK31374@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, 2012-09-25 at 10:41 +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 25, 2012 at 12:32:37PM +0300, Tero Kristo wrote:
> > diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> > index ba49029..ca54aec 100644
> > --- a/arch/arm/mach-omap2/powerdomain.c
> > +++ b/arch/arm/mach-omap2/powerdomain.c
> > @@ -1475,10 +1477,16 @@ int pwrdm_state_switch(struct powerdomain *pwrdm)
> >   */
> >  void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
> >  {
> > +	unsigned long flags;
> > +
> >  	if (!pwrdm)
> >  		return;
> >  
> > -	atomic_inc(&pwrdm->usecount);
> > +	if (atomic_inc_return(&pwrdm->usecount) == 1) {
> > +		spin_lock_irqsave(&pwrdm->lock, flags);
> > +		voltdm_pwrdm_enable(pwrdm->voltdm.ptr);
> > +		spin_unlock_irqrestore(&pwrdm->lock, flags);
> > +	}
> 
> This looks like the classic "I like atomic types because they have magic
> properties" brain-deadness.

Hi Russell,

Thats a good catch, I was actually thinking about this sequence myself
also, but decided to leave it as is here due to similarity with the
existing code in mach-omap2/clockdomain.c, see e.g.
_clkdm_clk_hwmod_enable. Maybe those parts should be fixed also...?

> 
> What would happen to users of this if you had this sequence:
> 
> pwrdm->usecount starts off as 1.
> 
> Thread0				Thread1
> atomic_inc_return() (returns 1)
> 				atomic_inc_return() (returns 2)
> 				starts using stuff in power domain
> spin_lock_irqsave()
> voltdm_pwrdm_enable()
> spin_unlock_irqrestore()
> 
> ?

That as such wouldn't break anything, as the callback isn't doing
anything too critical, but yes, for the sequencing of events it is bad.
The alternate implementation I was thinking was to drop the atomic_t and
just use an int for the usecount, and protect the usecount also with the
spinlock. However, there might be some performance issues if this is
done (but I think it is actually better than having some rather
mysterious bugs instead.)

-Tero


