From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFT/RFC/PATCH 00/31] arm: omap: irq: cleanup INTC driver
Date: Tue, 15 Jul 2014 02:14:35 -0700
Message-ID: <20140715091435.GB28715@atomide.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
 <20131219184815.GU27438@atomide.com>
 <20131219232153.GE707@saruman.home>
 <20131221005309.GH26054@atomide.com>
 <20131223173409.GA10536@saruman.home>
 <20140102220101.GA8652@saruman.home>
 <52C6A939.70708@ti.com>
 <20140103164055.GA18722@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20857 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758082AbaGOJQD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jul 2014 05:16:03 -0400
Content-Disposition: inline
In-Reply-To: <20140103164055.GA18722@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [140103 08:43]:
> On Fri, Jan 03, 2014 at 05:42:41PM +0530, Rajendra Nayak wrote:
> > []..
> > 
> > >>> so a bit more work is needed. Maybe also rebase these against
> > >>> omap-for-v3.14/dt too?
> > >>
> > >> Will do.
> > > 
> > > Rebased on top of omap-for-v3.14/omap3-board-removal. Patches are on my
> > > k.org tree:
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git wip/omap-fix-intc
> > 
> > It needs a minor build fix though..
> > 
> > diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
> > index b58c5d5..d03b5a3 100644
> > --- a/drivers/irqchip/irq-omap-intc.c
> > +++ b/drivers/irqchip/irq-omap-intc.c
> > @@ -151,7 +151,7 @@ static void omap_mask_ack_irq(struct irq_data *d)
> >  static void omap_suspend_irq(struct irq_data *d)
> >  {
> >         omap_intc_save_context();
> > -       omap3_intc_prepare_idle();
> > +       omap_intc_prepare_idle();
> 
> fixed now, thanks. Wonder how come I didn't see that, I was building
> every commit with omap2plus_defconfig :-( Oh well...

Felipe, care to refresh this series against v3.16-rc4 and
repost? We now finally have the DT based booting working for
PM for omap3 the same way as legacy booting so I can test
this easily for regressions. But I don't seem to have the
patches in my mailbox any longer.

Regards,

Tony
