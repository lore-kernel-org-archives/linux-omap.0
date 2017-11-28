From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Missing error code in omap_device_build()
Date: Tue, 28 Nov 2017 06:55:21 -0800
Message-ID: <20171128145521.GX28152@atomide.com>
References: <20171114060648.frwveus2pjpx5idw@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171114060648.frwveus2pjpx5idw@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Dan Carpenter <dan.carpenter@oracle.com> [171113 22:10]:
> We need to set the error code if omap_device_alloc() fails.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 184acd95c216..f0388058b7da 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -514,8 +514,10 @@ struct platform_device __init *omap_device_build(const char *pdev_name,
>  		goto odbs_exit1;
>  
>  	od = omap_device_alloc(pdev, &oh, 1);
> -	if (IS_ERR(od))
> +	if (IS_ERR(od)) {
> +		ret = PTR_ERR(od);
>  		goto odbs_exit1;
> +	}
>  
>  	ret = platform_device_add_data(pdev, pdata, pdata_len);
>  	if (ret)

Applying into omap-for-v4.15/fixes thanks.

Tony
