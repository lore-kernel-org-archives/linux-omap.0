From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-rc8-omap 0/7] resend of pending TWL patches
Date: Mon, 6 Oct 2008 16:26:33 -0700
Message-ID: <200810061626.33616.david-b@pacbell.net>
References: <200810030857.37888.david-b@pacbell.net> <57969b5c0810031036q55075fdbw259159757f25c863@mail.gmail.com> <57969b5c0810031038w34f02dafxbc664f58cf5965ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:23051 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757879AbYJFX0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 19:26:36 -0400
In-Reply-To: <57969b5c0810031038w34f02dafxbc664f58cf5965ba@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@gmail.com>
Cc: linux-omap@vger.kernel.org

> >> Where I observed a new oddity:  the boot hung right after
> >> listing the MTD partitions.  Which is where the EHCI code
> >> would come up ... took that driver out of the build, and
> >> the hang went away.  Clue, oh clue; where art thou?
> >>
> >
> > Well... Any chance this bit of code here helps? This infinite loop
> > shouldn't even have been here. Oh well.

Didn't help.  :(

This code has so many infinite loops for hardware handshaking
(none with timeouts!) that it's hard to say which one might
be causing this ... if indeed one of them is indeed the cause.


> > ====CUT_HERE=====
> > Remove infinite loop in DPLL 5 programming. Ideally, DPLL5 should be
> > taken care of by the clock framework.
> > ---
> >  drivers/usb/host/ehci-omap.c |    2 ++
> >  1 files changed, 2 insertions(+)
> >
> > Index: linux-omap-2.6/drivers/usb/host/ehci-omap.c
> > ===================================================================
> > --- linux-omap-2.6.orig/drivers/usb/host/ehci-omap.c    2008-09-18
> > 14:59:34.000000000 +0530
> > +++ linux-omap-2.6/drivers/usb/host/ehci-omap.c 2008-09-18
> > 15:00:09.737475758 +0530
> > @@ -170,10 +170,12 @@ static int omap_start_ehc(struct platfor
> >                        (7 << OMAP3430ES2_EN_PERIPH2_DPLL_SHIFT),
> >                        PLL_MOD, OMAP3430ES2_CM_CLKEN2);
> >
> > +#if 0
> >        while (!(cm_read_mod_reg(PLL_MOD, CM_IDLEST2) &
> >                                OMAP3430ES2_ST_PERIPH2_CLK_MASK))
> >                dev_dbg(hcd->self.controller, "idlest2 = 0x%x\n",
> >                        cm_read_mod_reg(PLL_MOD, CM_IDLEST2));
> > +#endif
> >        /* End DPLL5 programming */
> >
> 
> 


