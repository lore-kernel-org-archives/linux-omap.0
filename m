From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 8/9] regulator: palmas: add driver data and modularize
 the probe
Date: Tue, 17 Jun 2014 17:45:02 +0100
Message-ID: <20140617164502.GS29841@lee--X1>
References: <1401272423-25761-1-git-send-email-j-keerthy@ti.com>
 <1401272423-25761-9-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1401272423-25761-9-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

> add driver data and modularize the probe.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/palmas.c                 |   42 +--
>  drivers/regulator/palmas-regulator.c |  656 ++++++++++++++++++++----=
----------
>  2 files changed, 395 insertions(+), 303 deletions(-)
>=20
> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c

[...]

> @@ -370,6 +334,8 @@ int palmas_ext_control_req_config(struct palmas *=
palmas,
>  	int bit_pos;
>  	int ret;
> =20
> +	struct palmas_pmic_driver_data *pmic_ddata =3D palmas->pmic_ddata;
> +

Nit: I'd prefer the declarations to be grouped together, normally with
the struct defines above the ints etc.

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
