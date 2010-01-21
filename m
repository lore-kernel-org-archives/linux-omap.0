From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: Check return values for clk_get
Date: Thu, 21 Jan 2010 20:05:42 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E2167CD3@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.1001191816330.3977@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59327 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab0AUOfx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 09:35:53 -0500
In-Reply-To: <alpine.DEB.2.00.1001191816330.3977@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com] 
> Sent: Wednesday, January 20, 2010 6:49 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap3: Check return values for clk_get
> 
> Hello Sanjeev,
> 
> some comments.
> 
> 
> On Fri, 8 Jan 2010, Sanjeev Premi wrote:
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
> 
> Why a 'short' here?  Seems like it makes more sense as a bool.
> 
> >  
> >  	if (!mpurate)
> >  		return -EINVAL;
> >  
> > -	/* XXX test these for success */
> >  	dpll1_ck = clk_get(NULL, "dpll1_ck");
> > +	if (dpll1_ck == NULL) {
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
> This is not a good error value.  This function should return 
> either 0 for 
> success or a negative error number on failure.  Maybe ENOENT?
> 

Thanks for comments Paul.

After Kevin's comments, I had reworked this patch and I believe all
your comments are getting addressed there

I am stuck in some 3630/3730 boot issues; will be sending the
updated patch soon.

Best regards,
Sanjeev

> >  
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
> > 
> 
> 
> - Paul
> 