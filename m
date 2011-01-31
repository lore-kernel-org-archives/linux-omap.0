From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] arm: Fix possible memory leak
Date: Mon, 31 Jan 2011 08:20:55 -0800
Message-ID: <87zkqh82oo.fsf@ti.com>
References: <1296415587-4524-1-git-send-email-weil@mail.berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296415587-4524-1-git-send-email-weil@mail.berlios.de> (Stefan
	Weil's message of "Sun, 30 Jan 2011 20:26:27 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Weil <weil@mail.berlios.de>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Stefan Weil <weil@mail.berlios.de> writes:

> sr_info was allocated and needs a kfree before returning.
>
> This error was reported by cppcheck:
> arch/arm/mach-omap2/smartreflex.c:837: error: Memory leak: sr_info
>
> To: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Stefan Weil <weil@mail.berlios.de>

Thanks, will queue this for 2.6.38-rc in my pm-fixes branch.

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index af39d17..07324607 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -832,7 +832,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>
>  	if (!pdata) {
>  		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_free_devinfo;
>  	}
>
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
