From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] mfd: Add battery charger as subdevice to the
 tps65217.
Date: Sun, 20 Sep 2015 05:19:53 +0100
Message-ID: <20150920041953.GV3039@x1>
References: <1441699779-22189-1-git-send-email-enric.balletbo@collabora.com>
 <1441699779-22189-4-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441699779-22189-4-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, tony@atomide.com, sameo@linux.intel.com, sjoerd.simons@collabora.co.uk, javier@dowhile0.org
List-Id: linux-omap@vger.kernel.org

On Tue, 08 Sep 2015, Enric Balletbo i Serra wrote:

> Add tps65217 battery charger subdevice.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/mfd/tps65217.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 55add04..d32b5442 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -39,6 +39,10 @@ static const struct mfd_cell tps65217s[] =3D {
>  		.name =3D "tps65217-bl",
>  		.of_compatible =3D "ti,tps65217-bl",
>  	},
> +	{
> +		.name =3D "tps65217-charger",
> +		.of_compatible =3D "ti,tps65217-charger",
> +	},
>  };
> =20
>  /**

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
