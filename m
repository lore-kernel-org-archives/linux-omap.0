From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Remove config conditional tcm825x_regs_* declarations
Date: Wed, 28 May 2008 13:31:51 -0700
Message-ID: <20080528203151.GG8845@atomide.com>
References: <1211660444-629-1-git-send-email-trickie@gmail.com> <20080524222258.GA15266@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52397 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbYE1Uby (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 16:31:54 -0400
Content-Disposition: inline
In-Reply-To: <20080524222258.GA15266@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: trickie@gmail.com, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [080524 15:25]:
> On Sat, May 24, 2008 at 10:20:44PM +0200, trickie@gmail.com wrote:
> > 
> > Signed-off-by: Nick Loeve <trickie@gmail.com>
> 
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

Pushing today.

Tony

> 
> > ---
> >  arch/arm/mach-omap2/board-n800-camera.c |    4 ----
> >  1 files changed, 0 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-n800-camera.c b/arch/arm/mach-omap2/board-n800-camera.c
> > index b525125..f2bf91c 100644
> > --- a/arch/arm/mach-omap2/board-n800-camera.c
> > +++ b/arch/arm/mach-omap2/board-n800-camera.c
> > @@ -73,7 +73,6 @@ static int frames_after_reset;
> >  static int saturated_count;
> >  #endif
> >  
> > -#ifdef CONFIG_MACH_NOKIA_N800
> >  const static struct tcm825x_reg tcm825x_regs_n800[] = {
> >  	/* initial settings for 2.5 V */
> >  	{0x00, 0x03}, {0x03, 0x29}, {0xaa, 0x2a}, {0xc0, 0x2b},
> > @@ -106,9 +105,7 @@ const static struct tcm825x_reg tcm825x_regs_n800[] = {
> >  	{0x08, 0x5c}, {0x08, 0x5d}, {0x08, 0x5e}, {0x08, 0x5f},
> >  	{TCM825X_VAL_TERM, TCM825X_REG_TERM}
> >  };
> > -#endif
> >  
> > -#ifdef CONFIG_MACH_NOKIA_N810
> >  const static struct tcm825x_reg tcm825x_regs_n810[] = {
> >  	/* initial settings for 2.5 V */
> >  	{0x00, 0x03}, {0x03, 0x29}, {0xaa, 0x2a}, {0xc0, 0x2b},
> > @@ -141,7 +138,6 @@ const static struct tcm825x_reg tcm825x_regs_n810[] = {
> >  	{0x08, 0x5c}, {0x08, 0x5d}, {0x08, 0x5e}, {0x08, 0x5f},
> >  	{TCM825X_VAL_TERM, TCM825X_REG_TERM}
> >  };
> > -#endif
> >  
> >  static int tcm825x_is_okay(void)
> >  {
> > -- 
> > 1.5.5.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> me@felipebalbi.com
> http://blog.felipebalbi.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
