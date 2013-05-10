From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 38/42] arch/arm/plat-omap: don't check resource with
 devm_ioremap_resource
Date: Fri, 10 May 2013 09:46:18 -0700
Message-ID: <20130510164617.GK31554@atomide.com>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-39-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1368173847-5661-39-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Wolfram Sang <wsa@the-dreams.de> [130510 01:23]:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/plat-omap/dmtimer.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 869254c..da1a3f7 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -814,12 +814,6 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (unlikely(!mem)) {
> -		dev_err(dev, "%s: no memory resource.\n", __func__);
> -		return -ENODEV;
> -	}
> -
>  	timer = devm_kzalloc(dev, sizeof(struct omap_dm_timer), GFP_KERNEL);
>  	if (!timer) {
>  		dev_err(dev, "%s: memory alloc failed!\n", __func__);
> @@ -827,6 +821,7 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
>  	}
>  
>  	timer->fclk = ERR_PTR(-ENODEV);
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	timer->io_base = devm_ioremap_resource(dev, mem);
>  	if (IS_ERR(timer->io_base))
>  		return PTR_ERR(timer->io_base);
> -- 
> 1.7.10.4
> 
