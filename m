From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 05/12] i2c: demux: handle the new atomic callbacks
Date: Mon, 15 Apr 2019 15:37:44 +0300
Message-ID: <CAHp75VcnwMpWWDdg=y2z7N84kr8ZpUXW9un3UxB3uA__F56tGQ@mail.gmail.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com> <20190403124019.8947-6-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403124019.8947-6-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Peter Rosin <peda@axentia.se>, Stefan Lengfeld <contact@stefanchrist.eu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 3, 2019 at 3:42 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> If the parent has an atomic callback, we need to translate it the same
> way as the non-atomic callback.
>

Reviewed-by Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/muxes/i2c-demux-pinctrl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> index 035032e20327..d50454c565ee 100644
> --- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
> +++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> @@ -99,6 +99,8 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
>
>         /* Now fill out current adapter structure. cur_chan must be up to date */
>         priv->algo.master_xfer = i2c_demux_master_xfer;
> +       if (adap->algo->master_xfer_atomic)
> +               priv->algo.master_xfer_atomic = i2c_demux_master_xfer;
>         priv->algo.functionality = i2c_demux_functionality;
>
>         snprintf(priv->cur_adap.name, sizeof(priv->cur_adap.name),
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
