From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 17/20] mfd: tps6507x: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Mon, 11 Apr 2016 10:32:14 +0100
Message-ID: <20160411093214.GH7994@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-18-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-18-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Todd Fischer <todd.fischer@ridgerun.com>
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and get
> rid of .remove callback to remove MFD child-devices. This is done
> by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Todd Fischer <todd.fischer@ridgerun.com>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
> - Fix checkpatch --strict error on patch.
>=20
>  drivers/mfd/tps6507x.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/mfd/tps6507x.c b/drivers/mfd/tps6507x.c
> index 1ab3dd6..40beb2f 100644
> --- a/drivers/mfd/tps6507x.c
> +++ b/drivers/mfd/tps6507x.c
> @@ -100,16 +100,8 @@ static int tps6507x_i2c_probe(struct i2c_client =
*i2c,
>  	tps6507x->read_dev =3D tps6507x_i2c_read_device;
>  	tps6507x->write_dev =3D tps6507x_i2c_write_device;
> =20
> -	return mfd_add_devices(tps6507x->dev, -1, tps6507x_devs,
> -			       ARRAY_SIZE(tps6507x_devs), NULL, 0, NULL);
> -}
> -
> -static int tps6507x_i2c_remove(struct i2c_client *i2c)
> -{
> -	struct tps6507x_dev *tps6507x =3D i2c_get_clientdata(i2c);
> -
> -	mfd_remove_devices(tps6507x->dev);
> -	return 0;
> +	return devm_mfd_add_devices(tps6507x->dev, -1, tps6507x_devs,
> +				    ARRAY_SIZE(tps6507x_devs), NULL, 0, NULL);
>  }
> =20
>  static const struct i2c_device_id tps6507x_i2c_id[] =3D {
> @@ -132,7 +124,6 @@ static struct i2c_driver tps6507x_i2c_driver =3D =
{
>  		   .of_match_table =3D of_match_ptr(tps6507x_of_match),
>  	},
>  	.probe =3D tps6507x_i2c_probe,
> -	.remove =3D tps6507x_i2c_remove,
>  	.id_table =3D tps6507x_i2c_id,
>  };
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
