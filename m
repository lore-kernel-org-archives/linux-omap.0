From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH 04/11] OMAP: mach-omap2: Fix miscellaneous sparse
 warnings
Date: Mon, 20 Sep 2010 11:27:35 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402784DD04B@dbde02.ent.ti.com>
References: <1282856209-15645-1-git-send-email-manjugk@ti.com>
 <1282856209-15645-5-git-send-email-manjugk@ti.com>
 <20100916192758.GL29610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47996 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab0ITF5q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 01:57:46 -0400
In-Reply-To: <20100916192758.GL29610@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Friday, September 17, 2010 12:58 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Menon, Nishanth
> Subject: Re: [PATCH 04/11] OMAP: mach-omap2: Fix 
> miscellaneous sparse warnings
> 
> * G, Manjunath Kondaiah <manjugk@ti.com> [100826 13:50]:
> > From: Manjunatha GK <manjugk@ti.com>

...

> >  		I2C_BOARD_INFO("s35390a", 0x30),
> > -		.type		= "s35390a",
> >  	},
> >  };
> 
> OK, I2C_BOARD_INFO sets it too.
>   
> > diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c 
> > index 26aeef5..02fd942 100644
> > --- a/arch/arm/mach-omap2/irq.c
> > +++ b/arch/arm/mach-omap2/irq.c
> > @@ -47,7 +47,7 @@ static struct omap_irq_bank {  } __attribute__ 
> > ((aligned(4))) irq_banks[] = {
> >  	{
> >  		/* MPU INTC */
> > -		.base_reg	= 0,
> > +		.base_reg	= (void __iomem *)0,
> >  		.nr_irqs	= 96,
> >  	},
> >  };
> 
> The base_reg line you can remove, the static data area gets 
> zeroed during init.

Ok.

-Manjunath

