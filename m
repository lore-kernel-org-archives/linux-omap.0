From: Amit Kucheria <amit.kucheria@canonical.com>
Subject: Re: [PATCH v3 02/04] ARM: OMAP: Rename all twl4030_i2c*.
Date: Thu, 1 Oct 2009 15:48:17 +0300
Message-ID: <20091001124817.GS32041@smtp.gmail.com>
References: <1254399576-3645-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:16194 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345AbZJAMse (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 08:48:34 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1728902fge.1
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 05:48:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1254399576-3645-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balajitk@ti.com
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com, wim@iguana.be, timo.t.kokkonen@nokia.com, ben-linux@fluff.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, p_gortmaker@yahoo.com, a.zummo@towertech.it, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On 09 Oct 01, balajitk@ti.com wrote:
> From: Balaji T K <balajitk@ti.com>
> 
>  This patch renames function names like twl4030_i2c_write_u8,
>  twl4030_i2c_read_u8 to twl_i2c_write_u8, twl_i2c_read_u8.
>  I2C address for modules(MADC, Battery Charger, Audio, RTC)
>  have changed between 4030 and 6030. Base address of these module register also
>  changed. Thus twl4030_map will be different for twl4030 and twl6030.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> ---

<lots of snipping>

> @@ -652,9 +661,9 @@ static inline int __init unprotect_pm_master(void)
>  {
>  	int e = 0;
>  
> -	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, KEY_UNLOCK1,
> +	e |= twl_i2c_write_u8(TWL_MODULE_PM_MASTER, KEY_UNLOCK1,
>  			R_PROTECT_KEY);
> -	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, KEY_UNLOCK2,
> +	e |= twl_i2c_write_u8(TWL_MODULE_PM_MASTER, KEY_UNLOCK2,
>  			R_PROTECT_KEY);
>  	return e;
>  }

We should fix this code to return an error immediately, instead of OR'ing the
return values. Perhaps as a separate patch.

> @@ -673,7 +682,7 @@ static void clocks_init(struct device *dev)
>  		osc = clk_get(dev, "osc_sys_ck");
>  
>  	if (IS_ERR(osc)) {
> -		printk(KERN_WARNING "Skipping twl4030 internal clock init and "
> +		printk(KERN_WARNING "Skipping twl internal clock init and "
>  				"using bootloader value (unknown osc rate)\n");
>  		return;
>  	}
> @@ -687,7 +696,7 @@ static void clocks_init(struct device *dev)
>  	 */
>  	osc = ERR_PTR(-EIO);
>  
> -	printk(KERN_WARNING "Skipping twl4030 internal clock init and "
> +	printk(KERN_WARNING "Skipping twl internal clock init and "
>  	       "using bootloader value (unknown osc rate)\n");
>  
>  	return;
> @@ -708,7 +717,7 @@ static void clocks_init(struct device *dev)
>  	ctrl |= HIGH_PERF_SQ;
>  	e |= unprotect_pm_master();
>  	/* effect->MADC+USB ck en */
> -	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
> +	e |= twl_i2c_write_u8(TWL_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
>  	e |= protect_pm_master();

And here.

Regards,
Amit
-- 
-------------------------------------------------------------------------
Amit Kucheria,				 Kernel Developer, Verdurent
-------------------------------------------------------------------------
