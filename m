From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 04/12] i2c: mux: populate the new *_atomic callbacks
Date: Mon, 15 Apr 2019 15:44:50 +0300
Message-ID: <CAHp75Vfp_1g-DuTx1mR3bF21qxj47d-+N-JhQyBaXD9cumPB6Q@mail.gmail.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com> <20190403124019.8947-5-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403124019.8947-5-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Peter Rosin <peda@axentia.se>, Stefan Lengfeld <contact@stefanchrist.eu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 3, 2019 at 3:42 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> If the parent adapter has atomic_xfer callbacks, populate them for the
> mux adapter as well. We can use the same translation function as for the
> non-atomic xfer callback.
>

Reviewed-by Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/i2c-mux.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index f330690b4125..603252fa1284 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -310,12 +310,18 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>                 else
>                         priv->algo.master_xfer = __i2c_mux_master_xfer;
>         }
> +       if (parent->algo->master_xfer_atomic)
> +               priv->algo.master_xfer_atomic = priv->algo.master_xfer;
> +
>         if (parent->algo->smbus_xfer) {
>                 if (muxc->mux_locked)
>                         priv->algo.smbus_xfer = i2c_mux_smbus_xfer;
>                 else
>                         priv->algo.smbus_xfer = __i2c_mux_smbus_xfer;
>         }
> +       if (parent->algo->smbus_xfer_atomic)
> +               priv->algo.smbus_xfer_atomic = priv->algo.smbus_xfer;
> +
>         priv->algo.functionality = i2c_mux_functionality;
>
>         /* Now fill out new adapter structure */
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
