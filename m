From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP4: VC: fix I2C timing
Date: Wed, 30 May 2012 11:50:59 +0300
Message-ID: <1338367859.8834.130.camel@sokoban>
References: <1336139842-845-1-git-send-email-t-kristo@ti.com>
	 <1336139842-845-2-git-send-email-t-kristo@ti.com>  <877gvuekud.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57563 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932264Ab2E3IvE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 May 2012 04:51:04 -0400
In-Reply-To: <877gvuekud.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 2012-05-29 at 14:30 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Current I2C timing parameters do not work with Panda board at least.
> > Parameters updated based on TI recommendation.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> Let's fix this correctly by deriving/calculating them from the proper
> source clocks.

Hmm, I'll double check if these can actually be calculated or not.

-Tero

> 
> Otherwise, this is going to work for Panda and break for something else.
> 
> Kevin
> 
> > ---
> >  arch/arm/mach-omap2/vc.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> > index 1fd976e..a731400 100644
> > --- a/arch/arm/mach-omap2/vc.c
> > +++ b/arch/arm/mach-omap2/vc.c
> > @@ -585,7 +585,9 @@ static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
> >  	omap4_set_timings(voltdm, true);
> >  
> >  	/* XXX These are magic numbers and do not belong! */
> > -	vc_val = (0x60 << OMAP4430_SCLL_SHIFT | 0x26 << OMAP4430_SCLH_SHIFT);
> > +	vc_val = (0x28 << OMAP4430_SCLL_SHIFT | 0x2c << OMAP4430_SCLH_SHIFT);
> > +	vc_val |= (0x0b << OMAP4430_HSSCLL_SHIFT);
> > +	vc_val |= (0x0 << OMAP4430_HSSCLH_SHIFT);
> >  	voltdm->write(vc_val, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET);
> >  }


