From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/2] OMAP: omap_device: Add omap_device_[alloc|delete]
 for DT integration
Date: Sat, 17 Sep 2011 10:05:14 -0600
Message-ID: <20110917160514.GU3523@ponder.secretlab.ca>
References: <1316184199-12599-1-git-send-email-b-cousson@ti.com>
 <1316184199-12599-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:65453 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab1IQQFP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Sep 2011 12:05:15 -0400
Received: by yie30 with SMTP id 30so3449222yie.19
        for <linux-omap@vger.kernel.org>; Sat, 17 Sep 2011 09:05:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316184199-12599-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Sep 16, 2011 at 04:43:18PM +0200, Benoit Cousson wrote:
> Split the omap_device_build_ss into two smaller functions
> that will allow to populate a platform_device already allocated by
> device-tree.
> The functionality of the omap_device_build_ss is still the same, but
> the omap_device_alloc will be usable with devices already built by
> device-tree.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

Looks pretty good.  Comments below.

g.

> ---
>  arch/arm/plat-omap/omap_device.c |  177 +++++++++++++++++++++++++------------
>  1 files changed, 119 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 54bbe7b..cac7b9a 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -96,6 +96,11 @@
>  
>  static int omap_device_register(struct platform_device *pdev);
>  static int omap_early_device_register(struct platform_device *pdev);
> +static struct omap_device *omap_device_alloc(struct platform_device *pdev,
> +				      struct omap_hwmod **ohs, int oh_cnt,
> +				      struct omap_device_pm_latency *pm_lats,
> +				      int pm_lats_cnt);
> +
>  
>  static struct omap_device_pm_latency omap_default_latency[] = {
>  	{
> @@ -397,6 +402,110 @@ static int omap_device_fill_resources(struct omap_device *od,
>  }
>  
>  /**
> + * omap_device_alloc - allocate an omap_device
> + * @pdev: platform_device that will be included in this omap_device
> + * @oh: ptr to the single omap_hwmod that backs this omap_device
> + * @pdata: platform_data ptr to associate with the platform_device
> + * @pdata_len: amount of memory pointed to by @pdata
> + * @pm_lats: pointer to a omap_device_pm_latency array for this device
> + * @pm_lats_cnt: ARRAY_SIZE() of @pm_lats
> + *
> + * Convenience function for allocating an omap_device structure and filling
> + * hwmods, resources and pm_latency attributes.
> + *
> + * Returns an struct omap_device pointer or ERR_PTR() on error;
> + */
> +static struct omap_device *omap_device_alloc(struct platform_device *pdev,
> +					struct omap_hwmod **ohs, int oh_cnt,
> +					struct omap_device_pm_latency *pm_lats,
> +					int pm_lats_cnt)
> +{
> +	int ret = -ENOMEM;
> +	struct omap_device *od;
> +	struct resource *res = NULL;
> +	int i, res_count;
> +	struct omap_hwmod **hwmods;
> +
> +	od = kzalloc(sizeof(struct omap_device), GFP_KERNEL);

possible enhancement:  devm_kzalloc() perhaps?  Would simplify the cleanup paths.

> +	if (!od) {
> +		ret = -ENOMEM;
> +		goto oda_exit1;
> +	}
> +	od->hwmods_cnt = oh_cnt;
> +
> +	hwmods = kmemdup(ohs, sizeof(struct omap_hwmod *) * oh_cnt, GFP_KERNEL);

Ditto here.  would require creation of devm_kmemdup()

> +	if (!hwmods)
> +		goto oda_exit2;
> +
> +	od->hwmods = hwmods;
> +	od->pdev = pdev;
> +
> +	/*
> +	 * HACK: Ideally the resources from DT should match, and hwmod
> +	 * should just add the missing ones. Since the name is not
> +	 * properly populated by DT, stick to hwmod resources only.
> +	 */
> +	if (pdev->num_resources && pdev->resource)
> +		dev_warn(&pdev->dev, "%s(): resources already allocated %d\n",
> +			__func__, pdev->num_resources);
> +
> +	res_count = omap_device_count_resources(od);
> +	if (res_count > 0) {
> +		dev_dbg(&pdev->dev, "%s(): resources allocated from hwmod %d\n",
> +			__func__, res_count);
> +		res = kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
> +		if (!res)
> +			goto oda_exit3;
> +
> +		omap_device_fill_resources(od, res);
> +
> +		ret = platform_device_add_resources(pdev, res, res_count);
> +		kfree(res);

How big is res_count?  Struct resource isn't very big.  It can
probably be on the stack.

> +
> +		if (ret)
> +			goto oda_exit3;
> +	}
> +
> +	if (!pm_lats) {
> +		pm_lats = omap_default_latency;
> +		pm_lats_cnt = ARRAY_SIZE(omap_default_latency);
> +	}
> +
> +	od->pm_lats_cnt = pm_lats_cnt;
> +	od->pm_lats = kmemdup(pm_lats,
> +			sizeof(struct omap_device_pm_latency) * pm_lats_cnt,
> +			GFP_KERNEL);
> +	if (!od->pm_lats)
> +		goto oda_exit3;
> +
> +	pdev->archdata.od = od;
> +
> +	for (i = 0; i < oh_cnt; i++) {
> +		hwmods[i]->od = od;
> +		_add_hwmod_clocks_clkdev(od, hwmods[i]);
> +	}
> +
> +	return od;
> +
> +oda_exit3:
> +	kfree(hwmods);
> +oda_exit2:
> +	kfree(od);
> +oda_exit1:
> +	dev_err(&pdev->dev, "omap_device: build failed (%d)\n", ret);
> +
> +	return ERR_PTR(ret);
> +}
> +
> +static void omap_device_delete(struct omap_device *od)
> +{
> +	od->pdev->archdata.od = NULL;
> +	kfree(od->pm_lats);
> +	kfree(od->hwmods);
> +	kfree(od);
> +}
> +
> +/**
>   * omap_device_build - build and register an omap_device with one omap_hwmod
>   * @pdev_name: name of the platform_device driver to use
>   * @pdev_id: this platform_device's connection ID
> @@ -455,9 +564,6 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
>  	int ret = -ENOMEM;
>  	struct platform_device *pdev;
>  	struct omap_device *od;
> -	struct resource *res = NULL;
> -	int i, res_count;
> -	struct omap_hwmod **hwmods;
>  
>  	if (!ohs || oh_cnt == 0 || !pdev_name)
>  		return ERR_PTR(-EINVAL);
> @@ -471,76 +577,31 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
>  		goto odbs_exit;
>  	}
>  
> -	pr_debug("omap_device: %s: building with %d hwmods\n", pdev_name,
> -		 oh_cnt);
> +	/* Set the dev_name early to allow dev_xxx in omap_device_alloc */
> +	if (pdev->id != -1)
> +		dev_set_name(&pdev->dev, "%s.%d", pdev->name,  pdev->id);
> +	else
> +		dev_set_name(&pdev->dev, "%s", pdev->name);

This is duplicated from the core platform_device code.  What is the
reasoning for doing it again here?

>  
> -	od = kzalloc(sizeof(struct omap_device), GFP_KERNEL);
> -	if (!od) {
> -		ret = -ENOMEM;
> +	od = omap_device_alloc(pdev, ohs, oh_cnt, pm_lats, pm_lats_cnt);
> +	if (!od)
>  		goto odbs_exit1;
> -	}
> -	od->hwmods_cnt = oh_cnt;
> -
> -	hwmods = kzalloc(sizeof(struct omap_hwmod *) * oh_cnt,
> -			 GFP_KERNEL);
> -	if (!hwmods)
> -		goto odbs_exit2;
> -
> -	memcpy(hwmods, ohs, sizeof(struct omap_hwmod *) * oh_cnt);
> -	od->hwmods = hwmods;
> -	od->pdev = pdev;
> -
> -	res_count = omap_device_count_resources(od);
> -	if (res_count > 0) {
> -		res = kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
> -		if (!res)
> -			goto odbs_exit3;
> -
> -		omap_device_fill_resources(od, res);
> -
> -		ret = platform_device_add_resources(pdev, res, res_count);
> -		kfree(res);
> -
> -		if (ret)
> -			goto odbs_exit3;
> -	}
>  
>  	ret = platform_device_add_data(pdev, pdata, pdata_len);
>  	if (ret)
> -		goto odbs_exit3;
> -
> -	pdev->archdata.od = od;
> +		goto odbs_exit2;
>  
>  	if (is_early_device)
>  		ret = omap_early_device_register(pdev);
>  	else
>  		ret = omap_device_register(pdev);
>  	if (ret)
> -		goto odbs_exit3;
> -
> -	if (!pm_lats) {
> -		pm_lats = omap_default_latency;
> -		pm_lats_cnt = ARRAY_SIZE(omap_default_latency);
> -	}
> -
> -	od->pm_lats_cnt = pm_lats_cnt;
> -	od->pm_lats = kmemdup(pm_lats,
> -			sizeof(struct omap_device_pm_latency) * pm_lats_cnt,
> -			GFP_KERNEL);
> -	if (!od->pm_lats)
> -		goto odbs_exit3;
> -
> -	for (i = 0; i < oh_cnt; i++) {
> -		hwmods[i]->od = od;
> -		_add_hwmod_clocks_clkdev(od, hwmods[i]);
> -	}
> +		goto odbs_exit2;
>  
>  	return pdev;
>  
> -odbs_exit3:
> -	kfree(hwmods);
>  odbs_exit2:
> -	kfree(od);
> +	omap_device_delete(od);
>  odbs_exit1:
>  	platform_device_put(pdev);
>  odbs_exit:
> -- 
> 1.7.0.4
> 
