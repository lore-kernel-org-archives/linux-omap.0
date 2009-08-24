From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 1/3] OMAP: McBSP: Use textual values in DMA operating
 mode sysfs files
Date: Mon, 24 Aug 2009 09:49:41 +0300
Message-ID: <20090824064941.GA24398@esdhcp037198.research.nokia.com>
References: <1251019467-11677-1-git-send-email-jhnikula@gmail.com>
 <1251019467-11677-2-git-send-email-jhnikula@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29876 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbZHXHDn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 03:03:43 -0400
Content-Disposition: inline
In-Reply-To: <1251019467-11677-2-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "tony@atomide.com" <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>

Hello Jarkko,

On Sun, Aug 23, 2009 at 11:24:25AM +0200, Jarkko Nikula wrote:
> Use more descriptive than numerical value when showing and storing the
> McBSP DMA operating mode. Show function is using similar syntax than e.g.
> the led triggers so that all possible values for store function are
> printed but with current value surrounded with square brackets.

I liked the idea as I said before. But let's try to improve it a bit.

> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |   52 ++++++++++++++++++++++++-------------------
>  1 files changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index b63a720..28e29b9 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -1161,25 +1161,31 @@ static DEVICE_ATTR(prop, 0644, prop##_show, prop##_store);
>  THRESHOLD_PROP_BUILDER(max_tx_thres);
>  THRESHOLD_PROP_BUILDER(max_rx_thres);
>  
> +static const char *dma_op_modes[] = {
> +	"element", "threshold", "frame",
> +};
> +
>  static ssize_t dma_op_mode_show(struct device *dev,
>  			struct device_attribute *attr, char *buf)
>  {
>  	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
> -	int dma_op_mode;
> +	int dma_op_mode, i = 0;
> +	ssize_t len = 0;
> +	const char * const *s;
>  
>  	spin_lock_irq(&mcbsp->lock);
>  	dma_op_mode = mcbsp->dma_op_mode;
>  	spin_unlock_irq(&mcbsp->lock);
>  
> -	return sprintf(buf, "current mode: %d\n"
> -			"possible mode values are:\n"
> -			"%d - %s\n"
> -			"%d - %s\n"
> -			"%d - %s\n",
> -			dma_op_mode,
> -			MCBSP_DMA_MODE_ELEMENT, "element mode",
> -			MCBSP_DMA_MODE_THRESHOLD, "threshold mode",
> -			MCBSP_DMA_MODE_FRAME, "frame mode");
> +	for (s = &dma_op_modes[i]; i < ARRAY_SIZE(dma_op_modes); s++, i++) {
> +		if (dma_op_mode == i)
> +			len += sprintf(buf + len, "[%s] ", *s);
> +		else
> +			len += sprintf(buf + len, "%s ", *s);
> +	}
> +	len += sprintf(len+buf, "\n");

Just a tiny thing, add spaces before and after + operator:
+	len += sprintf(len + buf, "\n");

> +
> +	return len;
>  }
>  
>  static ssize_t dma_op_mode_store(struct device *dev,
> @@ -1187,26 +1193,26 @@ static ssize_t dma_op_mode_store(struct device *dev,
>  				const char *buf, size_t size)
>  {
>  	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
> -	unsigned long val;
> -	int status;
> +	const char * const *s;
> +	char *p;
> +	int len, i = 0;
>  
> -	status = strict_strtoul(buf, 0, &val);
> -	if (status)
> -		return status;
> +	p = memchr(buf, '\n', size);
> +	len = p ? p - buf : size;

I guess here we have two better options, please use one of these:
* strstrip
* sysfs_streq

>  
> -	spin_lock_irq(&mcbsp->lock);
> +	for (s = &dma_op_modes[i]; i < ARRAY_SIZE(dma_op_modes); s++, i++)
> +		if (*s && len == strlen(*s) && !strncmp(buf, *s, len))

how about using strnicmp ??

> +			break;
>  
> +	if (i == ARRAY_SIZE(dma_op_modes))
> +		return -EINVAL;
> +
> +	spin_lock_irq(&mcbsp->lock);
>  	if (!mcbsp->free) {
>  		size = -EBUSY;
>  		goto unlock;
>  	}
> -
> -	if (val > MCBSP_DMA_MODE_FRAME || val < MCBSP_DMA_MODE_ELEMENT) {
> -		size = -EINVAL;
> -		goto unlock;
> -	}
> -
> -	mcbsp->dma_op_mode = val;
> +	mcbsp->dma_op_mode = i;
>  
>  unlock:
>  	spin_unlock_irq(&mcbsp->lock);
> -- 
> 1.6.3.3

-- 
Eduardo Valentin
