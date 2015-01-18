From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] mfd: tps65218: make INT[12] and STATUS registers
 volatile
Date: Sun, 18 Jan 2015 09:52:14 +0000
Message-ID: <20150118095214.GA3574@x1>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419622104-25812-2-git-send-email-balbi@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 26 Dec 2014, Felipe Balbi wrote:

> STATUS register can be modified by the HW, so we
> should bypass cache because of that.
>=20
> In the case of INT[12] registers, they are the ones
> that actually clear the IRQ source at the time they
> are read. If we rely on the cache for them, we will
> never be able to clear the interrupt, which will cause
> our IRQ line to be disabled due to IRQ throttling.
>=20
> Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
> Cc: <stable@vger.kernel.org> # v3.15+
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/tps65218.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Sorry for the delay.  It's difficult to get a WiFi signal 2000m up in
an Austrian mountain. :)

Applied now, thanks.

> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 0d256cb..2243f75 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -125,10 +125,21 @@ int tps65218_clear_bits(struct tps65218 *tps, u=
nsigned int reg,
>  }
>  EXPORT_SYMBOL_GPL(tps65218_clear_bits);
> =20
> +static const struct regmap_range tps65218_yes_ranges[] =3D {
> +	regmap_reg_range(TPS65218_REG_INT1, TPS65218_REG_INT2),
> +	regmap_reg_range(TPS65218_REG_STATUS, TPS65218_REG_STATUS),
> +};
> +
> +static const struct regmap_access_table tps65218_volatile_table =3D =
{
> +	.yes_ranges =3D tps65218_yes_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(tps65218_yes_ranges),
> +};
> +
>  static struct regmap_config tps65218_regmap_config =3D {
>  	.reg_bits =3D 8,
>  	.val_bits =3D 8,
>  	.cache_type =3D REGCACHE_RBTREE,
> +	.volatile_table =3D &tps65218_volatile_table,
>  };
> =20
>  static const struct regmap_irq tps65218_irqs[] =3D {

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
