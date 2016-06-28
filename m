From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/6] mfd: twl-core: Refactoring for add_numbered_child()
Date: Tue, 28 Jun 2016 16:03:36 +0100
Message-ID: <20160628150336.GJ24982@dell>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682D228.7070902@users.sourceforge.net>
 <20160111082922.GB14104@x1>
 <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net>
 <de3598c4-f85a-6807-303a-55ee0ac707f2@users.sourceforge.net>
 <20160608111442.GB14888@dell>
 <e4eaf0b4-e539-b400-c8a2-70f210cee1fa@users.sourceforge.net>
 <9cf59380-e999-0cf8-9b8d-106691b86d0b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9cf59380-e999-0cf8-9b8d-106691b86d0b@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

On Sun, 26 Jun 2016, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Jun 2016 13:03:59 +0200
>=20
> Adjust jump targets according to the Linux coding style convention.
> Another check for the variable "status" can be omitted then at the en=
d.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/twl-core.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 9458c6d..a49d3db 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -631,7 +631,7 @@ add_numbered_child(unsigned mod_no, const char *n=
ame, int num,
>  		status =3D platform_device_add_data(pdev, pdata, pdata_len);
>  		if (status < 0) {
>  			dev_dbg(&pdev->dev, "can't add platform_data\n");
> -			goto err;
> +			goto put_device;
>  		}
>  	}
> =20
> @@ -644,21 +644,22 @@ add_numbered_child(unsigned mod_no, const char =
*name, int num,
>  		status =3D platform_device_add_resources(pdev, r, irq1 ? 2 : 1);
>  		if (status < 0) {
>  			dev_dbg(&pdev->dev, "can't add irqs\n");
> -			goto err;
> +			goto put_device;
>  		}
>  	}
> =20
>  	status =3D platform_device_add(pdev);
> -	if (status =3D=3D 0)
> -		device_init_wakeup(&pdev->dev, can_wakeup);
> +	if (status)
> +		goto put_device;
> +
> +	device_init_wakeup(&pdev->dev, can_wakeup);
> =20
> -err:
> -	if (status < 0) {
> -		platform_device_put(pdev);
> -		dev_err(&twl->client->dev, "can't add %s dev\n", name);
> -		return ERR_PTR(status);
> -	}
>  	return &pdev->dev;
> +
> +put_device:
> +	platform_device_put(pdev);
> +	dev_err(&twl->client->dev, "failed to add device %s\n", name);
> +	return ERR_PTR(status);
>  }
> =20
>  static inline struct device *add_child(unsigned mod_no, const char *=
name,

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
