From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Store switch state for OUTPUT gpio-switches
Date: Thu, 3 Jul 2008 13:20:29 +0300
Message-ID: <20080703102027.GH14276@atomide.com>
References: <1214832774-24114-1-git-send-email-mikko.k.ylinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53963 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbYGCMPU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:15:20 -0400
Content-Disposition: inline
In-Reply-To: <1214832774-24114-1-git-send-email-mikko.k.ylinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Cc: linux-omap@vger.kernel.org

* Mikko Ylinen <mikko.k.ylinen@nokia.com> [080630 16:35]:

Pushing today.

Tony

> Signed-off-by: Mikko Ylinen <mikko.k.ylinen@nokia.com>
> ---
>  arch/arm/plat-omap/gpio-switch.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/gpio-switch.c b/arch/arm/plat-omap/gpio-switch.c
> index cd96c00..7a61d0e 100644
> --- a/arch/arm/plat-omap/gpio-switch.c
> +++ b/arch/arm/plat-omap/gpio-switch.c
> @@ -131,11 +131,12 @@ static ssize_t gpio_sw_state_store(struct device *dev,
>  
>  	str = get_sw_str(sw);
>  	if (strcmp(state, str[0]) == 0)
> -		enable = 0;
> +		sw->state = enable = 0;
>  	else if (strcmp(state, str[1]) == 0)
> -		enable = 1;
> +		sw->state = enable = 1;
>  	else
>  		return -EINVAL;
> +
>  	if (sw->flags & OMAP_GPIO_SWITCH_FLAG_INVERTED)
>  		enable = !enable;
>  	omap_set_gpio_dataout(sw->gpio, enable);
> -- 
> 1.5.5.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
