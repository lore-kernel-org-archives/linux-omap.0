From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] input: touchscreen: fix spelling mistake in TSC/ADC
 DT binding
Date: Tue, 22 Oct 2013 10:42:00 +0200
Message-ID: <52663A58.9070706@linutronix.de>
References: <1382386404-6659-1-git-send-email-balbi@ti.com> <1382386404-6659-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52392 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab3JVImO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Oct 2013 04:42:14 -0400
In-Reply-To: <1382386404-6659-2-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: dmitry.torokhov@gmail.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org

On 10/21/2013 10:13 PM, Felipe Balbi wrote:
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index e1c5300..b61df9d 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -348,9 +348,16 @@ static int titsc_parse_dt(struct platform_device *pdev,
>  	if (err < 0)
>  		return err;
>  
> -	err = of_property_read_u32(node, "ti,coordiante-readouts",
> +	/*
> +	 * try with new binding first. If it fails, still try with
> +	 * bogus, miss-spelled version.
> +	 */
> +	err = of_property_read_u32(node, "ti,coordinate-readouts",
>  			&ts_dev->coordinate_readouts);
>  	if (err < 0)
> +		err = of_property_read_u32(node, "ti,coordiante-readouts",
> +				&ts_dev->coordinate_readouts);
> +	if (err < 0)
>  		return err;

Thanks, very good. Do we keep this fallback for ever or just for a year
or two?

>  
>  	return of_property_read_u32_array(node, "ti,wire-config",

Sebastian
