From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3 clock: Access only available clock bits
Date: Mon, 23 Mar 2009 00:40:27 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903230039300.4676@utopia.booyaka.com>
References: <4d34a0a70903192015j4ea44b1fn4f7bb045da32d218@mail.gmail.com>  <alpine.DEB.2.00.0903201523220.4676@utopia.booyaka.com> <4d34a0a70903221823o40bcc347y433447664571c2c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52655 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbZCWGkc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 02:40:32 -0400
In-Reply-To: <4d34a0a70903221823o40bcc347y433447664571c2c6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: OMAP <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, kyungmin.park@samsung.com, Tony Lindgren <tony@atomide.com>, bhmin@samsung.com

On Mon, 23 Mar 2009, Kim Kyuwon wrote:

> On Sat, Mar 21, 2009 at 6:48 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Fri, 20 Mar 2009, Kim Kyuwon wrote:
> >
> >> I found a problem on PM Branch with OMAP3430 ES3.1 Board when enabling
> >> OMAP_RESET_CLOCKS feature.
> >> In clk_disable_unsed() function, as soon as sad2d_ick is disabled,
> >> prcm interrupt is generated and its handler can't exit loop at next
> >> statement!
> >>
> >> while (prm_read_mod_reg(OCP_MOD, OMAP2_PRM_IRQSTATUS_MPU_OFFSET));
> >
> > We encountered a similar problem a few months ago.  The problem is
> > probably the pad mux settings on the d2d_mstdby and d2d_swakeup pads.
> > These are usually configured by the bootloader.  My recollection is that
> > they should be pulled up, but I don't recall for sure.  Yes, we should
> > have a patch in the PM branch to at least detect whether these pads are
> > configured incorrectly...
> 
> Thank you for letting me know the better solution. I confirmed that
> this problem can be fixed by configuring the d2d_mstdby and
> d2d_swakeup pads. (As you said, swakeup -> pulled down & mstdby ->
> pulled up.)

Great, thanks for the confirmation.


- Paul
