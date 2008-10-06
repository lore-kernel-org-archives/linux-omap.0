From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.27-rc8-omap 0/7] resend of pending TWL patches
Date: Mon, 6 Oct 2008 09:41:20 +0300
Message-ID: <20081006064120.GC14042@atomide.com>
References: <200810030857.37888.david-b@pacbell.net> <57969b5c0810031036q55075fdbw259159757f25c863@mail.gmail.com> <57969b5c0810031038w34f02dafxbc664f58cf5965ba@mail.gmail.com> <200810031959.16276.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49840 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbYJFGiY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 02:38:24 -0400
Content-Disposition: inline
In-Reply-To: <200810031959.16276.marek.vasut@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Anand Gadiyar <gadiyar@gmail.com>, David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

* Marek Vasut <marek.vasut@gmail.com> [081003 20:54]:
> On Friday 03 of October 2008 19:38:51 Anand Gadiyar wrote:
> That's nothing new in David's case ;-) (dont consider this an insult)
> 
> > (Hit reply instead of reply-all... Reminder to self. Never send emails
> > when you're sleepy)
> >
> > On Fri, Oct 3, 2008 at 11:06 PM, Anand Gadiyar <gadiyar@gmail.com> wrote:
> > > On Fri, Oct 3, 2008 at 10:12 PM, David Brownell <david-b@pacbell.net> 
> wrote:
> > >> On Friday 03 October 2008, David Brownell wrote:
> > >>> This flushes my queue of TWL (and related) patches that
> > >>> seem ready to merge:
> > >>
> > >> Sanity tested on Beagle, FYI.

Pushed all seven patches to l-o.

Tony


> > >>
> > >> Where I observed a new oddity:  the boot hung right after
> > >> listing the MTD partitions.  Which is where the EHCI code
> > >> would come up ... took that driver out of the build, and
> > >> the hang went away.  Clue, oh clue; where art thou?
> > >
> > > Well... Any chance this bit of code here helps? This infinite loop
> > > shouldn't even have been here. Oh well.
> > >
> > >
> > > ====CUT_HERE=====
> > > Remove infinite loop in DPLL 5 programming. Ideally, DPLL5 should be
> > > taken care of by the clock framework.
> > > ---
> > >  drivers/usb/host/ehci-omap.c |    2 ++
> > >  1 files changed, 2 insertions(+)
> > >
> > > Index: linux-omap-2.6/drivers/usb/host/ehci-omap.c
> > > ===================================================================
> > > --- linux-omap-2.6.orig/drivers/usb/host/ehci-omap.c    2008-09-18
> > > 14:59:34.000000000 +0530
> > > +++ linux-omap-2.6/drivers/usb/host/ehci-omap.c 2008-09-18
> > > 15:00:09.737475758 +0530
> > > @@ -170,10 +170,12 @@ static int omap_start_ehc(struct platfor
> > >                        (7 << OMAP3430ES2_EN_PERIPH2_DPLL_SHIFT),
> > >                        PLL_MOD, OMAP3430ES2_CM_CLKEN2);
> > >
> > > +#if 0
> > >        while (!(cm_read_mod_reg(PLL_MOD, CM_IDLEST2) &
> > >                                OMAP3430ES2_ST_PERIPH2_CLK_MASK))
> > >                dev_dbg(hcd->self.controller, "idlest2 = 0x%x\n",
> > >                        cm_read_mod_reg(PLL_MOD, CM_IDLEST2));
> > > +#endif
> > >        /* End DPLL5 programming */
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
