From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH v2 09/20] DSPBRIDGE: checkpatch - printk() should
 include KERN_ facility level
Date: Mon, 30 Nov 2009 21:57:19 -0600
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012B672BEF@dlee02.ent.ti.com>
References: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-2-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-3-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-4-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-5-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-6-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-7-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-8-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-9-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-10-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41780 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107AbZLAD5N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 22:57:13 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nB13vKfE008947
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 21:57:20 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id nB13vJSX007458
	for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 21:57:19 -0600 (CST)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nB13vJb8019481
	for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 21:57:19 -0600 (CST)
In-Reply-To: <1259618101-8972-10-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>

> From: Ramirez Luna, Omar
> Sent: Monday, November 30, 2009 11:55 PM
> To: linux-omap
> Cc: Ramirez Luna, Omar; Menon, Nishanth
> Subject: [PATCH v2 09/20] DSPBRIDGE: checkpatch - printk() should include
> KERN_ facility level
> 
> WARNING: printk() should include KERN_ facility level


Any reason why we would like to stick with printk(KERN_ERR when we can use pr_err ?

> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> CC: Nishant Menon <nm@ti.com>
> ---
>  arch/arm/plat-omap/include/dspbridge/dbc.h |    2 +-
>  arch/arm/plat-omap/include/dspbridge/gt.h  |    2 +-
>  drivers/dsp/bridge/gen/_gt_para.c          |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/dspbridge/dbc.h b/arch/arm/plat-
> omap/include/dspbridge/dbc.h
> index e9cb548..13b1ff6 100644
> --- a/arch/arm/plat-omap/include/dspbridge/dbc.h
> +++ b/arch/arm/plat-omap/include/dspbridge/dbc.h
> @@ -36,7 +36,7 @@
> 
>  #define DBC_Assert(exp) \
>      if (!(exp)) \
> -	printk("%s, line %d: Assertion (" #exp ") failed.\n", \
> +	printk(KERN_ERR "%s, line %d: Assertion (" #exp ") failed.\n", \
>  	__FILE__, __LINE__)
>  #define DBC_Require DBC_Assert	/* Function Precondition.  */
>  #define DBC_Ensure  DBC_Assert	/* Function Postcondition. */
> diff --git a/arch/arm/plat-omap/include/dspbridge/gt.h b/arch/arm/plat-
> omap/include/dspbridge/gt.h
> index b43b1e7..c110234 100644
> --- a/arch/arm/plat-omap/include/dspbridge/gt.h
> +++ b/arch/arm/plat-omap/include/dspbridge/gt.h
> @@ -232,7 +232,7 @@ extern struct GT_Config _GT_params;
> 
>  #define GT_assert(mask, expr) \
>  	(!(expr) ? \
> -	    printk("assertion violation: %s, line %d\n", \
> +	    printk(KERN_ERR "assertion violation: %s, line %d\n", \
>  			    __FILE__, __LINE__), NULL : NULL)
> 
>  #define GT_config(config)     (_GT_params = *(config))
> diff --git a/drivers/dsp/bridge/gen/_gt_para.c
> b/drivers/dsp/bridge/gen/_gt_para.c
> index 9f8246b..dd22f77 100644
> --- a/drivers/dsp/bridge/gen/_gt_para.c
> +++ b/drivers/dsp/bridge/gen/_gt_para.c
> @@ -77,7 +77,7 @@ static void error(char *fmt, ...)
> 
>  	va_end(va);
> 
> -	printk("ERROR: ");
> +	printk(KERN_ERR "ERROR: ");
>  	printk(fmt, arg1, arg2, arg3, arg4, arg5, arg6);
> 
>  #if defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)
> --
> 1.6.2.4


Regards,
Nishanth Menon
