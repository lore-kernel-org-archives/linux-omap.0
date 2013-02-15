From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Fri, 15 Feb 2013 08:53:08 +0200
Message-ID: <20130215065308.GC30038@arwen.pp.htv.fi>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130214222247.GE11362@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52836 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161118Ab3BOGxS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 01:53:18 -0500
Content-Disposition: inline
In-Reply-To: <20130214222247.GE11362@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2013 at 02:22:47PM -0800, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [130214 12:51]:
> > Hi,
> >=20
> > On Thu, 14 Feb 2013, Tony Lindgren wrote:
> >=20
> > > I don't think so as hwmod should only touch the sysconfig space
> > > when no driver has claimed it.
> >=20
> > hwmod does need to touch the SYSCONFIG register during pm_runtime suspe=
nd=20
> > and resume operations, and during device enable and disable operations.=
 =20
> > Here's the relevant code:
> >=20
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dblob=
;f=3Darch/arm/mach-omap2/omap_hwmod.c;h=3D4653efb87a2721ea20a9fe06a30a6c204=
d6d2282;hb=3DHEAD#l2157
> >=20
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dblob=
;f=3Darch/arm/mach-omap2/omap_hwmod.c;h=3D4653efb87a2721ea20a9fe06a30a6c204=
d6d2282;hb=3DHEAD#l2195
>=20
> But that's triggered by runtime PM from the device driver, right?
>=20
> I think it's fine for hwmod to do that as requested by the device
> driver via runtime PM since hwmod is the bus glue making the drivers arch
> independent.
>=20
> I think the only piece we're missing for that is for driver to run
> something like pm_runtime_init() that initializes the address space
> to hwmod. Or just bus specific ioremap like you're suggesting later
> on.
>=20
> Just to recap what we've discussed earlier, the reasons why we want
> reset and idle functions should be in the driver specific header are:
>=20
> 1. There's often driver specific logic needed in addition to the
>    syconfig tinkering in the reset/idle functions.

how about introducing generic device_reset() and device_idle() hooks
which driver can implement and can be called by bus glue ?

Something like:


diff --git a/include/linux/pm.h b/include/linux/pm.h
index 03d7bb1..9c921e2 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -256,6 +256,8 @@ typedef struct pm_message {
  *	these conditions and handle the device as appropriate, possibly queueing
  *	a suspend request for it.  The return value is ignored by the PM core.
  *
+ * @runtime_reset: Resets the device and puts it in a known state.
+ *
  * Refer to Documentation/power/runtime_pm.txt for more information about =
the
  * role of the above callbacks in device runtime power management.
  *
@@ -285,6 +287,7 @@ struct dev_pm_ops {
 	int (*runtime_suspend)(struct device *dev);
 	int (*runtime_resume)(struct device *dev);
 	int (*runtime_idle)(struct device *dev);
+	int (*runtime_reset)(struct device *dev);
 };
=20
 #ifdef CONFIG_PM_SLEEP


We already have ->runtime_idle() which we could be using...

> 2. We need to be able to reset and idle some hardware even if the
>    driver is not compiled in.

yeah, this will be tricky. Even if you try late_initcall() there could
still be issues with -EPROBE_DEFER. Maybe you don't need to reset the
IPs but rather put those which have status =3D "disabled" to FORCE_IDLE.

Wouldn't that be enough ? If a driver claims the device later, then
pm_runtime_enable() + pm_runtime_get() will change that.

--=20
balbi

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHdtUAAoJEIaOsuA1yqRECxwP/j9CwhYSesKxltKDOn7By8aJ
1Bp5hjDMOMYxYpSRIZ3ca+fUi9gefHF13UD+kYDxxOwRIaSImIi9ODNs3KxHDPyU
TaCfZK4sTtigVQQkBMKWFJgAMhjxXoAtiAi9C3nBAtxH5DHMn8rKlv0KY2As9JCW
RoAzBRi+wFo49wv8H9QVRXYmM7SERdmNhJPwXhVNVatOeExF4zor51VehJuK502R
AAugXaQIxNrym8MtM4H4KoORRTXoAEE9EXKYttLubk55M3pdPSY/Rbh2LXoUHg+d
0yTTOrIjCrOMQ5Sh3j2EXnfvaBuAZim2kvP4Fy66R6T2S/pd0dgYlK8Lo2gPhGAr
jwuzHSKFs250nKcUl/R/5+IO8Veg5EIVktOoyDnuGtnquoWsfFy9aFsi2TvEaQnT
TYd7dG3qkyews0LcyzZGXjnBTbX5Zw20FSL3wc+Au+X/gLMw4iR0Wcn6RhIhme0N
7g2Dveu5Qe3d369nakEK6RRC8SpSWXLMrQ0eHA4nauZ9y+JNt9qoohZV4PgDhGi2
nGskQnVBCkr3GFv6mmHAOqyTdSt+84kpwQvdj0Kh7iZxMpuiKVmXEkbRYHtbfbNm
OcLwe2IyxqLvfSs5QGlvFibAvR3myBAjJtfB2C0c1/NkFE469JYB0ucNEiCsmRUQ
L6mq0ToraYH1TpfiWANr
=ijjr
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
