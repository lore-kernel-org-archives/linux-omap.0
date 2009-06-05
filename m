From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: PM: Fix the pwrdm_enable/disable_hdwr_sar funcs
Date: Fri, 5 Jun 2009 16:44:37 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906051642370.6425@utopia.booyaka.com>
References: <1244206853-4426-1-git-send-email-rnayak@ti.com> <87hbyu72n8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44587 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbZFEWog (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 18:44:36 -0400
In-Reply-To: <87hbyu72n8.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>, linux-omap@vger.kernel.org

On Fri, 5 Jun 2009, Kevin Hilman wrote:

> Rajendra Nayak <rnayak@ti.com> writes:
> 
> > The pwrdm_enable_hdwr_sar/pwrdm_disable_hdwr_sar do not
> > actually set/reset the SAVEANDRESTORE bit in the PWSTCTRL
> > register but modify some other bit instead.
> > This happens due to the OMAP3430ES2_SAVEANDRESTORE_SHIFT
> > being defined as (1 << 4) instead of just 4.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> 
> Thanks, pushing to PM branch.
> 
> I'll wait to hear from Kalle if we can revert his previous patch
> for this.

I think Kalle covered this one already:

http://patchwork.kernel.org/patch/15586/

- Paul

> 
> Kevin
> 
> > ---
> >  arch/arm/mach-omap2/prm-regbits-34xx.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
> > index 06fee29..d4ea370 100644
> > --- a/arch/arm/mach-omap2/prm-regbits-34xx.h
> > +++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
> > @@ -411,7 +411,7 @@
> >  /* PM_PREPWSTST_CAM specific bits */
> >  
> >  /* PM_PWSTCTRL_USBHOST specific bits */
> > -#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		(1 << 4)
> > +#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		4
> >  
> >  /* RM_RSTST_PER specific bits */
> >  
> > -- 
> > 1.5.4.7
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


