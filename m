From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl4030-power: Fix regression with missing
 compatible flag
Date: Mon, 3 Nov 2014 16:03:09 +0000
Message-ID: <20141103160309.GC10544@x1>
References: <20141102180938.GI31454@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141102180938.GI31454@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, 02 Nov 2014, Tony Lindgren wrote:

> Commit e7cd1d1eb16f ("mfd: twl4030-power: Add generic reset
> configuration") accidentally removed the compatible flag for
> "ti,twl4030-power" that should be there as documented in the
> binding.
>=20
> If "ti,twl4030-power" only the poweroff configuration is done
> by the driver.
>=20
> Fixes: e7cd1d1eb16f ("mfd: twl4030-power: Add generic reset configura=
tion")
> Cc: stable@vger.kernel.org # v3.16+
> Reported-by: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied, thanks.

> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -831,6 +831,9 @@ static struct twl4030_power_data osc_off_idle =3D=
 {
> =20
>  static struct of_device_id twl4030_power_of_match[] =3D {
>  	{
> +		.compatible =3D "ti,twl4030-power",
> +	},
> +	{
>  		.compatible =3D "ti,twl4030-power-reset",
>  		.data =3D &omap3_reset,
>  	},

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
