From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] free rev gpios when they are read, so others can read
 them later
Date: Tue, 31 May 2011 05:01:33 -0700
Message-ID: <20110531120133.GC11352@atomide.com>
References: <1306438716-68265-1-git-send-email-tasskjapp@gmail.com>
 <2DCF0893-4166-4604-887B-EDBC3643290A@gmail.com>
 <4DDF8AC9.60709@compulab.co.il>
 <91831E5F-5654-4133-AADC-9C3D6B86A63E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13057 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753701Ab1EaMBh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 08:01:37 -0400
Content-Disposition: inline
In-Reply-To: <91831E5F-5654-4133-AADC-9C3D6B86A63E@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org

* Tasslehoff Kjappfot <tasskjapp@gmail.com> [110528 02:20]:
> Hi Igor.
> > 
> > To be consistent with the rest of the file,
> > can the white space here be "tabs" instead of spaces?
> > 
> > 
> > -- 
> > Regards,
> > Igor.
> > 
> 
> They can. New version attached. I'm don't know how to use git send-email to continue this thread with a comment to my patch, so it was done manually. Let me know if something else is less-than-optimal with my patches. Rookie contributor :)

Thanks applying to fixes with following description:

Free Beagle rev gpios when they are read, so others can read them later
 
Regards,

Tony

> Signed-off-by: Tasslehoff Kjappfot <tasskjapp@gmail.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 3ff3a2c..54dbb7dd 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -106,6 +106,9 @@ static void __init omap3_beagle_init_rev(void)
>  	beagle_rev = gpio_get_value(171) | (gpio_get_value(172) << 1)
>  			| (gpio_get_value(173) << 2);
>  
> +	gpio_free_array(omap3_beagle_rev_gpios,
> +			ARRAY_SIZE(omap3_beagle_rev_gpios));
> +
>  	switch (beagle_rev) {
>  	case 7:
>  		printk(KERN_INFO "OMAP3 Beagle Rev: Ax/Bx\n");
> -- 
> 1.7.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
