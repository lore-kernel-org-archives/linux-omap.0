From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: PM: add missing newline to VC warning
 message
Date: Thu, 25 Oct 2012 17:27:34 -0500
Message-ID: <20121025222733.GA19767@kahuna>
References: <1351186501-32223-1-git-send-email-khilman@deeprootsystems.com>
 <20121025175607.GA21937@kahuna>
 <20121025221236.GE11928@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41520 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383Ab2JYW1o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 18:27:44 -0400
Content-Disposition: inline
In-Reply-To: <20121025221236.GE11928@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 15:12-20121025, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [121025 10:57]:
> > On 10:35-20121025, Kevin Hilman wrote:
> > > From: Kevin Hilman <khilman@ti.com>
[..]
> > while we are at it, could we clean up the pr_warning usage back to
> > pr_warn as well?
> > diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> > index 880249b..2d66f8c 100644
> > --- a/arch/arm/mach-omap2/vc.c
> > +++ b/arch/arm/mach-omap2/vc.c
> > @@ -186,7 +186,7 @@ int omap_vc_bypass_scale(struct voltagedomain *voltdm,
> >  		loop_cnt++;
> >  
> >  		if (retries_cnt > 10) {
> > -			pr_warning("%s: Retry count exceeded\n", __func__);
> > +			pr_warn("%s: Retry count exceeded\n", __func__);
> >  			return -ETIMEDOUT;
> >  		}
> >  
> 
> Looks like that's in the separate patch you posted for v3.8 that Kevin
> is taking.

Nope. if you indicated [1], then I got inspired by Kevin's cleanup and cleaned
up vp.c -> Kevin cleaned up vc.c :)

If the additional cleanup I pointed above in this thread is interesting, it
could be clubbed with the current patch itself

[1] https://patchwork.kernel.org/patch/1646661/
-- 
Regards,
Nishanth Menon
