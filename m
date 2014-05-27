From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/5] mfd: palmas: Add tps65917 support
Date: Tue, 27 May 2014 09:38:04 +0100
Message-ID: <20140527083804.GB5875@lee--X1>
References: <1401098197-647-1-git-send-email-j-keerthy@ti.com>
 <1401098197-647-5-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1401098197-647-5-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Mon, 26 May 2014, Keerthy wrote:

> Add tps65917 PMIC support. tps65917 is a subset of palmas PMIC.
> Some of the register definitions and the interrupt mappings
> are different.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/palmas.c |  177 ++++++++++++++++++++++++++++++++++++++++=
++++++++--

Much nicer.  You just saved yourself(/the subsystem) 420 lines!

I have a single nit.  Once it's fixed-up you can apply my:

  Acked-by: Lee Jones <lee.jones@linaro.org>

>  1 file changed, 172 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> index d280d78..e4684cc 100644
> --- a/drivers/mfd/palmas.c
> +++ b/drivers/mfd/palmas.c

[...]

>  static const struct of_device_id of_palmas_match_tbl[] =3D {
>  	{
>  		.compatible =3D "ti,palmas",
> -		.data =3D &palmas_features,
> +		.data =3D &palmas_data,
>  	},
>  	{
>  		.compatible =3D "ti,tps659038",
> -		.data =3D &tps659038_features,
> +		.data =3D &tps659038_data,
>  	},
> +	{
> +		.compatible =3D "ti,tps65917",
> +		.data =3D &tps65917_data,
> +	},
> +

Please get rid of this line.

>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, of_palmas_match_tbl);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
