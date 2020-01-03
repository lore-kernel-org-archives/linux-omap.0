From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH -next] fbdev: omapfb: use
 devm_platform_ioremap_resource() to simplify code
Date: Fri, 3 Jan 2020 13:14:08 +0100
Message-ID: <3f75dae1-181f-3935-0b1d-40839392226e@samsung.com>
References: <CGME20190904115507epcas1p42d4d5b2f6ee58db0ccf3b1ee27063ac1@epcas1p4.samsung.com>
        <20190904115406.23880-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904115406.23880-1-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: tglx@linutronix.de, alexios.zavras@intel.com, gregkh@linuxfoundation.org, allison@lohutok.net, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 9/4/19 1:54 PM, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks, patch queued for v5.6 (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/omap2/omapfb/vrfb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/vrfb.c b/drivers/video/fbdev/omap2/omapfb/vrfb.c
> index 819e0bc..ee0dd4c 100644
> --- a/drivers/video/fbdev/omap2/omapfb/vrfb.c
> +++ b/drivers/video/fbdev/omap2/omapfb/vrfb.c
> @@ -339,9 +339,7 @@ static int __init vrfb_probe(struct platform_device *pdev)
>  	int i;
>  
>  	/* first resource is the register res, the rest are vrfb contexts */
> -
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	vrfb_base = devm_ioremap_resource(&pdev->dev, mem);
> +	vrfb_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(vrfb_base))
>  		return PTR_ERR(vrfb_base);
>  
