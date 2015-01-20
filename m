From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 12/14] mfd: tps65218: Constify struct regmap_config
Date: Tue, 20 Jan 2015 11:59:37 +0000
Message-ID: <20150120115937.GX13701@x1>
References: <1420448493-9355-1-git-send-email-k.kozlowski@samsung.com>
 <1420448493-9355-12-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420448493-9355-12-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 05 Jan 2015, Krzysztof Kozlowski wrote:

> The regmap_config struct may be const because it is not modified by t=
he
> driver and regmap_init() accepts pointer to const.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> ---
>  drivers/mfd/tps65218.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied with Tony's Ack, thanks.

> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 0d256cb002eb..b019b3198afe 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -125,7 +125,7 @@ int tps65218_clear_bits(struct tps65218 *tps, uns=
igned int reg,
>  }
>  EXPORT_SYMBOL_GPL(tps65218_clear_bits);
> =20
> -static struct regmap_config tps65218_regmap_config =3D {
> +static const struct regmap_config tps65218_regmap_config =3D {
>  	.reg_bits =3D 8,
>  	.val_bits =3D 8,
>  	.cache_type =3D REGCACHE_RBTREE,

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
