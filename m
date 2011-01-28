From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arch/arm/mach-omap2/dma.c: Convert IS_ERR result
 to PTR_ERR
Date: Thu, 27 Jan 2011 16:26:21 -0800
Message-ID: <20110128002620.GR23412@atomide.com>
References: <1296143347-17508-1-git-send-email-julia@diku.dk>
 <20110127210225.07de155f.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63197 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab1A1A01 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 19:26:27 -0500
Content-Disposition: inline
In-Reply-To: <20110127210225.07de155f.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Julia Lawall <julia@diku.dk>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Jarkko Nikula <jhnikula@gmail.com> [110127 11:03]:
> On Thu, 27 Jan 2011 16:49:06 +0100
> Julia Lawall <julia@diku.dk> wrote:
> 
> > diff -u -p a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
> > --- a/arch/arm/mach-omap2/dma.c
> > +++ b/arch/arm/mach-omap2/dma.c
> > @@ -264,7 +264,7 @@ static int __init omap2_system_dma_init_
> >  	if (IS_ERR(od)) {
> >  		pr_err("%s: Cant build omap_device for %s:%s.\n",
> >  			__func__, name, oh->name);
> > -		return IS_ERR(od);
> > +		return PTR_ERR(od);
> >  	}
> >  
> FWIW,
> 
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

Thanks, will queue as a fix during the -rc cycle.

Tony
