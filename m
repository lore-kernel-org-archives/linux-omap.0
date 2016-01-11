From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl-core: One function call less in
 add_numbered_child() after error detection
Date: Mon, 11 Jan 2016 08:29:22 +0000
Message-ID: <20160111082922.GB14104@x1>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682D228.7070902@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5682D228.7070902@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

On Tue, 29 Dec 2015, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 29 Dec 2015 19:29:08 +0100
>=20
> The platform_device_put() function was called in one case by the
> add_numbered_child() function during error handling even if the passe=
d
> variable "pdev" contained a null pointer.
>=20
> Implementation details could be improved by the adjustment of jump ta=
rgets
> according to the Linux coding style convention.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/mfd/twl-core.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 831696e..0d9350c 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -625,7 +625,7 @@ add_numbered_child(unsigned mod_no, const char *n=
ame, int num,
>  	if (!pdev) {
>  		dev_dbg(&twl->client->dev, "can't alloc dev\n");

Change this to be dev_err()

>  		status =3D -ENOMEM;
> -		goto err;
> +		goto report_failure;

=2E.. and just return status from here.

>  	}
> =20
>  	pdev->dev.parent =3D &twl->client->dev;
> @@ -634,7 +634,7 @@ add_numbered_child(unsigned mod_no, const char *n=
ame, int num,
>  		status =3D platform_device_add_data(pdev, pdata, pdata_len);
>  		if (status < 0) {
>  			dev_dbg(&pdev->dev, "can't add platform_data\n");
> -			goto err;
> +			goto put_device;
>  		}
>  	}
> =20
> @@ -647,21 +647,20 @@ add_numbered_child(unsigned mod_no, const char =
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
> +	if (!status) {

You've changed the way you handle errors from this point.  To be more
consistent it would be better if you checked for status, then jump to
put_device in the case of a failure, as you do above.

>  		device_init_wakeup(&pdev->dev, can_wakeup);
> -
> -err:
> -	if (status < 0) {
> -		platform_device_put(pdev);
> -		dev_err(&twl->client->dev, "can't add %s dev\n", name);
> -		return ERR_PTR(status);
> +		return &pdev->dev;
>  	}
> -	return &pdev->dev;
> +put_device:
> +	platform_device_put(pdev);
> +report_failure:
> +	dev_err(&twl->client->dev, "can't add %s dev\n", name);
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
