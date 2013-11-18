From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] input: touchscreen: ti_am335x_tsc: warn about
 incorrect spelling
Date: Mon, 18 Nov 2013 15:35:52 +0000
Message-ID: <20131118153552.GA3896@e106331-lin.cambridge.arm.com>
References: <20131118114029.GD30853@e106331-lin.cambridge.arm.com>
 <1384788541-16338-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:53887 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751203Ab3KRPgF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 10:36:05 -0500
Content-Disposition: inline
In-Reply-To: <1384788541-16338-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "bcousson@baylibre.com" <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Nov 18, 2013 at 03:29:01PM +0000, Felipe Balbi wrote:
> In the hopes that people run new kernels on
> their devices, let's add a warning message
> asking users to have their DTS file fixed.
> 
> The goal is that by Linux 4.0 we will be
> able to remove support for the bogus version
> of our touchscreen's DTS.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Here you go, I've added your Suggested-by Mark,
> if you wish I can remove or change to something
> else.
> 
> cheers

Looks fine to me, feel free to add my Ack.

Thanks,
Mark.

> 
>  drivers/input/touchscreen/ti_am335x_tsc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index b61df9d..91302cd 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -354,9 +354,12 @@ static int titsc_parse_dt(struct platform_device *pdev,
>  	 */
>  	err = of_property_read_u32(node, "ti,coordinate-readouts",
>  			&ts_dev->coordinate_readouts);
> -	if (err < 0)
> +	if (err < 0) {
> +		dev_warn(&pdev->dev, "please use 'ti,coordinate-readouts' instead\n");
>  		err = of_property_read_u32(node, "ti,coordiante-readouts",
>  				&ts_dev->coordinate_readouts);
> +	}
> +
>  	if (err < 0)
>  		return err;
>  
> -- 
> 1.8.4.GIT
> 
> 
