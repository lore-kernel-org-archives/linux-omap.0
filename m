From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH] ti_tscadc: Match mfd sub devices to regmap interface
Date: Tue, 30 Oct 2012 19:21:37 +0100
Message-ID: <50901AB1.6040005@metafoo.de>
References: <1351698945-3881-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351698945-3881-1-git-send-email-panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/31/2012 04:55 PM, Pantelis Antoniou wrote:
> The MFD parent device now uses a regmap, instead of direct
> memory access. Use the same method in the sub devices to avoid
> nasty surprises.
> 
> Also rework the channel initialization of tiadc a bit.

Those two bits are not even closely related, they should really go into
separate patches.

> 
> Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
> ---
>  drivers/iio/adc/ti_am335x_adc.c           | 27 +++++++++++++++++++--------
>  drivers/input/touchscreen/ti_am335x_tsc.c | 16 +++++++++++++---
>  drivers/mfd/ti_am335x_tscadc.c            |  7 +++++--
>  3 files changed, 37 insertions(+), 13 deletions(-)
> 
[...]
>  
> @@ -213,6 +222,8 @@ static int __devinit tiadc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> +	dev_info(&pdev->dev, "Initialized\n");

That's just noise, please don't add it. Imagine every driver did this you'd
end up with a lot of noise your debug log.

> +
>  	return 0;
>  
>  err_free_channels:
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index 7a26810..d09e1a7 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -26,6 +26,7 @@
[...]
>  /*
> @@ -455,10 +460,15 @@ static int __devinit titsc_probe(struct platform_device *pdev)
>  
>  	/* register to the input system */
>  	err = input_register_device(input_dev);
> -	if (err)
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to register input device\n");
>  		goto err_free_irq;
> +	}
>  
>  	platform_set_drvdata(pdev, ts_dev);
> +
> +	dev_info(&pdev->dev, "Initialized OK\n");

Same here
