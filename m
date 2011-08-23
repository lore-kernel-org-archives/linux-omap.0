From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 15/22] gpio/omap: use readl in irq_handler for all
 access
Date: Tue, 23 Aug 2011 19:55:44 +0530
Message-ID: <4E53B868.4060500@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-16-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:43446 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752525Ab1HWOZx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 10:25:53 -0400
Received: by yxk38 with SMTP id 38so171353yxk.40
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 07:25:50 -0700 (PDT)
In-Reply-To: <1312455893-14922-16-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> Even when bank->width is 16, all the OMAP1 registers are 4-byte aligned, so just
> use a 4-byte read.  The 'enabled' mask is already taking care to mask for bank width.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---

Patch $SUBJECT and the change don't match.

May be you want to say remove un-necessary bit masking since
the register are 4 byte aligned and readl would work as is.

>   drivers/gpio/gpio-omap.c |    2 --
>   1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 3d18cdf..ba20e42 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -572,8 +572,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>   		enabled = _get_gpio_irqbank_mask(bank);
>   		isr_saved = isr = __raw_readl(isr_reg)&  enabled;
>
> -		if (cpu_is_omap15xx()&&  (bank->method == METHOD_MPUIO))
> -			isr&= 0x0000ffff;
>
>   		if (bank->level_mask)
>   			level_mask = bank->level_mask&  enabled;

