From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 4/5] mfd: tps65217: Add power button as subdevice
Date: Thu, 16 Jun 2016 15:30:44 +0100
Message-ID: <20160616143044.GZ4948@dell>
References: <20160616114110.23455-1-m.niestroj@grinn-global.com>
 <20160616114110.23455-5-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160616114110.23455-5-m.niestroj@grinn-global.com>
Sender: linux-pm-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 16 Jun 2016, Marcin Niestroj wrote:

> Add tps65217 power buttor subdevice with assigned IRQ resources.
>=20
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---
> depends on patch 1 in series
>=20
>  drivers/mfd/tps65217.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 7763dbc..d76de72 100644
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
