From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: FEATURES prints
Date: Wed, 14 Oct 2009 03:26:11 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDE20C25@dbde02.ent.ti.com>
References: <4ACE39CC.1070906@ti.com> <87ws2zge60.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34943 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbZJMV4v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 17:56:51 -0400
In-Reply-To: <87ws2zge60.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Wednesday, October 14, 2009 3:17 AM
> To: Menon, Nishanth
> Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
> Subject: Re: FEATURES prints
> 
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

[sp] Single line prints look good. We can also add details in cpuinfo.

~sanjeev

> Comments?
> 
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
> 
> 