From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] regulator: fixed: update to devm_* API
Date: Mon, 27 Jan 2014 22:33:08 -0800
Message-ID: <20140128063308.GA5965@core.coreip.homeip.net>
References: <1390878720-8676-1-git-send-email-badarkhe.manish@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390878720-8676-1-git-send-email-badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Manish,

On Tue, Jan 28, 2014 at 08:42:00AM +0530, Manish Badarkhe wrote:
> Update the code to use devm_* API so that driver core will manage
> resources.
> 
> Signed-off-by: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Changes since V1:
> 1. Updated driver to use "devm_kzalloc" to "kstrdup".
> 2. Updated commit message.
> 
> Not tested on any board.
> 
> :100644 100644 5ea64b9... e9763a4... M	drivers/regulator/fixed.c
>  drivers/regulator/fixed.c |   42 ++++++++++++------------------------------
>  1 file changed, 12 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
> index 5ea64b9..e9763a4 100644
> --- a/drivers/regulator/fixed.c
> +++ b/drivers/regulator/fixed.c
> @@ -132,15 +132,15 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
>  			       GFP_KERNEL);
>  	if (drvdata == NULL) {
>  		dev_err(&pdev->dev, "Failed to allocate device data\n");
> -		ret = -ENOMEM;
> -		goto err;
> +		return -ENOMEM;
>  	}
>  
> -	drvdata->desc.name = kstrdup(config->supply_name, GFP_KERNEL);
> +	drvdata->desc.name = devm_kzalloc(&pdev->dev,
> +					  strlen(config->supply_name) + 1,
> +					  GFP_KERNEL);
>  	if (drvdata->desc.name == NULL) {
>  		dev_err(&pdev->dev, "Failed to allocate supply name\n");
> -		ret = -ENOMEM;
> -		goto err;
> +		return -ENOMEM;
>  	}

Umm, I am fairly certain that devm_kzalloc() can't be used as a
substitute for kstrdup, at least not without accompanying memcpy.

Thanks.

-- 
Dmitry
