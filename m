From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/5] mfd: tps65217: Add power button as subdevice
Date: Mon, 11 Apr 2016 10:44:52 +0100
Message-ID: <20160411094452.GC8094@x1>
References: <1459789865-3704-1-git-send-email-m.niestroj@grinn-global.com>
 <1459789865-3704-6-git-send-email-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459789865-3704-6-git-send-email-m.niestroj@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 04 Apr 2016, Marcin Niestroj wrote:

> Add tps65217 power buttor subdevice with assigned IRQ resources.
>=20
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---
>  drivers/mfd/tps65217.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index a20980f..fd3b5d8 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -38,6 +38,10 @@ static struct resource charger_resources[] =3D {
>  	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_USB, "USB"),
>  };
> =20
> +static struct resource pb_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_PB, "PB"),
> +};
> +
>  struct tps65217_irq {
>  	int mask;
>  	int interrupt;
> @@ -122,6 +126,12 @@ static struct mfd_cell tps65217s[] =3D {
>  		.resources =3D charger_resources,
>  		.of_compatible =3D "ti,tps65217-charger",
>  	},
> +	{
> +		.name =3D "tps65217-pwrbutton",
> +		.num_resources =3D ARRAY_SIZE(pb_resources),
> +		.resources =3D pb_resources,
> +		.of_compatible =3D "ti,tps65217-pwrbutton",
> +	},
>  };
> =20
>  static irqreturn_t tps65217_irq_thread(int irq, void *data)

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
