From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/6] mfd: dm355evm_msp: Refactoring for add_child()
Date: Tue, 28 Jun 2016 16:07:25 +0100
Message-ID: <20160628150725.GL24982@dell>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682D228.7070902@users.sourceforge.net>
 <20160111082922.GB14104@x1>
 <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net>
 <de3598c4-f85a-6807-303a-55ee0ac707f2@users.sourceforge.net>
 <20160608111442.GB14888@dell>
 <e4eaf0b4-e539-b400-c8a2-70f210cee1fa@users.sourceforge.net>
 <75c1cc23-3a2d-db78-d0f2-b5934b18e828@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <75c1cc23-3a2d-db78-d0f2-b5934b18e828@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

On Sun, 26 Jun 2016, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Jun 2016 13:56:58 +0200
>=20
> Adjust jump targets according to the Linux coding style convention.
> Another check for the variable "status" can be omitted then at the en=
d.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/mfd/dm355evm_msp.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
> index 270e19c..baf6075 100644
> --- a/drivers/mfd/dm355evm_msp.c
> +++ b/drivers/mfd/dm355evm_msp.c
> @@ -209,7 +209,7 @@ static struct device *add_child(struct i2c_client=
 *client, const char *name,
>  		status =3D platform_device_add_data(pdev, pdata, pdata_len);
>  		if (status < 0) {
>  			dev_dbg(&pdev->dev, "can't add platform_data\n");
> -			goto err;
> +			goto put_device;
>  		}
>  	}
> =20
> @@ -222,19 +222,21 @@ static struct device *add_child(struct i2c_clie=
nt *client, const char *name,
>  		status =3D platform_device_add_resources(pdev, &r, 1);
>  		if (status < 0) {
>  			dev_dbg(&pdev->dev, "can't add irq\n");
> -			goto err;
> +			goto put_device;
>  		}
>  	}
> =20
>  	status =3D platform_device_add(pdev);
> =20

Remove this line too.

> -err:
> -	if (status < 0) {
> -		platform_device_put(pdev);
> -		dev_err(&client->dev, "can't add %s dev\n", name);
> -		return ERR_PTR(status);
> -	}
> +	if (status)
> +		goto put_device;
> +
>  	return &pdev->dev;
> +
> +put_device:
> +	platform_device_put(pdev);
> +	dev_err(&client->dev, "failed to add device %s\n", name);
> +	return ERR_PTR(status);
>  }
> =20
>  static int add_children(struct i2c_client *client)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe kernel-janito=
rs" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
