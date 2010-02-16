From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap3evm: Doesn't boot at 4fa42e46
Date: Tue, 16 Feb 2010 10:27:43 -0800
Message-ID: <20100216182743.GJ21755@atomide.com>
References: <4B7A5C9A.40404@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E5774225@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65374 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932771Ab0BPS0z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 13:26:55 -0500
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E5774225@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Lohithakshan, Ranjith" <ranjithl@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Premi, Sanjeev <premi@ti.com> [100216 01:35]:
> > -----Original Message-----
> > From: Lohithakshan, Ranjith 
> > Sent: Tuesday, February 16, 2010 2:22 PM
> > To: Premi, Sanjeev
> > Cc: Tony Lindgren; linux-omap@vger.kernel.org; Lohithakshan, Ranjith
> > Subject: Re: omap3evm: Doesn't boot at 4fa42e46
> > 
> > This one line change seem to fix the issue on my end
> > 
> > --- a/arch/arm/mach-omap2/mux.c
> > +++ b/arch/arm/mach-omap2/mux.c
> > @@ -969,7 +969,7 @@ static void __init omap_mux_init_list(struct
> > omap_mux *super
> >                 }
> >  #endif
> > 
> > -#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)
> > +#ifdef CONFIG_OMAP_MUX
> >                 if (!superset->muxnames || !superset->muxnames[0]) {
> >                         superset++;
> >                         continue;
> > 
> > Not sure why DebugFS need to be defined for the muxname 
> > check. omap3evm
> > and zoom2/3 dont have DebugFS enabled by default in defconfig and that
> > could explain why these platforms not booting up.

Hmm sounds like that's a bug there. The muxnames are available only during
__init, and optimized out if CONFIG_OMAP_MUX is not set. Initially the
muxnames were there only if CONFIG_DEBUG_FS was set.

> > 
> > A formal patch will follow once I get more confirmations that this
> > change is working.

Please send a formal patch ASAP so we can get it into 2.6.33.
 
> The git-bisect brings me here:
> 
>   premi # g-log-10 78737ae
>   78737ae : omap: Fix arch/arm/mach-omap2/mux.c: Off by one error
>   9ecef43 : omap: Fix 3630 mux errors
>   8d08436 : OMAP2/3: GPMC: ensure valid clock pointer
>   74005a2 : OMAP2/3: IRQ: ensure valid base address
> 
> Kernel boots fine at "8d08436". There was earlier a discussion on "9ecef43" but
> it 'seems' to be specific for 3630 only. 
> 
> But the condition you pointed is added at "9ecef43". So, this IS the problem.
> 
> I am also trying to check if "78737ae" could also lead to a potential error.

The only concernd there AFAIK is that if  mode0 names for some yet unknown
mux modes are longer than OMAP_MUX_DEFNAME_LEN.

Regards,

Tony
