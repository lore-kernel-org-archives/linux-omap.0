From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Thu, 15 May 2014 16:07:13 +0300
Message-ID: <5374BC01.7030802@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com> <1398815562-24113-4-git-send-email-tony@atomide.com> <5369EAE7.3030705@ti.com> <20140507150343.GA9502@atomide.com> <536A5920.1020908@ti.com> <20140507175919.GH9502@atomide.com> <20140508233300.GI2198@atomide.com> <536C924E.5000307@ti.com> <20140509153008.GC17814@atomide.com> <20140513212639.GA18001@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="WC660HF6H0CT5Gw5VNuL9cijJ1K7k4MGM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60910 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916AbaEONHj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 May 2014 09:07:39 -0400
In-Reply-To: <20140513212639.GA18001@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

--WC660HF6H0CT5Gw5VNuL9cijJ1K7k4MGM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/05/14 00:26, Tony Lindgren wrote:

> +static int sharp_ls_probe_of(struct platform_device *pdev)
> +{
> +	struct panel_drv_data *ddata =3D platform_get_drvdata(pdev);
> +	struct device_node *node =3D pdev->dev.of_node;
> +	struct omap_dss_device *in;
> +
> +	ddata->vcc =3D devm_regulator_get(&pdev->dev, "envdd");
> +	if (IS_ERR(ddata->vcc)) {
> +		dev_err(&pdev->dev, "failed to get regulator\n");
> +		return PTR_ERR(ddata->vcc);
> +	}
> +
> +	/* lcd INI */
> +	ddata->ini_gpio =3D sharp_ls_get_gpio_of(&pdev->dev, 0, 0, "enable");=

> +	if (PTR_ERR(ddata->ini_gpio) =3D=3D -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

Hmm, the GPIOs are optional, but shouldn't we react somehow to real
errors? I guess we should do something like:

ddata->ini_gpio =3D sharp_ls_get_gpio_of(&pdev->dev, 0, 0, "enable");
if (IS_ERR(ddata->ini_gpio) {
	int err =3D PTR_ERR(ddata->ini_gpio);
	if (err =3D=3D -EPROBE_DEFER || err !=3D -ENOENT)
		return err;
}

 Tomi



--WC660HF6H0CT5Gw5VNuL9cijJ1K7k4MGM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdLwBAAoJEPo9qoy8lh71Ub4QAJsKC1xdeQ5Nw8ioygGiqiTY
Q7s8hHkPtY4t7QNyA7+xv/O0VDz7dOuIkeaBi3xA5EGwm3QP98cEf76R/fu801XK
IYBNzr13Xz1zHObwdyBd0zXoxCIS+BWU6cZuy658/tpB5NpE3kNbruI8B0TmceyQ
PlZ4wE5s03MtMKuTrg04Dr62Vi61qMauOiN0ff7Mi2aSrCRsCKmBgpR1UZ+0+RsT
+ZJ6xPZHLKBmy+7fTcb28x4YODznp+cStRXVr9XGY3zwU/GDprFykx2+zCpXuBqB
9cQhKvVwSU8UU5CD8uQ7ko1iNx9LmbIOf7NhRKaCpKxqj7EvXebmLZeiyalwdhD7
UZM3DEzNdy2YroFxtDWfIz6d2srXG2a9I2DnSZYxd4azcHxxyEfpQvEvTzA45XiA
jDELxGA27PzFptJdlGIDFAZUS7QRhcX6F64S+EHuQ7As1Al53iL6BM/0+UWVeBRT
qMA/fHDRQs/DkUreEWFHtWJtPs2+V+dA3wKhaDNYEED+jw3uh7WAl6YRCX1iwia7
uIqUnxw+EbHH+MjbNDL+wA3sKf0+IdQ1g8la+qzzFV+hoBLV7iqYnDrlHAeJrdNH
GUE3JQslWl3HcG7rACtT36mWHqqwI+XFP1GerIGpOgYyq1AWjk+8VYJGzTQdNs56
zWPgU4qTnzUcU/HMjfIH
=2Tt9
-----END PGP SIGNATURE-----

--WC660HF6H0CT5Gw5VNuL9cijJ1K7k4MGM--
