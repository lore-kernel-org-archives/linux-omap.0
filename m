From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [RFC][PATCH] mfd: twl4030: Check for i2c error code in
 protect_pm_master function
Date: Tue, 5 Jan 2010 19:43:04 +0100
Message-ID: <20100105184303.GF4274@sortiz.org>
References: <1260548958-27317-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:40746 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755175Ab0AESlZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 13:41:25 -0500
Content-Disposition: inline
In-Reply-To: <1260548958-27317-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balajitk@ti.com
Cc: linux-omap@vger.kernel.org, amit.kucheria@verdurent.com

Hi Balaji,

On Fri, Dec 11, 2009 at 09:59:18PM +0530, balajitk@ti.com wrote:
> From: Balaji T K <balajitk@ti.com>
> 
>         Warn about error messages immediately after i2c write to R_PROTECT_KEY
> 	in functions protect_pm_master/unprotect_pm_master
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  drivers/mfd/twl-core.c |   23 ++++++++++++++++++-----
>  1 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 42af794..74f93ed 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -804,6 +804,9 @@ static inline int __init protect_pm_master(void)
>  
>  	e = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, KEY_LOCK,
>  			R_PROTECT_KEY);
> +	if (e < 0)
> +		pr_err("twl_core: Could not write value : %x to TWL"
> +		       " register %x err %d\n", KEY_LOCK, R_PROTECT_KEY, e);
>  	return e;
>  }
>  
> @@ -811,10 +814,17 @@ static inline int __init unprotect_pm_master(void)
>  {
>  	int e = 0;
>  
> -	e |= twl_i2c_write_u8(TWL_MODULE_PM_MASTER, KEY_UNLOCK1,
> +	e = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, KEY_UNLOCK1,
>  			R_PROTECT_KEY);
> -	e |= twl_i2c_write_u8(TWL_MODULE_PM_MASTER, KEY_UNLOCK2,
> +	if (e < 0)
> +		pr_err("twl_core: Could not write value : %x to TWL"
> +		       " register %x err %d\n", KEY_UNLOCK1, R_PROTECT_KEY, e);
> +
Does it make sense to continue here ? If the key unlocking failed, shouldnt we
just return the error and leave ?


> +	e = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, KEY_UNLOCK2,
>  			R_PROTECT_KEY);
> +	if (e < 0)
> +		pr_err("twl_core: Could not write value : %x to TWL"
> +		       " register %x err %d\n", KEY_UNLOCK1, R_PROTECT_KEY, e);
>  	return e;
>  }
>  
> @@ -865,10 +875,13 @@ static void clocks_init(struct device *dev)
>  	}
>  
>  	ctrl |= HIGH_PERF_SQ;
> -	e |= unprotect_pm_master();
> +	e = unprotect_pm_master();
Same here: If the unprotection failed, the rest probably will fail as well,
right ?

Cheers,
Samuel.

>  	/* effect->MADC+USB ck en */
> -	e |= twl_i2c_write_u8(TWL_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
> -	e |= protect_pm_master();
> +	e = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
> +	if (e < 0)
> +		pr_err("twl_core: Could not write value : %x to TWL"
> +		       " register %x err %d\n", ctrl, R_CFG_BOOT, e);
> +	e = protect_pm_master();
>  
>  	if (e < 0)
>  		pr_err("%s: clock init err [%d]\n", DRIVER_NAME, e);
> -- 
> 1.5.4.7
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
