From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Missing implementation of omap3evm_flash_init()
Date: Wed, 24 Jun 2009 16:36:48 +0300
Message-ID: <20090624133648.GP7352@atomide.com>
References: <1245331742-2536-1-git-send-email-premi@ti.com> <20090622090651.GA7352@atomide.com> <B85A65D85D7EB246BE421B3FB0FBB59301D82205FC@dbde02.ent.ti.com> <20090622133347.GI7352@atomide.com> <B85A65D85D7EB246BE421B3FB0FBB59301D829BDEC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59937 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbZFXNgv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 09:36:51 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301D829BDEC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Premi, Sanjeev <premi@ti.com> [090624 14:45]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com] 
> > Sent: Monday, June 22, 2009 7:04 PM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] Missing implementation of omap3evm_flash_init()
> > 
> > * Premi, Sanjeev <premi@ti.com> [090622 16:16]:
> > > > -----Original Message-----
> > > > From: Tony Lindgren [mailto:tony@atomide.com] 
> > > > Sent: Monday, June 22, 2009 2:37 PM
> > > > To: Premi, Sanjeev
> > > > Cc: linux-omap@vger.kernel.org
> > > > Subject: Re: [PATCH] Missing implementation of 
> > omap3evm_flash_init()
> > > > 
> 
> <snip>--<snip>
> 
> Tony,
> 
> I had a few follow-up queries below:
> 
> > > > 
> > > > We already have code that initializes the GPMC for 
> > onenand in kernel.
> > > > And I posted a patch to enable onenand for the SDP boards 
> > > > last week [1].
> > > 
> > > Did not see it; before creating the patch; lookig at this now...
> > 
> > OK, thanks.
> >  
> > > > And this is yet another copy of the same code that was 
> > duplicated for
> > > > multiple boards. So how about making the following changes: 
> > > > 
> > > > - Pass the onenand chip select for GPMC in platform data. I 
> > > > doubt that the
> > > >   chip select is changing?
> > > > 
> > > > - If you still need to probe for onenand, please create a 
> > > > generic function
> > > >   in gpmc-onenand.c to probe for onenand
> 
> I always see "onenand_base" being passed as argument. Where is it
> initialized?

That is allocated with  gpmc_cs_request() based on the cs in the 
struct omap_onenand_platform_data.
 
> I did implement this function to probe for nand/onenand - based on
> the code that existed in board-omap3evm-flash.c; but ran into
> some problems with the setting base address.

I guess the probe is only looking at the GPMC configuration registers
though?
 
> Looking at the gpmc-onenand.c do you believe we would need a
> gpmc-nand.c on same lines? Or an implementation within the
> board-omap3evm.c is okay for now?

Well if you can figure out how to do a common gpmc-nand.c, I'm sure
it would make things easier to bring up new boards (and omaps).

Regards,

Tony


> 
> Best regards,
> Sanjeev
> 
> > > > 
> > > 
> > > Some EVMs have OneNAND and others have NAND. How/ Where do 
> > you suggest
> > > this check sould go?
> > 
> > If it's based on just checking the GPMC registers, you could 
> > put it into
> > gpmc.c.
> > 
> > Regards,
> > 
> > Tony
> > 
> > 
> > 
> 
> 
> <snip>--<snip>--<snip till end>
>  
