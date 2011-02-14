From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: Fix Memory Leaks in Smartreflex driver.
Date: Mon, 14 Feb 2011 14:46:16 -0800
Message-ID: <877hd2z13b.fsf@ti.com>
References: <1297165948-28386-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:32968 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751082Ab1BNWqn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 17:46:43 -0500
Received: by pvh11 with SMTP id 11so1032903pvh.32
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 14:46:19 -0800 (PST)
In-Reply-To: <1297165948-28386-1-git-send-email-shweta.gulati@ti.com> (Shweta
	Gulati's message of "Tue, 8 Feb 2011 17:22:28 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org

Shweta Gulati <shweta.gulati@ti.com> writes:

> This Patch frees all the dynamically allocated memory
> which couldn't have been released in some error hitting cases.
>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>

Looks fine for 2.6.38-rc cycle.  Please repost with linux-arm-kernel in
Cc, and I'll queue it up.

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |   18 ++++++++++++------
>  1 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index d7deadf..a904625 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -282,6 +282,7 @@ error:
>  		dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
>  			"interrupt handler. Smartreflex will"
>  			"not function as desired\n", __func__);
> +		kfree(name);
>  		kfree(sr_info);
>  		return ret;
>  }
> @@ -880,7 +881,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>  		ret = sr_late_init(sr_info);
>  		if (ret) {
>  			pr_warning("%s: Error in SR late init\n", __func__);
> -			return ret;
> +			goto err_release_region;
>  		}
>  	}
>  
> @@ -891,14 +892,17 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>  	 * not try to create rest of the debugfs entries.
>  	 */
>  	vdd_dbg_dir = omap_voltage_get_dbgdir(sr_info->voltdm);
> -	if (!vdd_dbg_dir)
> -		return -EINVAL;
> +	if (!vdd_dbg_dir) {
> +		ret = -EINVAL;
> +		goto err_release_region;
> +	}
>  
>  	dbg_dir = debugfs_create_dir("smartreflex", vdd_dbg_dir);
>  	if (IS_ERR(dbg_dir)) {
>  		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
>  			__func__);
> -		return PTR_ERR(dbg_dir);
> +		ret = PTR_ERR(dbg_dir);
> +		goto err_release_region;
>  	}
>  
>  	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUGO, dbg_dir,
> @@ -914,7 +918,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>  	if (IS_ERR(nvalue_dir)) {
>  		dev_err(&pdev->dev, "%s: Unable to create debugfs directory"
>  			"for n-values\n", __func__);
> -		return PTR_ERR(nvalue_dir);
> +		ret = PTR_ERR(nvalue_dir);
> +		goto err_release_region;
>  	}
>  
>  	omap_voltage_get_volttable(sr_info->voltdm, &volt_data);
> @@ -923,7 +928,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>  			" corresponding vdd vdd_%s. Cannot create debugfs"
>  			"entries for n-values\n",
>  			__func__, sr_info->voltdm->name);
> -		return -ENODATA;
> +		ret = -ENODATA;
> +		goto err_release_region;
>  	}
>  
>  	for (i = 0; i < sr_info->nvalue_count; i++) {
