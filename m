From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/5] OMAP3: l3: fix omap3_l3_probe error path
Date: Wed, 30 Mar 2011 12:06:05 +0530
Message-ID: <4D92CF55.2070506@ti.com>
References: <1301419219-30547-1-git-send-email-omar.ramirez@ti.com> <1301419219-30547-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:38334 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754371Ab1C3GgZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 02:36:25 -0400
Received: by gyg8 with SMTP id 8so486373gyg.24
        for <linux-omap@vger.kernel.org>; Tue, 29 Mar 2011 23:36:23 -0700 (PDT)
In-Reply-To: <1301419219-30547-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, l-o <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, sricharan <r.sricharan@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>

On 3/29/2011 10:50 PM, Omar Ramirez Luna wrote:
> Add missing free_irq and remove an empty goto label.
>
> Safe to assume that if we reached the end point of execution
> without errors, then return value is 0, so replacing instead
> another goto.
>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> ---

The free_irq() change looks good. Other changes are not
necessary though because its is personnel choice to
return from one place or from every error path.

In both forms ...
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


>   arch/arm/mach-omap2/omap_l3_smx.c |   23 ++++++++++-------------
>   1 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
> index 4321e79..32961b1 100644
> --- a/arch/arm/mach-omap2/omap_l3_smx.c
> +++ b/arch/arm/mach-omap2/omap_l3_smx.c
> @@ -228,10 +228,8 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
>   	int                     ret;
>
>   	l3 = kzalloc(sizeof(*l3), GFP_KERNEL);
> -	if (!l3) {
> -		ret = -ENOMEM;
> -		goto err0;
> -	}
> +	if (!l3)
> +		return -ENOMEM;
>
>   	platform_set_drvdata(pdev, l3);
>
> @@ -239,13 +237,13 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
>   	if (!res) {
>   		dev_err(&pdev->dev, "couldn't find resource\n");
>   		ret = -ENODEV;
> -		goto err1;
> +		goto err0;
>   	}
>   	l3->rt = ioremap(res->start, resource_size(res));
>   	if (!(l3->rt)) {
>   		dev_err(&pdev->dev, "ioremap failed\n");
>   		ret = -ENOMEM;
> -		goto err2;
> +		goto err0;
>   	}
>
>   	l3->debug_irq = platform_get_irq(pdev, 0);
> @@ -254,7 +252,7 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
>   		"l3-debug-irq", l3);
>   	if (ret) {
>   		dev_err(&pdev->dev, "couldn't request debug irq\n");
> -		goto err3;
> +		goto err1;
>   	}
>
>   	l3->app_irq = platform_get_irq(pdev, 1);
> @@ -264,18 +262,17 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
>
>   	if (ret) {
>   		dev_err(&pdev->dev, "couldn't request app irq\n");
> -		goto err4;
> +		goto err2;
>   	}
>
> -	goto err0;
> +	return 0;
>
> -err4:
> -err3:
> -	iounmap(l3->rt);
>   err2:
> +	free_irq(l3->debug_irq, l3);
>   err1:
> -	kfree(l3);
> +	iounmap(l3->rt);
>   err0:
> +	kfree(l3);
>   	return ret;
>   }
>

