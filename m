From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] CBUS: A workaround for ADC S/H HW bug: always keep ch
	8 selected when S/H is used
Date: Thu, 3 Jul 2008 13:20:07 +0300
Message-ID: <20080703102005.GG14276@atomide.com>
References: <1214832497-23911-1-git-send-email-mikko.k.ylinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58789 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbYGCMV1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:21:27 -0400
Content-Disposition: inline
In-Reply-To: <1214832497-23911-1-git-send-email-mikko.k.ylinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Cc: linux-omap@vger.kernel.org

* Mikko Ylinen <mikko.k.ylinen@nokia.com> [080630 16:34]:

Pushing today.

Tony

> Signed-off-by: Mikko Ylinen <mikko.k.ylinen@nokia.com>
> ---
>  drivers/cbus/retu.c |   12 ++++++++++++
>  drivers/cbus/retu.h |    1 +
>  2 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
> index 715b88d..4849841 100644
> --- a/drivers/cbus/retu.c
> +++ b/drivers/cbus/retu.c
> @@ -114,9 +114,21 @@ int retu_read_adc(int channel)
>  		return -EINVAL;
>  
>  	spin_lock_irqsave(&retu_lock, flags);
> +
> +	if ((channel == 8) && retu_is_vilma) {
> +		int scr = retu_read_reg(RETU_REG_ADCSCR);
> +		int ch = (retu_read_reg(RETU_REG_ADCR) >> 10) & 0xf;
> +		if (((scr & 0xff) != 0) && (ch != 8))
> +			retu_write_reg (RETU_REG_ADCSCR, (scr & ~0xff));
> +	}
> +
>  	/* Select the channel and read result */
>  	retu_write_reg(RETU_REG_ADCR, channel << 10);
>  	res = retu_read_reg(RETU_REG_ADCR) & 0x3ff;
> +
> +	if (retu_is_vilma)
> +		retu_write_reg(RETU_REG_ADCR, (1 << 13));
> +
>  	/* Unlock retu */
>  	spin_unlock_irqrestore(&retu_lock, flags);
>  
> diff --git a/drivers/cbus/retu.h b/drivers/cbus/retu.h
> index 49f23e6..c9e044c 100644
> --- a/drivers/cbus/retu.h
> +++ b/drivers/cbus/retu.h
> @@ -34,6 +34,7 @@
>  #define RETU_REG_RTCHMAR	0x05	/* RTC hours and minutes alarm and time set register */
>  #define RETU_REG_RTCCALR	0x06	/* RTC calibration register */
>  #define RETU_REG_ADCR		0x08	/* ADC result */
> +#define RETU_REG_ADCSCR		0x09	/* ADC sample ctrl */
>  #define RETU_REG_CC1		0x0d	/* Common control register 1 */
>  #define RETU_REG_CC2		0x0e	/* Common control register 2 */
>  #define RETU_REG_CTRL_CLR	0x0f	/* Regulator clear register */
> -- 
> 1.5.5.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
