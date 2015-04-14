From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] genirq: provide dummy set_irq_wake()
Date: Tue, 14 Apr 2015 13:13:27 +0300
Message-ID: <552CE847.7060103@ti.com>
References: <1427721345-6402-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45319 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788AbbDNKOo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2015 06:14:44 -0400
In-Reply-To: <1427721345-6402-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tglx@linutronix.de
Cc: cw00.choi@samsung.com, balbi@ti.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Thomas,

On 30/03/15 16:15, Roger Quadros wrote:
> Without this system suspend is broken on systems that have
> drivers calling enable/disable_irq_wake() for interrupts based off
> the dummy irq hook.
> (e.g. drivers/gpio/gpio-pcf857x.c)
> 
> http://article.gmane.org/gmane.linux.kernel/1879035
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Any comments on this patch?

cheers,
-roger

> ---
>  kernel/irq/dummychip.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/irq/dummychip.c b/kernel/irq/dummychip.c
> index 988dc58..2405d7a 100644
> --- a/kernel/irq/dummychip.c
> +++ b/kernel/irq/dummychip.c
> @@ -32,6 +32,11 @@ static unsigned int noop_ret(struct irq_data *data)
>  	return 0;
>  }
>  
> +static int noop_int_ret(struct irq_data *data, unsigned int val)
> +{
> +	return 0;
> +}
> +
>  /*
>   * Generic no controller implementation
>   */
> @@ -57,5 +62,6 @@ struct irq_chip dummy_irq_chip = {
>  	.irq_ack	= noop,
>  	.irq_mask	= noop,
>  	.irq_unmask	= noop,
> +	.irq_set_wake	= noop_int_ret,
>  };
>  EXPORT_SYMBOL_GPL(dummy_irq_chip);
> 

