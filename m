From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 11/14] mfd: tps65217: Constify struct regmap_config
Date: Tue, 20 Jan 2015 11:59:20 +0000
Message-ID: <20150120115920.GW13701@x1>
References: <1420448493-9355-1-git-send-email-k.kozlowski@samsung.com>
 <1420448493-9355-11-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420448493-9355-11-git-send-email-k.kozlowski@samsung.com>
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
>  drivers/mfd/tps65217.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied with Tony's Ack, thanks.

> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 80a919a8ca97..7d1cfc1d3ce0 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -145,7 +145,7 @@ int tps65217_clear_bits(struct tps65217 *tps, uns=
igned int reg,
>  }
>  EXPORT_SYMBOL_GPL(tps65217_clear_bits);
> =20
> -static struct regmap_config tps65217_regmap_config =3D {
> +static const struct regmap_config tps65217_regmap_config =3D {
>  	.reg_bits =3D 8,
>  	.val_bits =3D 8,
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
