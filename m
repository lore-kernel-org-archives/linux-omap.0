From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 09/26] ARM: OMAP: dmtimer: Get rid of check for mem
 resource error
Date: Wed, 7 May 2014 08:24:26 -0700
Message-ID: <20140507152426.GD9502@atomide.com>
References: <1398375849-6017-1-git-send-email-joelf@ti.com>
 <1398375849-6017-10-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398375849-6017-10-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Joel Fernandes <joelf@ti.com> [140424 14:44]:
> The subsequent devm_ioremap_resource will catch it and print an error, let it
> be checked there.
> 
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>  arch/arm/plat-omap/dmtimer.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 7e806f9..1fd30fa 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -810,10 +810,6 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
>  	}
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (unlikely(!mem)) {
> -		dev_err(dev, "%s: no memory resource.\n", __func__);
> -		return -ENODEV;
> -	}
>  
>  	timer = devm_kzalloc(dev, sizeof(struct omap_dm_timer), GFP_KERNEL);
>  	if (!timer) {

We still need to return an error here and not try to continue though.

Tony
