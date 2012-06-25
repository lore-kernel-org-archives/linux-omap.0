From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv9 3/8] I2C: OMAP: use devm_* functions
Date: Mon, 25 Jun 2012 12:51:54 +0300
Message-ID: <20120625095152.GE6468@arwen.pp.htv.fi>
References: <1340273329-8319-1-git-send-email-shubhrajyoti@ti.com>
 <1340273329-8319-4-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:57683 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755542Ab2FYJyQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 05:54:16 -0400
Received: by lbbgj10 with SMTP id gj10so6335529lbb.9
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 02:54:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340273329-8319-4-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2012 at 03:38:44PM +0530, Shubhrajyoti D wrote:
> The various devm_* functions allocate memory that is released when a driv=
er
> detaches. This patch uses devm_kzalloc, devm_request_and_ioremap for data
> that is allocated in the probe function of a platform device and is only
> freed in the remove function.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

this looks a lot like:
http://marc.info/?l=3Dlinux-omap&m=3D133969143407572&w=3D2

I wonder why wasn't that one used instead ?

> ---
>  drivers/i2c/busses/i2c-omap.c |   33 +++++++++------------------------
>  1 files changed, 9 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index d704f64..328a022 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -943,7 +943,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  {
>  	struct omap_i2c_dev	*dev;
>  	struct i2c_adapter	*adap;
> -	struct resource		*mem, *irq, *ioarea;
> +	struct resource		*mem, *irq;
>  	struct omap_i2c_bus_platform_data *pdata =3D pdev->dev.platform_data;
>  	struct device_node	*node =3D pdev->dev.of_node;
>  	const struct of_device_id *match;
> @@ -962,17 +962,16 @@ omap_i2c_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
> =20
> -	ioarea =3D request_mem_region(mem->start, resource_size(mem),
> -			pdev->name);
> -	if (!ioarea) {
> -		dev_err(&pdev->dev, "I2C region already claimed\n");
> -		return -EBUSY;
> +	dev =3D devm_kzalloc(&pdev->dev, sizeof(struct omap_i2c_dev), GFP_KERNE=
L);
> +	if (!dev) {
> +		dev_err(&pdev->dev, "Menory allocation failed\n");
> +		return -ENOMEM;
>  	}
> =20
> -	dev =3D kzalloc(sizeof(struct omap_i2c_dev), GFP_KERNEL);
> -	if (!dev) {
> -		r =3D -ENOMEM;
> -		goto err_release_region;
> +	dev->base =3D devm_request_and_ioremap(&pdev->dev, mem);
> +	if (!dev->base) {
> +		dev_err(&pdev->dev, "I2C region already claimed\n");
> +		return -ENOMEM;
>  	}
> =20
>  	match =3D of_match_device(of_match_ptr(omap_i2c_of_match), &pdev->dev);
> @@ -996,11 +995,6 @@ omap_i2c_probe(struct platform_device *pdev)
> =20
>  	dev->dev =3D &pdev->dev;
>  	dev->irq =3D irq->start;
> -	dev->base =3D ioremap(mem->start, resource_size(mem));
> -	if (!dev->base) {
> -		r =3D -ENOMEM;
> -		goto err_free_mem;
> -	}
> =20
>  	platform_set_drvdata(pdev, dev);
> =20
> @@ -1095,13 +1089,9 @@ err_free_irq:
>  err_unuse_clocks:
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>  	pm_runtime_put(dev->dev);
> -	iounmap(dev->base);
>  	pm_runtime_disable(&pdev->dev);
>  err_free_mem:
>  	platform_set_drvdata(pdev, NULL);
> -	kfree(dev);
> -err_release_region:
> -	release_mem_region(mem->start, resource_size(mem));
> =20
>  	return r;
>  }
> @@ -1109,7 +1099,6 @@ err_release_region:
>  static int __devexit omap_i2c_remove(struct platform_device *pdev)
>  {
>  	struct omap_i2c_dev	*dev =3D platform_get_drvdata(pdev);
> -	struct resource		*mem;
>  	int ret;
> =20
>  	platform_set_drvdata(pdev, NULL);
> @@ -1123,10 +1112,6 @@ static int __devexit omap_i2c_remove(struct platfo=
rm_device *pdev)
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> -	iounmap(dev->base);
> -	kfree(dev);
> -	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(mem->start, resource_size(mem));
>  	return 0;
>  }
> =20
> --=20
> 1.7.5.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6DS4AAoJEIaOsuA1yqREdXAP/jB11D/8+Z0E6giAZVLqbHcM
RHihnu/vuXEq/aqxKw1RJ0k4+hSXPs7ZEPcrXfRHMpVn/+vxOkNP5Zj29enQ5+y/
CsK6FBg7/GE5MX2MHbfp8Sbg45Jr8kCT5Z+068oY5s0K3FBFlLFo15cEYlXbhC1c
tjOdAgDRL5DC44OqZMwx7YaMjKQNpFxrsJSfkzXI41zPdFxB5nPFExlZmBB3ZGPn
g6w0raQt8wQqC8bIss/CgB7PGbe6+R8/Sh4q+BgJQ3qw3ewGkK0viiRIFbUsaKzj
bsjRqwkmUhqlLgtyqRNN6LeMzimZExVnpWJavxikMVeI6YOPme+hyL3khcn3PKRS
cINHIIYuLMSyrfNDJ1InlwQ4yTWqDSiTawRiTa3uz9JfvQJwR0AUmgoIwkIFWt5a
Py1prCZyAhlG/jspfqvuHSWD44IWqZ0+Rhuf1Pu1LcswLLiiv9x2jFPv9rCpD/AI
Wyp3M12XTVFZh/TiHq4+QVipptn3q0e9KS2rvq/kGI01pZhk0cH+o1yR2n27FRk2
vi/k6n7Z3x6VIrOTZN84DdQcwdDYIxJSEUFkVnAlfwtOxQ5kFkL8zrLcuErLcXY2
Q2A4G5qg0lgl4tXWm+vNBYlCLEPcMZ0nzxF48e8ZG7IPRfdT3ROvu3vNRFYfjXxa
+hSvhUR/kFWN34T5rlKT
=lgeu
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
