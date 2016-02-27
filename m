From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/7] iio: adc: palmas: Drop IRQF_EARLY_RESUME flag
Date: Sat, 27 Feb 2016 17:21:29 +0000
Message-ID: <56D1DB19.5030504@kernel.org>
References: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
 <1456501377-16871-8-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456501377-16871-8-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 26/02/16 15:42, Grygorii Strashko wrote:
> Palmas gpadc IRQs are nested threaded and this flag is not required for nested
> irqs anymore, since commit 3c646f2c6aa9 ("genirq: Don't suspend nested_thread
> irqs over system suspend") was merged.
> 
> Cc: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
> Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
> Cc: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/palmas_gpadc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index f42eb8a..2bbf0c5 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -534,7 +534,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
>  	}
>  	ret = request_threaded_irq(adc->irq, NULL,
>  		palmas_gpadc_irq,
> -		IRQF_ONESHOT | IRQF_EARLY_RESUME, dev_name(adc->dev),
> +		IRQF_ONESHOT, dev_name(adc->dev),
>  		adc);
>  	if (ret < 0) {
>  		dev_err(adc->dev,
> @@ -549,7 +549,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
>  		adc->irq_auto_0 =  platform_get_irq(pdev, 1);
>  		ret = request_threaded_irq(adc->irq_auto_0, NULL,
>  				palmas_gpadc_irq_auto,
> -				IRQF_ONESHOT | IRQF_EARLY_RESUME,
> +				IRQF_ONESHOT,
>  				"palmas-adc-auto-0", adc);
>  		if (ret < 0) {
>  			dev_err(adc->dev, "request auto0 irq %d failed: %d\n",
> @@ -565,7 +565,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
>  		adc->irq_auto_1 =  platform_get_irq(pdev, 2);
>  		ret = request_threaded_irq(adc->irq_auto_1, NULL,
>  				palmas_gpadc_irq_auto,
> -				IRQF_ONESHOT | IRQF_EARLY_RESUME,
> +				IRQF_ONESHOT,
>  				"palmas-adc-auto-1", adc);
>  		if (ret < 0) {
>  			dev_err(adc->dev, "request auto1 irq %d failed: %d\n",
> 
