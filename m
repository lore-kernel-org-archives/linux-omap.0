From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC PATCH v2 4/7] i2c: demux: WIP: handle the new atomic
 callbacks
Date: Fri, 15 Mar 2019 13:32:49 +0100
Message-ID: <20190315123249.mlymbgwi3rxtt4d3@verge.net.au>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-5-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190302134735.4393-5-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Phil Reid <preid@electromag.com.au>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Stefan Lengfeld <contact@stefanchrist.eu>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 02, 2019 at 02:47:32PM +0100, Wolfram Sang wrote:
> If the parent has an atomic callback, we need to translate it the same
> way as the non-atomic callback.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/i2c/muxes/i2c-demux-pinctrl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> index 035032e20327..5d00adfbe578 100644
> --- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
> +++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> @@ -99,6 +99,9 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
>  
>  	/* Now fill out current adapter structure. cur_chan must be up to date */
>  	priv->algo.master_xfer = i2c_demux_master_xfer;
> +	/* FIXME: regular muxes need proper handling, too! */
> +	if (adap->algo->master_xfer_atomic)
> +		priv->algo.master_xfer_atomic = i2c_demux_master_xfer;
>  	priv->algo.functionality = i2c_demux_functionality;
>  
>  	snprintf(priv->cur_adap.name, sizeof(priv->cur_adap.name),
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
