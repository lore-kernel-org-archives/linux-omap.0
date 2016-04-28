From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 7/7] mfd: wl1273-core: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Thu, 28 Apr 2016 10:11:17 +0100
Message-ID: <20160428091117.GC19259@dell>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
 <1461241558-26983-8-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461241558-26983-8-git-send-email-ldewangan@nvidia.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: milo.kim@ti.com, cw00.choi@samsung.com, k.kozlowski@samsung.com, sbkim73@samsung.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 21 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and get
> rid of .remove callback to remove MFD child-devices. This is done
> by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/mfd/wl1273-core.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/wl1273-core.c b/drivers/mfd/wl1273-core.c
> index f7c52d9..7080465 100644
> --- a/drivers/mfd/wl1273-core.c
> +++ b/drivers/mfd/wl1273-core.c
> @@ -170,15 +170,6 @@ static int wl1273_fm_set_volume(struct wl1273_co=
re *core, unsigned int volume)
>  	return 0;
>  }
> =20
> -static int wl1273_core_remove(struct i2c_client *client)
> -{
> -	dev_dbg(&client->dev, "%s\n", __func__);
> -
> -	mfd_remove_devices(&client->dev);
> -
> -	return 0;
> -}
> -
>  static int wl1273_core_probe(struct i2c_client *client,
>  				       const struct i2c_device_id *id)
>  {
> @@ -237,8 +228,8 @@ static int wl1273_core_probe(struct i2c_client *c=
lient,
>  	dev_dbg(&client->dev, "%s: number of children: %d.\n",
>  		__func__, children);
> =20
> -	r =3D mfd_add_devices(&client->dev, -1, core->cells,
> -			    children, NULL, 0, NULL);
> +	r =3D devm_mfd_add_devices(&client->dev, -1, core->cells,
> +				 children, NULL, 0, NULL);
>  	if (r)
>  		goto err;
> =20
> @@ -258,7 +249,6 @@ static struct i2c_driver wl1273_core_driver =3D {
>  	},
>  	.probe =3D wl1273_core_probe,
>  	.id_table =3D wl1273_driver_id_table,
> -	.remove =3D wl1273_core_remove,
>  };
> =20
>  static int __init wl1273_core_init(void)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
