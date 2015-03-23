From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 21/35 linux-next] mfd: constify of_device_id array
Date: Mon, 23 Mar 2015 12:29:23 +0000
Message-ID: <20150323122923.GB24804@x1>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533710-25687-1-git-send-email-fabf@skynet.be>
 <1426533710-25687-2-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426533710-25687-2-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 16 Mar 2015, Fabian Frederick wrote:

> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>=20
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  drivers/mfd/hi6421-pmic-core.c | 2 +-
>  drivers/mfd/rk808.c            | 2 +-
>  drivers/mfd/twl4030-power.c    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/hi6421-pmic-core.c b/drivers/mfd/hi6421-pmic=
-core.c
> index 7210ae2..95b2ff8 100644
> --- a/drivers/mfd/hi6421-pmic-core.c
> +++ b/drivers/mfd/hi6421-pmic-core.c
> @@ -93,7 +93,7 @@ static int hi6421_pmic_remove(struct platform_devic=
e *pdev)
>  	return 0;
>  }
> =20
> -static struct of_device_id of_hi6421_pmic_match_tbl[] =3D {
> +static const struct of_device_id of_hi6421_pmic_match_tbl[] =3D {
>  	{ .compatible =3D "hisilicon,hi6421-pmic", },
>  	{ },
>  };
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index 7cf25c7..4b1e439 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -246,7 +246,7 @@ static int rk808_remove(struct i2c_client *client=
)
>  	return 0;
>  }
> =20
> -static struct of_device_id rk808_of_match[] =3D {
> +static const struct of_device_id rk808_of_match[] =3D {
>  	{ .compatible =3D "rockchip,rk808" },
>  	{ },
>  };
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.=
c
> index 3935092..f440aed 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -829,7 +829,7 @@ static struct twl4030_power_data osc_off_idle =3D=
 {
>  	.board_config		=3D osc_off_rconfig,
>  };
> =20
> -static struct of_device_id twl4030_power_of_match[] =3D {
> +static const struct of_device_id twl4030_power_of_match[] =3D {
>  	{
>  		.compatible =3D "ti,twl4030-power",
>  	},

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
