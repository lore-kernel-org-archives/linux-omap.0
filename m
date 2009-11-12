From: Tony Lindgren <tony@atomide.com>
Subject: Re: FEATURES prints
Date: Thu, 12 Nov 2009 13:02:26 -0800
Message-ID: <20091112210226.GD24837@atomide.com>
References: <4ACE39CC.1070906@ti.com>
 <87ws2zge60.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55839 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbZKLVCX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 16:02:23 -0500
Content-Disposition: inline
In-Reply-To: <87ws2zge60.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Nishanth Menon <nm@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Kevin Hilman <khilman@deeprootsystems.com> [091013 15:01]:
> Nishanth Menon <nm@ti.com> writes:
> 
> > Folks,
> >
> > With the addition of FEATURES in l-o, the following prints:
> >  - l2cache : Y
> >  - iva : Y
> >  - sgx : Y
> >  - neon : Y
> >  - isp : Y
> >
> > comes up on SDP3430 -> now that we will introduce half a dozen
> > features here and there, we will soon clutter this up. we should
> > introduce a sysfs entry + remove the above noise..
> >
> 
> Like Nishanth, I don't like the multi-line noise here.  The patch
> below results in a single line output like this instead
> 
> OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )
> 
> Not sure why we need to dump features that are not there, but if that
> s considered important, maybe prefixing each feature with a '+' or '-'
> would still allow this to be collapsed into a single line.
> 
> Even with this, I think adding the display of these features into an
> OMAP-specific section of /proc/cpuinfo would be even better.
> 
> Comments?

I like. Looks like this patch needs to be refreshed.

Tony
 
> Kevin
> 
> 
> commit 24f7422bad970cea2ed71d71e3994eeed70f175f
> Author: Kevin Hilman <khilman@deeprootsystems.com>
> Date:   Tue Oct 13 14:42:00 2009 -0700
> 
>     OMAP3: collapse chip feature prints to single line
>     
>     Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 71d5568..b90fcf1 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -249,11 +249,8 @@ void __init omap3_check_revision(void)
>  }
>  
>  #define OMAP3_SHOW_FEATURE(feat)		\
> -	if (omap3_has_ ##feat()) {		\
> -		pr_info (" - "#feat" : Y");	\
> -	} else {				\
> -		pr_info (" - "#feat" : N");	\
> -	}
> +	if (omap3_has_ ##feat())		\
> +		printk (#feat" ");      	\
>  
>  void __init omap3_cpuinfo(void)
>  {
> @@ -307,13 +304,14 @@ void __init omap3_cpuinfo(void)
>  	/*
>  	 * Print verbose information
>  	 */
> -	pr_info("OMAP%s ES%s\n", cpu_name, cpu_rev);
> +	pr_info("OMAP%s ES%s (", cpu_name, cpu_rev);
>  
>  	OMAP3_SHOW_FEATURE(l2cache);
>  	OMAP3_SHOW_FEATURE(iva);
>  	OMAP3_SHOW_FEATURE(sgx);
>  	OMAP3_SHOW_FEATURE(neon);
>  	OMAP3_SHOW_FEATURE(isp);
> +	printk(")\n");
>  }
>  
>  /*
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
