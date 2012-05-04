From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 11/25] OMAPDSS: create custom pdevs for DSS omap_devices
Date: Fri, 4 May 2012 13:47:21 +0530
Message-ID: <4FA39091.8010007@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com> <1336053481-25433-12-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52992 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752313Ab2EDISC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 May 2012 04:18:02 -0400
In-Reply-To: <1336053481-25433-12-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 03 May 2012 07:27 PM, Tomi Valkeinen wrote:
> Instead of using omap_device_build() to create the omap_devices for DSS
> hwmods, create them with a custom function. This will allow us to create
> a parent-child hierarchy for the devices so that the omapdss_core device
> is parent for the rest of the dss hwmod devices.
>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   arch/arm/mach-omap2/display.c |   88 ++++++++++++++++++++++++++++++++++-------
>   1 file changed, 74 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index 07232fd..46d2a98 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -185,13 +185,71 @@ static int omap_dss_set_min_bus_tput(struct device *dev, unsigned long tput)
>   	return omap_pm_set_min_bus_tput(dev, OCP_INITIATOR_AGENT, tput);
>   }
>
> +static struct platform_device *create_dss_pdev(const char *pdev_name,
> +		int pdev_id, const char *oh_name, void *pdata, int pdata_len,
> +		struct platform_device *parent)
> +{
> +	struct platform_device *pdev;
> +	struct omap_device *od;
> +	struct omap_hwmod *ohs[1];
> +	struct omap_hwmod *oh;
> +	int r;
> +
> +	oh = omap_hwmod_lookup(oh_name);
> +	if (!oh) {
> +		pr_err("Could not look up %s\n", oh_name);
> +		r = -ENODEV;
> +		goto err;
> +	}
> +
> +	pdev = platform_device_alloc(pdev_name, pdev_id);
> +	if (!pdev) {
> +		pr_err("Could not create pdev for %s\n", pdev_name);
> +		r = -ENOMEM;
> +		goto err;
> +	}
> +
> +	if (parent != NULL)
> +		pdev->dev.parent =&parent->dev;
> +
> +	if (pdev->id != -1)
> +		dev_set_name(&pdev->dev, "%s.%d", pdev->name, pdev->id);
> +	else
> +		dev_set_name(&pdev->dev, "%s", pdev->name);
> +
> +	ohs[0] = oh;
> +	od = omap_device_alloc(pdev, ohs, 1, NULL, 0);
> +	if (!od) {
> +		pr_err("Could not alloc omap_device for %s\n", pdev_name);
> +		r = -ENOMEM;
> +		goto err;
> +	}
> +
> +	r = platform_device_add_data(pdev, pdata, pdata_len);
> +	if (r) {
> +		pr_err("Could not set pdata for %s\n", pdev_name);
> +		goto err;
> +	}
> +
> +	r = omap_device_register(pdev);
> +	if (r) {
> +		pr_err("Could not register omap_device for %s\n", pdev_name);
> +		goto err;
> +	}
> +
> +	return pdev;
> +
> +err:
> +	return ERR_PTR(r);
> +}
> +
>   int __init omap_display_init(struct omap_dss_board_info *board_data)
>   {
>   	int r = 0;
> -	struct omap_hwmod *oh;
>   	struct platform_device *pdev;
>   	int i, oh_count;
>   	const struct omap_dss_hwmod_data *curr_dss_hwmod;
> +	struct platform_device *dss_pdev;
>
>   	/* create omapdss device */
>
> @@ -221,22 +279,24 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
>   		oh_count = ARRAY_SIZE(omap4_dss_hwmod_data);
>   	}
>
> -	for (i = 0; i<  oh_count; i++) {
> -		oh = omap_hwmod_lookup(curr_dss_hwmod[i].oh_name);
> -		if (!oh) {
> -			pr_err("Could not look up %s\n",
> -				curr_dss_hwmod[i].oh_name);
> -			return -ENODEV;
> -		}
> +	dss_pdev = NULL;
>
> -		pdev = omap_device_build(curr_dss_hwmod[i].dev_name,
> -				curr_dss_hwmod[i].id, oh,
> +	for (i = 0; i<  oh_count; i++) {
> +		pdev = create_dss_pdev(curr_dss_hwmod[i].dev_name,
> +				curr_dss_hwmod[i].id,
> +				curr_dss_hwmod[i].oh_name,
>   				NULL, 0,
> -				NULL, 0, 0);
> +				dss_pdev);
> +
> +		if (IS_ERR(pdev)) {
> +			pr_err("Could not build omap_device for %s\n",
> +					curr_dss_hwmod[i].oh_name);
> +
> +			return PTR_ERR(pdev);
> +		}
>
> -		if (WARN((IS_ERR(pdev)), "Could not build omap_device for %s\n",
> -				curr_dss_hwmod[i].oh_name))
> -			return -ENODEV;
> +		if (i == 0)
> +			dss_pdev = pdev;

The above line is a bit tricky to understand, maybe something like this 
may explain the parent-child setting better:

		if (!strcmp(curr_dss_hwmod[i].oh_name, "dss_core"))
			dss_pdev = pdev;

I had another general question about the parent-child series. What is 
the use of the platform device omap_display_device (with the name 
"omapdss"). Is it just a way to get the board data?

Archit

>   	}
>
>   	return 0;

