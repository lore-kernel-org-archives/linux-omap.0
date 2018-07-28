From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] pwm: pwm-omap-dmtimer: fix probing problems by returning
 EPROBE_DEFER
Date: Sat, 28 Jul 2018 22:35:02 +0200
Message-ID: <20180728203501.GA16194@lenoch>
References: <20180728165914.15871-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23993008AbeG1UfEv2NCH (ORCPT <rfc822;linux-omap@vger.kernel.org>
        + 2 others); Sat, 28 Jul 2018 22:35:04 +0200
Content-Disposition: inline
In-Reply-To: <20180728165914.15871-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, j-keerthy@ti.com, tony@atomide.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Andreas,

On Sat, Jul 28, 2018 at 06:59:14PM +0200, Andreas Kemnade wrote:
> I got this in the kernel log:
> [    0.756042] omap-dmtimer-pwm dmtimer-pwm: dmtimer pdata structure NULL
> [    0.756134] omap-dmtimer-pwm: probe of dmtimer-pwm failed with error -22
> 
> the probe function has to wait until omap_dm_timer_probe() in
> clocksource/timer-ti-dm.c has initialized pdata, so defer probing

There already is a patch by David Rivshin addressing the same issue...

> Fixes: b7290cf6ff78 (pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtimer pdata ops)
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> index 665da3c8fbce..808835179c2e 100644
> --- a/drivers/pwm/pwm-omap-dmtimer.c
> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> @@ -264,8 +264,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>  
>  	timer_pdata = dev_get_platdata(&timer_pdev->dev);
>  	if (!timer_pdata) {
> -		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
> -		ret = -EINVAL;
> +		ret = -EPROBE_DEFER;
>  		goto put;
>  	}
>  
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
