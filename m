From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] mfd: twl6040: Check clk_prepare_enable() return
 value in twl6040_power()
Date: Mon, 25 Apr 2016 17:18:48 +0100
Message-ID: <20160425161848.GL2713@dell>
References: <1461165398-12289-1-git-send-email-javier@osg.samsung.com>
 <1461165398-12289-2-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461165398-12289-2-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 20 Apr 2016, Javier Martinez Canillas wrote:

> The clk_prepare_enable() function can fail so check the return
> value and propagate the error in case of a failure.
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>=20
> ---
>=20
>  drivers/mfd/twl6040.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> index 4de92c16dfb8..852d5874aabb 100644
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -291,7 +291,11 @@ int twl6040_power(struct twl6040 *twl6040, int o=
n)
>  		if (twl6040->power_count++)
>  			goto out;
> =20
> -		clk_prepare_enable(twl6040->clk32k);
> +		ret =3D clk_prepare_enable(twl6040->clk32k);
> +		if (ret) {
> +			twl6040->power_count =3D 0;
> +			goto out;
> +		}
> =20
>  		/* Allow writes to the chip */
>  		regcache_cache_only(twl6040->regmap, false);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
