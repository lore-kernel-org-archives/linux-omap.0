From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Resend][PATCH] Fix for the i2c initialization error on 2430sdp
Date: Tue, 10 Jun 2008 14:20:25 -0700
Message-ID: <20080610212025.GL23796@atomide.com>
References: <c656a4d20806082325u41572f75i980a9abc7a012d9e@mail.gmail.com> <a0580c510806090553v19362b88k4fd3a110450daed7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56215 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbYFJVU1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 17:20:27 -0400
Content-Disposition: inline
In-Reply-To: <a0580c510806090553v19362b88k4fd3a110450daed7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: arun c <arunedarath@mistralsolutions.com>, linux-omap@vger.kernel.org, Chandra shekhar <x0044955@ti.com>, Felipe Balbi <me@felipebalbi.com>

* Eduardo Valentin <edubezval@gmail.com> [080609 05:55]:
> On Mon, Jun 9, 2008 at 2:25 AM, arun c <arunedarath@mistralsolutions.com> wrote:
> > Hi all,
> >
> > Resending the patch after incorporating comments from
> > Chandra , Eduardo Valentin and Felipe.
> >
> > ########################################################
> >
> >
> > From ee2a6fd572c6d0464166fc8123982a38b36e7776 Mon Sep 17 00:00:00 2001
> > From: arun <arunedarath@mistralsolutions.com>
> > Date: Fri, 6 Jun 2008 18:18:50 +0530
> > Subject: [PATCH] Fix for the i2c initialization error on 2430sdp
> >
> >
> > Signed-off-by: arun <arunedarath@mistralsolutions.com>
> Acked-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

Pushing today.

Tony


> > ---
> >  arch/arm/mach-omap2/board-2430sdp.c |    6 +++++-
> >  1 files changed, 5 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-2430sdp.c
> > b/arch/arm/mach-omap2/board-2430sdp.c
> > index e078a2a..780913e 100644
> > --- a/arch/arm/mach-omap2/board-2430sdp.c
> > +++ b/arch/arm/mach-omap2/board-2430sdp.c
> > @@ -379,8 +379,12 @@ static struct omap_board_config_kernel
> > sdp2430_config[] __initdata = {
> >
> >  static int __init omap2430_i2c_init(void)
> >  {
> > -       omap_register_i2c_bus(1, 400, NULL, 0);
> > +       /*
> > +        * Registering bus 2 first to avoid twl4030 misbehaving as 2430SDP
> > +        * has twl4030 on bus 2
> > +        */
> >        omap_register_i2c_bus(2, 2600, NULL, 0);
> > +       omap_register_i2c_bus(1, 400, NULL, 0);
> >        return 0;
> >  }
> >
> > --
> > 1.5.3.4
> >
> > #################################################
> > Regards,
> > Arun C
> >
> 
> 
> 
> -- 
> Eduardo Bezerra Valentin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
