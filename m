From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] Fix compiler warnings in smartreflex.c
Date: Fri, 10 Oct 2008 16:19:47 +0300
Message-ID: <20081010131947.GE7503@gandalf.research.nokia.com>
References: <1223642237-9345-1-git-send-email-premi@ti.com> <20081010124407.GC7503@gandalf.research.nokia.com> <20081010125429.GD7503@gandalf.research.nokia.com> <B85A65D85D7EB246BE421B3FB0FBB59301B020C484@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39713 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756315AbYJJNUk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 09:20:40 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301B020C484@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Premi, Sanjeev" <premi@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

On Fri, Oct 10, 2008 at 06:39:03PM +0530, ext Premi, Sanjeev wrote:
>  
> 
> > -----Original Message-----
> > From: Felipe Balbi [mailto:felipe.balbi@nokia.com] 
> > Sent: Friday, October 10, 2008 6:24 PM
> > To: ext Felipe Balbi
> > Cc: Premi, Sanjeev; linux-omap@vger.kernel.org; Paul Walmsley
> > Subject: Re: [PATCH] Fix compiler warnings in smartreflex.c
> > 
> > On Fri, Oct 10, 2008 at 03:44:07PM +0300, ext Felipe Balbi wrote:
> > > On Fri, Oct 10, 2008 at 06:07:17PM +0530, ext Sanjeev Premi wrote:
> > > > Fix these compiler warnings:
> > > > smartreflex.c:126: warning: initialization makes integer from 
> > > > pointer without a cast
> > > > smartreflex.c:134: warning: initialization makes integer from 
> > > > pointer without a cast
> > > > 
> > > > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > > > ---
> > > >  arch/arm/mach-omap2/smartreflex.c |    4 ++--
> > > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/mach-omap2/smartreflex.c 
> > > > b/arch/arm/mach-omap2/smartreflex.c
> > > > index e54c0fb..8460633 100644
> > > > --- a/arch/arm/mach-omap2/smartreflex.c
> > > > +++ b/arch/arm/mach-omap2/smartreflex.c
> > > > @@ -123,7 +123,7 @@ static struct omap_sr sr1 = {
> > > >  	.is_sr_reset		= 1,
> > > >  	.is_autocomp_active	= 0,
> > > >  	.clk_length		= 0,
> > > > -	.srbase_addr		= OMAP2_IO_ADDRESS(OMAP34XX_SR1_BASE),
> > > > +	.srbase_addr		= 
> > (u32)OMAP2_IO_ADDRESS(OMAP34XX_SR1_BASE),
> > > 
> > > please don't. Most likely srbase_addr should move to void __iomem *
> > > 
> > > Paul, any comments ??
> > 
> > Took a look at it, the following might be a better ?? (compile tested
> > only)
> 
> Looks good. I will try on my evm immediately.

please do it. Try it out and resend with you proper signed-off-by line
;-)

You should probably put those whitespace cleanups in a separate patch.

Also, please Cc Kevin when you resend :-D

-- 
balbi
