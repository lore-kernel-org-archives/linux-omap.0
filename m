From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: Check return values for clk_get
Date: Thu, 28 Jan 2010 19:41:44 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E22B4226@dbde02.ent.ti.com>
References: <87ljg8ql2x.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55178 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734Ab0A1OLu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 09:11:50 -0500
In-Reply-To: <87ljg8ql2x.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 
> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Saturday, January 09, 2010 4:08 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap3: Check return values for clk_get
> 
> Sanjeev Premi <premi@ti.com> writes:
> 
> > This patch checks if clk_get() returned success for
> > the clocks used in function omap2_clk_arch_init().
> >
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock34xx.c |   25 +++++++++++++++++++++++--
> >  1 files changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clock34xx.c 
> b/arch/arm/mach-omap2/clock34xx.c
> > index d4217b9..2c2165b 100644
> > --- a/arch/arm/mach-omap2/clock34xx.c
> > +++ b/arch/arm/mach-omap2/clock34xx.c
> > @@ -316,17 +316,38 @@ static int __init omap2_clk_arch_init(void)
> >  {
> >  	struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
> >  	unsigned long osc_sys_rate;
> > +	short err = 0 ;
> >  
> >  	if (!mpurate)
> >  		return -EINVAL;
> >  
> > -	/* XXX test these for success */
> >  	dpll1_ck = clk_get(NULL, "dpll1_ck");
> > +	if (dpll1_ck == NULL) {
> 
> All of these checks should be of the form
> 
>         if (IS_ERR(<clk>))       
> 
> instead of NULL pointer checks.

Kevin,

    In include/linux/err.h

    #define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)

    static inline long PTR_ERR(const void *ptr)
    {
        return (long) ptr;
    }

    static inline long IS_ERR(const void *ptr)
    {
        return IS_ERR_VALUE((unsigned long)ptr);
    }

    I believe you wanted me to use PTR_ERR(); not IS_ERR().

> 
> You could also do something more compact like this, which takes
> care of the error check and warning print:
> 
>         if (WARN(IS_ERR(<clk ptr>), "Failed to get <name>\n"))
> 
[sp] Sure will compact it.

> > +		err = 1;
> > +		pr_err("*** Failed to get dpll1_ck.\n");
> > +	}
> > +
> >  	arm_fck = clk_get(NULL, "arm_fck");
> > +	if (arm_fck == NULL) {
> > +		err = 1;
> > +		pr_err("*** Failed to get arm_fck.\n");
> > +	}
> > +
> >  	core_ck = clk_get(NULL, "core_ck");
> > +	if (core_ck == NULL) {
> > +		err = 1;
> > +		pr_err("*** Failed to get core_ck.\n");
> > +	}
> > +
> >  	osc_sys_ck = clk_get(NULL, "osc_sys_ck");
> > +	if (osc_sys_ck == NULL) {
> > +		err = 1;
> > +		pr_err("*** Failed to get osc_sys_ck.\n");
> > +	}
> > +
> > +	if (err)
> > +		return 1;
> 
> Minor issue...
> 
> Do you want to skip the rest of the init in case of any failure?
> 
> It seems like the DPLL1 is the only one that would be a real failure,
> the others just affect the clock display.

[sp] But, even when if we use bad pointers for displaying clocks, it
     could be bad.

Best regards,
Sanjeev
> 
> 
> Kevin
> 
> > -	/* REVISIT: not yet ready for 343x */
> >  	if (clk_set_rate(dpll1_ck, mpurate))
> >  		printk(KERN_ERR "*** Unable to set MPU rate\n");
> >  
> > -- 
> > 1.6.2.2
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 