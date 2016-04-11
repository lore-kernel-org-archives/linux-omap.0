From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 08/20] mfd: lp3943: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Mon, 11 Apr 2016 10:16:02 +0100
Message-ID: <20160411091602.GV4592@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-9-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-9-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Milo Kim <milo.kim@ti.com>
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and get
> rid of .remove callback to remove MFD child-devices. This is done
> by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Milo Kim <milo.kim@ti.com>
> Acked-by: Milo Kim <milo.kim@ti.com>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
> - Collected acks.
>=20
>  drivers/mfd/lp3943.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/mfd/lp3943.c b/drivers/mfd/lp3943.c
> index eecbb13..65a2a8f1 100644
> --- a/drivers/mfd/lp3943.c
> +++ b/drivers/mfd/lp3943.c
> @@ -123,16 +123,9 @@ static int lp3943_probe(struct i2c_client *cl, c=
onst struct i2c_device_id *id)
>  	lp3943->mux_cfg =3D lp3943_mux_cfg;
>  	i2c_set_clientdata(cl, lp3943);
> =20
> -	return mfd_add_devices(dev, -1, lp3943_devs, ARRAY_SIZE(lp3943_devs=
),
> -			       NULL, 0, NULL);
> -}
> -
> -static int lp3943_remove(struct i2c_client *cl)
> -{
> -	struct lp3943 *lp3943 =3D i2c_get_clientdata(cl);
> -
> -	mfd_remove_devices(lp3943->dev);
> -	return 0;
> +	return devm_mfd_add_devices(dev, -1, lp3943_devs,
> +				    ARRAY_SIZE(lp3943_devs),
> +				    NULL, 0, NULL);
>  }
> =20
>  static const struct i2c_device_id lp3943_ids[] =3D {
> @@ -151,7 +144,6 @@ MODULE_DEVICE_TABLE(of, lp3943_of_match);
> =20
>  static struct i2c_driver lp3943_driver =3D {
>  	.probe =3D lp3943_probe,
> -	.remove =3D lp3943_remove,
>  	.driver =3D {
>  		.name =3D "lp3943",
>  		.of_match_table =3D of_match_ptr(lp3943_of_match),

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
