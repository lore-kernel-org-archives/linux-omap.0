From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: PM: add missing newline to VC warning
 message
Date: Thu, 25 Oct 2012 15:12:37 -0700
Message-ID: <20121025221236.GE11928@atomide.com>
References: <1351186501-32223-1-git-send-email-khilman@deeprootsystems.com>
 <20121025175607.GA21937@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:19444 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750712Ab2JYWMm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 18:12:42 -0400
Content-Disposition: inline
In-Reply-To: <20121025175607.GA21937@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Nishanth Menon <nm@ti.com> [121025 10:57]:
> On 10:35-20121025, Kevin Hilman wrote:
> > From: Kevin Hilman <khilman@ti.com>
> > 
> > Add missing newline to warning message to avoid annoying
> > wrapping problems during kernel boot like this one:
> > 
> >    omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
> >    omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).Power Management for TI OMAP4.
> > 
> > Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> > ---
> >  arch/arm/mach-omap2/vc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> > index 880249b..75878c3 100644
> > --- a/arch/arm/mach-omap2/vc.c
> > +++ b/arch/arm/mach-omap2/vc.c
> > @@ -264,7 +264,7 @@ static void __init omap_vc_i2c_init(struct voltagedomain *voltdm)
> >  
> >  	if (initialized) {
> >  		if (voltdm->pmic->i2c_high_speed != i2c_high_speed)
> > -			pr_warn("%s: I2C config for vdd_%s does not match other channels (%u).",
> > +			pr_warn("%s: I2C config for vdd_%s does not match other channels (%u).\n",
> >  				__func__, voltdm->name, i2c_high_speed);
> >  		return;
> >  	}
> Acked-by: Nishanth Menon <nm@ti.com>

Thanks I'll apply this into omap-for-v3.7-rc2/fixes-part2-take2.


> while we are at it, could we clean up the pr_warning usage back to
> pr_warn as well?
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index 880249b..2d66f8c 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -186,7 +186,7 @@ int omap_vc_bypass_scale(struct voltagedomain *voltdm,
>  		loop_cnt++;
>  
>  		if (retries_cnt > 10) {
> -			pr_warning("%s: Retry count exceeded\n", __func__);
> +			pr_warn("%s: Retry count exceeded\n", __func__);
>  			return -ETIMEDOUT;
>  		}
>  

Looks like that's in the separate patch you posted for v3.8 that Kevin
is taking.

Regards,

Tony
