From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5 RESEND] ARM: OMAP: USB: HOST TLL platform driver
Date: Mon, 19 Mar 2012 12:06:04 +0200
Message-ID: <20120319100603.GB20279@arwen.pp.htv.fi>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com>
 <1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:37401 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751015Ab2CSKGU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 06:06:20 -0400
Received: by mail-lpp01m010-f54.google.com with SMTP id v3so6384077lag.13
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 03:06:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com, govindraj.raja@ti.com, paul@pwsan.com, b-cousson@ti.com


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 19, 2012 at 12:18:31PM +0530, Keshava Munegowda wrote:
> +	ver =3D  usbtll_read(base, OMAP_USBTLL_REVISION);
> +	if (ver =3D=3D OMAP_USBTLL_REV1)
> +		count =3D OMAP_TLL_CHANNEL_COUNT;
> +	else if (ver =3D=3D OMAP_USBTLL_REV2)
> +		count =3D OMAP_REV2_TLL_CHANNEL_COUNT;
> +	else {
> +		dev_err(dev, "TLL version failed\n");
> +		ret =3D -ENODEV;
> +		goto err_ioremap;
> +	}

wrong coding style.

> +static const struct dev_pm_ops usbtllomap_dev_pm_ops =3D {
> +	.runtime_suspend	=3D usbtll_runtime_suspend,
> +	.runtime_resume		=3D usbtll_runtime_resume,

use SET_RUNTIME_PM_OPS()

> +static struct platform_driver usbtll_omap_driver =3D {
> +	.driver =3D {
> +		.name		=3D (char *)usbtll_driver_name,
> +		.owner		=3D THIS_MODULE,
> +		.pm		=3D &usbtllomap_dev_pm_ops,
> +	},
> +	.remove		=3D __exit_p(usbtll_omap_remove),

__devexit_p()

> +};
> +
> +int omap_tll_enable(void)
> +{
> +	if (!tll_pdev) {
> +		dev_dbg(&tll_pdev->dev, "missing platform_data\n");
> +		return  -ENODEV;
> +	}
> +	return pm_runtime_get_sync(&tll_pdev->dev);
> +}
> +EXPORT_SYMBOL_GPL(omap_tll_enable);

why ?

> +
> +int omap_tll_disable(void)
> +{
> +	if (!tll_pdev) {
> +		dev_dbg(&tll_pdev->dev, "missing platform_data\n");
> +		return  -ENODEV;
> +	}
> +	return pm_runtime_put_sync(&tll_pdev->dev);
> +}
> +EXPORT_SYMBOL_GPL(omap_tll_disable);

why ?

> +MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
> +MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI controllers=
");
> +
> +static int __init omap_usbtll_drvinit(void)
> +{
> +	return platform_driver_probe(&usbtll_omap_driver, usbtll_omap_probe);

please don't. Make sure you use platform_driver_register, instead.

--=20
balbi

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZwULAAoJEIaOsuA1yqREQ3AP/2JooLfybuswGt9R2CduAfxx
dQ3VNQRscINp6tZgYEeXT4BbtMQC84Q1P617OjXFA5PI6Rey+Knt8oyLjigg7D+T
LI40HhyDutYLmYt5lBpArN+K5kgWqugTzk5dse9qA/r9pP9GJSERg3PBXJ3ZDUfq
Qk1bCN3KJxjXcuhocoXHTPoZDRaORZg/NMx8hQ+n1ocW24FXpGCo2V7lu7C4ipJg
p4hgE6Jvx27llEQyjqgn+GF5BRAmzgNYhp3mbeLEXFssT0rBNKHPM0duMsPlJoHw
r6mxpmye0EOlu/yPBUNLIRQcRZ3SNZHCIDW8Mq57pL/56RMYfX8S/JpwKSgVVGI0
XE7cQPF4A4ov67ujbjHathrDd/jo1dDJ95WcsfEvTjXCDFMXk1PiAg/llJgs/XGG
2lKfp19aLm/OuvRk7h3Vfq+l2Yul5Buyeif/0RpuDtCxfR6Os691IQSAPTeoFZV/
aETteCaTmEqM45DAFRN9rbVIjM4haaTAJbcrBfFNj2Hjak6OF0eF5pdU5tm0XEfF
pRUk/5tUJdxrqYdw14y8vbfqfFvALPt7Af1eIT4lYgO0YjyOgRzDkgOOncB5auIW
nuumatvBmjCfzvnzvdJHfscMYlfYRTMngc8i18vNiKEwtTtBSSf4s8dMqwoISU/D
ZHdZduOOY0/cJlDvWD1W
=BQ2i
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
