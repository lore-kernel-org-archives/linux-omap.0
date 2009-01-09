From: "Kainan Cha" <kainan.zha@gmail.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Fri, 9 Jan 2009 14:27:23 -0600
Message-ID: <c236f0530901091227n7361e2aeh9c5f52e250e79b4b@mail.gmail.com>
References: <12277070551136-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:26283 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756091AbZAIU1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 15:27:24 -0500
Received: by qw-out-2122.google.com with SMTP id 3so8654703qwe.37
        for <linux-omap@vger.kernel.org>; Fri, 09 Jan 2009 12:27:23 -0800 (PST)
In-Reply-To: <12277070551136-git-send-email-ext-eero.nurkkala@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: linux-omap@vger.kernel.org

Eero,

On Wed, Nov 26, 2008 at 7:44 AM,  <ext-eero.nurkkala@nokia.com> wrote:
> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
>
> The prescalers for 100 kHz and 400 kHz mode
> are wrong for omap 3430 and omap 2430. The
> internal clock is the fclock divided by the
> prescaler. The PSC is an 8 bit field in
> omap3430 and omap2430. Moreover, the scll and
> sclh values should be adjusted properly.
> Having the correct prescaler is important in
> the process of getting a finite i2c clock. In
> addition, the prescaler is used in the process
> of activating the correct noise filter and thus,
> lets more error resilient i2c communications.
>

This patch looks fine for omap3430. But when referring to omap2430
manual, the internal_clk does not seem to depend on the i2c modes. Can
you verify? My brief testing shows that i2c clock is broken for
omap2430 with this patch.

Also, in my manual for both omap2430 and omap3430, scll and sclh
values should be set like so:

                       fsscll = internal_clk / (dev->speed * 2) - 7;
                       fssclh = internal_clk / (dev->speed * 2) - 5;

Could you explain where you got your values from?

Regards,
Kainan Cha

> Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 630702c..c21af3f 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -337,7 +337,13 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>        if (cpu_is_omap2430() || cpu_is_omap34xx()) {
>
>                /* HSI2C controller internal clk rate should be 19.2 Mhz */
> -               internal_clk = 19200;
> +               if (dev->speed > 400)
> +                       internal_clk = 19200;
> +               else if (dev->speed > 100)
> +                       internal_clk = 9600;
> +               else
> +                       internal_clk = 4000;
> +
>                fclk_rate = clk_get_rate(dev->fclk) / 1000;
>
>                /* Compute prescaler divisor */
> @@ -355,8 +361,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>                        hssclh = fclk_rate / (dev->speed * 2) - 6;
>                } else {
>                        /* To handle F/S modes */
> -                       fsscll = internal_clk / (dev->speed * 2) - 6;
> -                       fssclh = internal_clk / (dev->speed * 2) - 6;
> +                       fsscll = internal_clk / (dev->speed * 2) - 3;
> +                       fssclh = internal_clk / (dev->speed * 2) - 9;
>                }
>                scll = (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
>                sclh = (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;
> --
> 1.6.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
