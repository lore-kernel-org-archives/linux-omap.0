From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/8] i2c: omap: introduce and use OMAP_I2C_IP_VERSION_3
Date: Mon, 22 Oct 2012 15:28:53 +0300
Message-ID: <20121022122853.GW14033@arwen.pp.htv.fi>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1350899218-13624-6-git-send-email-balbi@ti.com>
 <50853BA8.8000200@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2mUf73N0HmzM2Naa"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34032 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745Ab2JVMey (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 08:34:54 -0400
Content-Disposition: inline
In-Reply-To: <50853BA8.8000200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de, ben-linux@fluff.org, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

--2mUf73N0HmzM2Naa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 22, 2012 at 02:27:20PM +0200, Benoit Cousson wrote:
> Hi Felipe,
>=20
> On 10/22/2012 11:46 AM, Felipe Balbi wrote:
> > on OMAP4+ we want to read IRQSTATUS_RAW register,
> > instead of IRQSTATUS. The reason being that IRQSTATUS
> > will only contain the bits which were enabled on
> > IRQENABLE_SET and that will break when we need to
> > poll for a certain bit which wasn't enabled as an
> > IRQ source.
> >=20
> > One such case is after we finish converting to
> > deferred stop bit, we will have to poll for ARDY
> > bit before returning control for the client driver
> > in order to prevent us from trying to start a
> > transfer on a bus which is already busy.
> >=20
> > Note, however, that omap-i2c.c needs a big rework
> > on register definition and register access. Such
> > work will be done in a separate series of patches.
>=20
> Do you need OMAP_I2C_IP_VERSION_3 for OMAP4?
>=20
> OMAP_I2C_IP_VERSION_2 was already introduced to detect OMAP3630 vs
> omap4430 because they were sharing the same IP version..
>=20
> /* I2C controller revisions present on specific hardware */
> #define OMAP_I2C_REV_ON_2430            0x36
> #define OMAP_I2C_REV_ON_3430_3530       0x3C
> #define OMAP_I2C_REV_ON_3630_4430       0x40
>=20
> So in theory you should not need an extra version.

are you sure that's how they're used ? Looking at the code where we
choose reg_map_ip_v1 and reg_map_ip_v2:

1120         if (dev->dtrev =3D=3D OMAP_I2C_IP_VERSION_2)
1121                 dev->regs =3D (u8 *)reg_map_ip_v2;
1122         else
1123                 dev->regs =3D (u8 *)reg_map_ip_v1;

And looking at reg_map_ip_v1:

 218 static const u8 reg_map_ip_v1[] =3D {
 219         [OMAP_I2C_REV_REG] =3D 0x00,
 220         [OMAP_I2C_IE_REG] =3D 0x01,
 221         [OMAP_I2C_STAT_REG] =3D 0x02,
 222         [OMAP_I2C_IV_REG] =3D 0x03,
 223         [OMAP_I2C_WE_REG] =3D 0x03,
 224         [OMAP_I2C_SYSS_REG] =3D 0x04,
 225         [OMAP_I2C_BUF_REG] =3D 0x05,
 226         [OMAP_I2C_CNT_REG] =3D 0x06,
 227         [OMAP_I2C_DATA_REG] =3D 0x07,
 228         [OMAP_I2C_SYSC_REG] =3D 0x08,
 229         [OMAP_I2C_CON_REG] =3D 0x09,
 230         [OMAP_I2C_OA_REG] =3D 0x0a,
 231         [OMAP_I2C_SA_REG] =3D 0x0b,
 232         [OMAP_I2C_PSC_REG] =3D 0x0c,
 233         [OMAP_I2C_SCLL_REG] =3D 0x0d,
 234         [OMAP_I2C_SCLH_REG] =3D 0x0e,
 235         [OMAP_I2C_SYSTEST_REG] =3D 0x0f,
 236         [OMAP_I2C_BUFSTAT_REG] =3D 0x10,
 237 };

that's really not the register map on OMAP3. That only looks valid for
OMAP1.

-ECONFUSED

--=20
balbi

--2mUf73N0HmzM2Naa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhTwFAAoJEIaOsuA1yqREYCQQAIG9uYTejSO9I2/Yju2P2AbA
UA4OW5uGAu5jc8c/K3g6wvdiL+bjAO8rv0JBDV1p7AZcHBpoql7MjrJIqqvzhhlQ
biKmWDCUUE3g6SInhSqFlTQnBdQfU7qLwCAnTYh9Qd0/ypTuZmjiY+BTcpZ+qU2Y
mDJdiF5IIwxP9wXXAGJGAQYgGZ57d0AyFGvUlyvW69YUohufKod49WkjXIXg+u+4
R+yQ7843antajwFYfPEixPllpsnaKjstxCmVjabys18Xs6LpGpSZe2piGALJ2xFp
s7PzkMBu6Thl+TY3rWaQ4CkfUz2GpgykpExi8gduwIZoAGMaAzITb1x2FE9X8vsO
ThWQx6BQNMerWL/hMbv8UTdufKvarXizTQ37jJPRtfhA2EMS4f0m8KwsRuwkX3ES
1V4L/AJhvd2LD9bK5f9ba/vk5r3thaABsxRbISqp518UEjpW3oZjKnXxlw6Cctxs
rvppHsUp07J1MWd/aVIG5sZHeQFA6edrX1cOzt7fLNblfrbp8r0pze4DLwcm1Cvy
++nKf98r5q0pjHZ2Co6LpSw8T8LeRGCkih4spUr9g4HAB+q5oUUuudX5T3Xqj0TV
J/Z1wWM4GSfm0SGYnOLsDm53qV0FikdIcyeo7i01uZG/979n2DhdFuLh+e9dis5L
cLqT64LhV5d66Iz20UoN
=O/DY
-----END PGP SIGNATURE-----

--2mUf73N0HmzM2Naa--
