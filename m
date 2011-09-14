From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v7 14/26] gpio/omap: remove unnecessary bit-masking for
 read access
Date: Wed, 14 Sep 2011 15:19:38 +0400
Message-ID: <4E708DCA.3090606@ru.mvista.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com> <1315918979-26173-15-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42706 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756483Ab1INLU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 07:20:26 -0400
Received: by wwf22 with SMTP id 22so2087378wwf.1
        for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 04:20:25 -0700 (PDT)
In-Reply-To: <1315918979-26173-15-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

Hello.

On 13-09-2011 17:02, Tarun Kanti DebBarma wrote:

> Remove un-necessary bit masking. Since the register are 4 byte aligned
> and readl would work as is. The 'enabled' mask is already taking care
> to mask for bank width.

> Signed-off-by: Charulatha V<charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> ---
>   drivers/gpio/gpio-omap.c |    2 --
>   1 files changed, 0 insertions(+), 2 deletions(-)

> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 876e387..d614c6d 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -571,8 +571,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>   		enabled = _get_gpio_irqbank_mask(bank);
>   		isr_saved = isr = __raw_readl(isr_reg)&  enabled;
>
> -		if (cpu_is_omap15xx()&&  (bank->method == METHOD_MPUIO))
> -			isr&= 0x0000ffff;
>

    Should have removed the now unneeded empty line too.

>   		if (bank->level_mask)
>   			level_mask = bank->level_mask&  enabled;

WBR, Sergei
