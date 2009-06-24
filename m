From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Missing implementation of omap3evm_flash_init()
Date: Wed, 24 Jun 2009 17:15:32 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D829BDEC@dbde02.ent.ti.com>
References: <1245331742-2536-1-git-send-email-premi@ti.com>
 <20090622090651.GA7352@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301D82205FC@dbde02.ent.ti.com>
 <20090622133347.GI7352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46935 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760669AbZFXLpl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 07:45:41 -0400
In-Reply-To: <20090622133347.GI7352@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Monday, June 22, 2009 7:04 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] Missing implementation of omap3evm_flash_init()
> 
> * Premi, Sanjeev <premi@ti.com> [090622 16:16]:
> > > -----Original Message-----
> > > From: Tony Lindgren [mailto:tony@atomide.com] 
> > > Sent: Monday, June 22, 2009 2:37 PM
> > > To: Premi, Sanjeev
> > > Cc: linux-omap@vger.kernel.org
> > > Subject: Re: [PATCH] Missing implementation of 
> omap3evm_flash_init()
> > > 

<snip>--<snip>

Tony,

I had a few follow-up queries below:

> > > 
> > > We already have code that initializes the GPMC for 
> onenand in kernel.
> > > And I posted a patch to enable onenand for the SDP boards 
> > > last week [1].
> > 
> > Did not see it; before creating the patch; lookig at this now...
> 
> OK, thanks.
>  
> > > And this is yet another copy of the same code that was 
> duplicated for
> > > multiple boards. So how about making the following changes: 
> > > 
> > > - Pass the onenand chip select for GPMC in platform data. I 
> > > doubt that the
> > >   chip select is changing?
> > > 
> > > - If you still need to probe for onenand, please create a 
> > > generic function
> > >   in gpmc-onenand.c to probe for onenand

I always see "onenand_base" being passed as argument. Where is it
initialized?

I did implement this function to probe for nand/onenand - based on
the code that existed in board-omap3evm-flash.c; but ran into
some problems with the setting base address.

Looking at the gpmc-onenand.c do you believe we would need a
gpmc-nand.c on same lines? Or an implementation within the
board-omap3evm.c is okay for now?

Best regards,
Sanjeev

> > > 
> > 
> > Some EVMs have OneNAND and others have NAND. How/ Where do 
> you suggest
> > this check sould go?
> 
> If it's based on just checking the GPMC registers, you could 
> put it into
> gpmc.c.
> 
> Regards,
> 
> Tony
> 
> 
> 


<snip>--<snip>--<snip till end>
 