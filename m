From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 16/21] OMAPDSS: handle output-driver reg/unreg more
 dynamically
Date: Thu, 08 Mar 2012 10:46:04 +0200
Message-ID: <1331196364.2354.49.camel@deskari>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
	 <1331124290-6285-17-git-send-email-tomi.valkeinen@ti.com>
	 <4F586EFD.1020208@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-NYN67sCNublX4pqTftJW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:51223 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753048Ab2CHIqJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 03:46:09 -0500
Received: by lagj5 with SMTP id j5so293948lag.31
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 00:46:06 -0800 (PST)
In-Reply-To: <4F586EFD.1020208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-NYN67sCNublX4pqTftJW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-03-08 at 14:04 +0530, Archit Taneja wrote:
> On Wednesday 07 March 2012 06:14 PM, Tomi Valkeinen wrote:

> > -	r =3D hdmi_init_platform_driver();
> > -	if (r) {
> > -		DSSERR("Failed to initialize hdmi\n");
> > -		goto err_hdmi;
> > +	/*
> > +	 * It's ok if the output-driver register fails. It happens, for examp=
le,
> > +	 * when there is no output-device (e.g. SDI for OMAP4).
> > +	 */
>=20
> Suppose we do a omap2plus_defconfig, CONFIG_OMAP2_DSS_SDI would be=20
> selected, and sdi.c would be built, if we boot on OMAP4, why would a sdi=
=20
> driver register cause a failure? Wouldn't the sdi driver just get=20
> registered, and wait till eternity for the corresponding sdi platform=20
> device to get registered?

No. Well, yes.

Currently we use platform_driver_register() to register the drivers, and
it does just what you described. But a few patches later I change
platform_driver_register() to platform_driver_probe(), which will return
ENODEV if there are no matching devices for the driver.

I originally had the platform_driver_probe() patch before this patch,
and thus the comment above made sense. Now the patch is after this
patch, so the comment is not exactly right until the probe patch is also
applied.

The point with platform_driver_probe() is that it can be used with
non-removable devices which are created at boot time, like the DSS
components. With platform_driver_probe() the probe function is called
only at that one time, and never afterwards. So probe can be in __init
section, and thrown away after init.

One side effect of using platform_driver_probe() is that it returns
ENODEV is there are no devices. In a simple module, the error can be
then returned from module_init, thus causing the whole module to be
unloaded. Our case is a bit more complex as we have multiple drivers in
the same module.

A downside with that is that we don't really know if the ENODEV error
happened because there were no devices (which is ok), or if it came from
probe function (which is not so ok). However, I thought that it doesn't
matter if an output driver has failed. We can still continue with the
other output drivers just fine.

Actually, there is a small problem. If, for example, DSI driver fails to
load, and DPI driver tries to use DSI PLL...

 Tomi


--=-NYN67sCNublX4pqTftJW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPWHHMAAoJEPo9qoy8lh71sVkQAJcR/qUXhBmEWW5oLgZ6ZjwY
0JAF9odW8TMLQmzxfFs0+RJ1ASy6GwOnU7WLlUNUFuo0NVgH2k6P/A2WSo4e44z7
YHHyeVViweR+7Z59E967bMFWDB1pcDdwMam8vmsNFK5AL7js2+w6uLOJcmfgxXU4
3OdCanTzwGTb1eHvZcThmCyDmzUc/Y+SCEVabZsSQgSOYZ5qKVTdVMczMG739r6G
bijnkWE+LrieJ4hDvmc9yjG1KhdUycAXy09BhOaBC8oDJ8NAnnBs1AL8lSI4ySMR
K/CzHtUQqYEJXtvigVdwMJZp1jrPgc2bqZrkRS8VFCenFqa5KyG885dGABcExr66
1UAaieUcEkKh7kclZCpnQXMBKXN0sjd7jZEJDsltfP+13rwIIw3lQbmyYoE9Ce3I
0x7JyScC0lGmqJ/BKJ0bfrd3qCaPeiLYK98eKah1WMHx8QHyqhjmx9ZDWyZWYDGE
hb1fJEbNR+qTah2xiOsXEX0TiAHFVhMprVirH9Gvyp/k3ZCMLaL2gI3Cmz1xwfbm
H3lxmnO6sBJCUmdKoy46SIOV2+XakkYtEkZUghZTDIhZY6VFGIDNfGhnNNpUyJaT
PVzI/zC4g2Qh0Z1f4L85kCX0QCgiifkJ++lJFWc6oFRz+tIvRbz9jP5HgrNQCVlP
P6MyfDLux1+pre7QUm3i
=u5bG
-----END PGP SIGNATURE-----

--=-NYN67sCNublX4pqTftJW--

