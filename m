From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 1/3] OMAP: omap_device: Add omap_device_[alloc|delete] for DT integration
Date: Thu, 01 Sep 2011 11:30:24 -0700
Message-ID: <87liu8dsjj.fsf@ti.com>
References: <1314037343-19783-1-git-send-email-b-cousson@ti.com>
	<1314037343-19783-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:42374 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755940Ab1IASab (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 14:30:31 -0400
Received: by ywe9 with SMTP id 9so1999034ywe.31
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 11:30:29 -0700 (PDT)
In-Reply-To: <1314037343-19783-2-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Mon, 22 Aug 2011 20:22:21 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, grant.likely@secretlab.ca

Benoit Cousson <b-cousson@ti.com> writes:

> Split the omap_device_build_ss into two smaller functions
> that will allow to populate a platform_device already alocated by
> device-tree.
> The functionality of the omap_device_build_ss is still the same, but
> the omap_device_alloc will be usable with devices already built by
> device-tree.

Very nice, I started down this path in the original series, but didn't
finish.

Some minor comments below...

> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/plat-omap/omap_device.c |  168 ++++++++++++++++++++++++++------------
>  1 files changed, 114 insertions(+), 54 deletions(-)
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index f2149be..752d72a 100644
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
> @@ -397,6 +402,105 @@ static int omap_device_fill_resources(struct omap_device *od,
>  }
>  
>  /**
> + * omap_device_alloc - allocate an omap_device
> + * @pdev: platform_device that will be represent this omap_device
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
> +	if (!od) {
> +		ret = -ENOMEM;
> +		goto oda_exit1;
> +	}
> +	od->hwmods_cnt = oh_cnt;
> +
> +	hwmods = kzalloc(sizeof(struct omap_hwmod *) * oh_cnt,
> +			 GFP_KERNEL);
> +	if (!hwmods)
> +		goto oda_exit2;
> +
> +	memcpy(hwmods, ohs, sizeof(struct omap_hwmod *) * oh_cnt);
> +	od->hwmods = hwmods;
> +	od->pdev = pdev;
> +
> +	if (pdev->num_resources && pdev->resource)
> +		dev_warn(&pdev->dev, "%s(): ressources already allocated %d\n",

typo: ressources (occurs again below)

also, this check/warn should probably go after the 'HACK' comment below.

> +			__func__, pdev->num_resources);
> +	/*
> +	 * HACK: Idealy the resources from DT should match, and hwmod

s/Idealy/Ideally/

> +	 * should just add the missing ones. Since the name is not
> +	 * properly populated by DT, stick to hwmod resources only.

I think this limitation is fine until we come to resolution in the named
resources debate.

> +	 */
> +	res_count = omap_device_count_resources(od);
> +	if (res_count > 0) {
> +		dev_dbg(&pdev->dev, "%s(): ressources allocated from hwmod %d\n",
> +			__func__, res_count);
> +		res = kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
> +		if (!res)
> +			goto oda_exit3;
> +
> +		omap_device_fill_resources(od, res);
> +
> +		ret = platform_device_add_resources(pdev, res, res_count);
> +		kfree(res);
> +
> +		if (ret)
> +			goto oda_exit3;
> +	}
> +
> +	if (pm_lats) {
> +		od->pm_lats = pm_lats;
> +		od->pm_lats_cnt = pm_lats_cnt;
> +	} else {
> +		od->pm_lats = omap_default_latency;
> +		od->pm_lats_cnt = ARRAY_SIZE(omap_default_latency);
> +	}
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
> +void omap_device_delete(struct omap_device *od)
> +{
> +	kfree(od->hwmods);
> +	kfree(od);

maybe set pdev->archdata.od = NULL too.

> +}
> +
> +/**
>   * omap_device_build - build and register an omap_device with one omap_hwmod
>   * @pdev_name: name of the platform_device driver to use
>   * @pdev_id: this platform_device's connection ID
> @@ -455,9 +559,6 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
>  	int ret = -ENOMEM;
>  	struct platform_device *pdev;
>  	struct omap_device *od;
> -	struct resource *res = NULL;
> -	int i, res_count;
> -	struct omap_hwmod **hwmods;
>  
>  	if (!ohs || oh_cnt == 0 || !pdev_name)
>  		return ERR_PTR(-EINVAL);
> @@ -471,72 +572,31 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
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

Minor: I think setting dev->init_name is more appropriate here, and
should have the same effect.

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
> -	if (pm_lats) {
> -		od->pm_lats = pm_lats;
> -		od->pm_lats_cnt = pm_lats_cnt;
> -	} else {
> -		od->pm_lats = omap_default_latency;
> -		od->pm_lats_cnt = ARRAY_SIZE(omap_default_latency);
> -	}
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


Kevin
