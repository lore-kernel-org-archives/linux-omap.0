From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: menelaus: rmove incorrect __exit markups
Date: Tue, 10 Mar 2015 15:13:54 +0000
Message-ID: <20150310151354.GA3342@x1>
References: <20150309174936.GA22662@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150309174936.GA22662@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 09 Mar 2015, Dmitry Torokhov wrote:

> Even if bus is not hot-pluggable, the devices can be unbound from the
> driver via sysfs, so we should not be using __exit annotations on
> remove() methods. The only exception is drivers registered with
> platform_driver_probe() which specifically disables sysfs bind/unbind
> attributes.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/mfd/menelaus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> index 9f01aef..5269ff2 100644
> --- a/drivers/mfd/menelaus.c
> +++ b/drivers/mfd/menelaus.c
> @@ -1259,7 +1259,7 @@ fail:
>  	return err;
>  }
> =20
> -static int __exit menelaus_remove(struct i2c_client *client)
> +static int menelaus_remove(struct i2c_client *client)
>  {
>  	struct menelaus_chip	*menelaus =3D i2c_get_clientdata(client);
> =20
> @@ -1280,7 +1280,7 @@ static struct i2c_driver menelaus_i2c_driver =3D=
 {
>  		.name		=3D DRIVER_NAME,
>  	},
>  	.probe		=3D menelaus_probe,
> -	.remove		=3D __exit_p(menelaus_remove),
> +	.remove		=3D menelaus_remove,
>  	.id_table	=3D menelaus_id,
>  };
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
