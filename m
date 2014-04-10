From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 0/5] GPIO OMAP driver changes for v3.16
Date: Fri, 11 Apr 2014 00:22:02 +0300
Message-ID: <20140410212202.GF15736@drone.musicnaut.iki.fi>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
 <CACRpkdarYt4tAD9WMDu6Me+dhipVyDHMpgF-AQ8SDNKMmhSjsA@mail.gmail.com>
 <20140410193048.GE15736@drone.musicnaut.iki.fi>
 <CABxcv=miFY3gE6HOU5ovWwCzgC6Un3ANh_Weh_bPCb7OoYQ+pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:34805 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935282AbaDJV0T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2014 17:26:19 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=miFY3gE6HOU5ovWwCzgC6Un3ANh_Weh_bPCb7OoYQ+pA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On Thu, Apr 10, 2014 at 10:17:44PM +0200, Javier Martinez Canillas wrote:
> > The same happens also on Nokia 770:
> >
> > [    0.118896] genirq: Setting trigger mode 0 for irq 128 failed (gpio_irq_type+0x0/0x220)
> 
> I don't have those errors when booting on my DM3730 IGEPv2 board but
> it seems that for some reason on omap1  __irq_set_trigger() complains
> when IRQ_TYPE_NONE is used as a default flag when calling
> gpiochip_irqchip_add()
> 
> Could you please test the following patch and tell me if your board
> still works and makes the errors go away?

Now it complains about mode 8...

[    0.118835] genirq: Setting trigger mode 8 for irq 128 failed (gpio_irq_type
+0x0/0x220)

A.

> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 8cc9e91..5bc8aec 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1122,7 +1122,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank)
> 
>         ret = gpiochip_irqchip_add(&bank->chip, &gpio_irq_chip,
>                                    irq_base, gpio_irq_handler,
> -                                  IRQ_TYPE_NONE);
> +                                  IRQ_TYPE_LEVEL_LOW);
> 
>         if (ret) {
>                 dev_err(bank->dev, "Couldn't add irqchip to gpiochip
> %d\n", ret);
> 
> Best regards,
> Javier
