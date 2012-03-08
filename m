From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 16/21] OMAPDSS: handle output-driver reg/unreg more
 dynamically
Date: Thu, 08 Mar 2012 11:34:57 +0200
Message-ID: <1331199297.2354.62.camel@deskari>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
	 <1331124290-6285-17-git-send-email-tomi.valkeinen@ti.com>
	 <4F586EFD.1020208@ti.com> <1331196364.2354.49.camel@deskari>
	 <4F587A62.3020202@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-DFs7a3tk0OUlPO2dod83"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:38906 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751143Ab2CHJfB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 04:35:01 -0500
Received: by mail-lpp01m010-f54.google.com with SMTP id v3so381169lag.13
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 01:34:59 -0800 (PST)
In-Reply-To: <4F587A62.3020202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-DFs7a3tk0OUlPO2dod83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-03-08 at 14:52 +0530, Archit Taneja wrote:
> On Thursday 08 March 2012 02:16 PM, Tomi Valkeinen wrote:
> > On Thu, 2012-03-08 at 14:04 +0530, Archit Taneja wrote:
> >> On Wednesday 07 March 2012 06:14 PM, Tomi Valkeinen wrote:
> >
> >>> -	r =3D hdmi_init_platform_driver();
> >>> -	if (r) {
> >>> -		DSSERR("Failed to initialize hdmi\n");
> >>> -		goto err_hdmi;
> >>> +	/*
> >>> +	 * It's ok if the output-driver register fails. It happens, for exa=
mple,
> >>> +	 * when there is no output-device (e.g. SDI for OMAP4).
> >>> +	 */
> >>
> >> Suppose we do a omap2plus_defconfig, CONFIG_OMAP2_DSS_SDI would be
> >> selected, and sdi.c would be built, if we boot on OMAP4, why would a s=
di
> >> driver register cause a failure? Wouldn't the sdi driver just get
> >> registered, and wait till eternity for the corresponding sdi platform
> >> device to get registered?
> >
> > No. Well, yes.
> >
> > Currently we use platform_driver_register() to register the drivers, an=
d
> > it does just what you described. But a few patches later I change
> > platform_driver_register() to platform_driver_probe(), which will retur=
n
> > ENODEV if there are no matching devices for the driver.
> >
> > I originally had the platform_driver_probe() patch before this patch,
> > and thus the comment above made sense. Now the patch is after this
> > patch, so the comment is not exactly right until the probe patch is als=
o
> > applied.
>=20
> Oh okay. But the comment after the patch set still says "It's ok if the=
=20
> output-driver register fails.", we could change it to "It's ok if the=20
> output-driver probe fails."

Well, I guess this goes into nitpicking area, but if there are no
devices, probe is not called at all. So I think it's the driver register
that fails in that case. If there is a device, and it is probed, and
that fails, then it's probe which fails.

> > The point with platform_driver_probe() is that it can be used with
> > non-removable devices which are created at boot time, like the DSS
> > components. With platform_driver_probe() the probe function is called
> > only at that one time, and never afterwards. So probe can be in __init
> > section, and thrown away after init.
>=20
> So platform_driver_probe() is like a driver_register() + probe().

Yes. Well, when platform_driver_register() is called, and the devices
are already present, it will call the probe also. So in that sense they
are similar. The difference is that for platform_driver_register() the
probe pointer must be in the driver struct, and it stays there even
after init. For platform_driver_probe(), the probe pointer is given as
an argument to the function, and thus it's not stored anywhere and can
be thrown away afterwards.

> Okay, in our case, all the devices are created at boot time, and if=20
> omapdss were a module, the probes would have been thrown away after=20
> module_init(), right?

Yes. If omapdss is a module, the functions marked with __init are
discarded after the module_init is done. If omapdss is built-in, the
__init funcs are thrown away after the kernel's init done.

> > One side effect of using platform_driver_probe() is that it returns
> > ENODEV is there are no devices. In a simple module, the error can be
> > then returned from module_init, thus causing the whole module to be
> > unloaded. Our case is a bit more complex as we have multiple drivers in
> > the same module.
> >
> > A downside with that is that we don't really know if the ENODEV error
> > happened because there were no devices (which is ok), or if it came fro=
m
> > probe function (which is not so ok). However, I thought that it doesn't
> > matter if an output driver has failed. We can still continue with the
> > other output drivers just fine.
>=20
> If we ensure that none of our probes return ENODEV(even though it may=20
> make sense to return it if a func within probe fails), we could=20
> differentiate between the 2 cases, right?

True, I thought about that. But we can never be sure that the functions
called by the probe (clk_get, or whatever) won't return ENODEV. Of
course, we could check what they return, and change the error to
something else, but I'm not sure if that's good either.

> >
> > Actually, there is a small problem. If, for example, DSI driver fails t=
o
> > load, and DPI driver tries to use DSI PLL...
>=20
> If we could differentiate between an error occuring because the device=
=20
> doesn't exist and an error occuring because the probe failed, we could=
=20
> bail out if any of the probes fail, right?

Yes, but it feels a bit hackish to try to use the error as I pointed out
above. So I'd rather go the other way: the drivers should somehow
register the stuff they offer, so for example when the DSI1 is probed,
it should register the DSI1 PLL to dss core. And DPI would have to ask
for the DSI1 PLL from dss core.

That, of course, is not a trivial change, so for the moment this stuff
is slightly broken in error cases. Perhaps we could figure out some kind
of clean hack for that...

Alternatively, if the platform driver code was changed to tell us
clearly if it was the probe that failed or if there just weren't any
devices, we could also use that.

 Tomi


--=-DFs7a3tk0OUlPO2dod83
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPWH1BAAoJEPo9qoy8lh71KNoP/jOK4aIps5+FNe4YBMPOKhPc
D+bjI1iG0afdDOPDAXTaJATIxrN7GOGtez6I+FCqNLbxpbZDgjLlot2j8lLooUtM
7b2J3p5Ga6ncKS54nZlqcQXfshKzaiWyGjzLmM2ZY9pgVTFtLO5mjWn02/+BLBpG
Ttzir5xCBYU3oUm2XHpYxTGx9k3les7SCKUk1LtYkhufEmNbUSQKz/4AN7yC6gFy
LF849SJAh2BqrkeGxOPatQVnzVTsrbb8iTuA3u9I+IL4iq1AJNjHOvr8n1oy941H
GeBakJqXn+Oi5RqgTUVgCuKs+S10XyGKavD6ssvMWMRJ6EFN1Bqyo21YOEbY3l+Z
dH8c/G8VL+r6W2tvXXL4TI3DUjqo+ZwVggP4eHD/9MrryNmKP8WQM+sKhGD18hjr
QiEL06gKD8unPUVbRMg1af1IgBNr6P2e+dtSIVr/g/ZUPsD9r+tITkiBdGbTbM5j
HxgyFrhosIhLHBEXKwUwJbfFtJwzR44Jw3wQe05cjkBZxP0src+3JfcteddJAqB2
TCWfl7JuQ6fEbTHjd9gX4h/tGJKxgcLd6RUvC43mHCMHOtDwHC1aO3b3SwDT586o
1fUzZqnBw77nOqPFVv8a2c7cz6sqRTqrqvA0KyTBl5xUTzIKExGIZO+9vLYpuuPi
xU1oiOujTxTh8qWt6BkT
=uxNb
-----END PGP SIGNATURE-----

--=-DFs7a3tk0OUlPO2dod83--

