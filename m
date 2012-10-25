From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] i2c: omap: re-factor omap_i2c_init function
Date: Thu, 25 Oct 2012 13:09:15 +0300
Message-ID: <20121025100915.GB21217@arwen.pp.htv.fi>
References: <1351147011-6500-1-git-send-email-shubhrajyoti@ti.com>
 <20121025063608.GA5084@arwen.pp.htv.fi>
 <CAM=Q2ctcxO2eFFBDdF_Mwt1bm34pj5hvJW4AS6V-GQVTVGz98Q@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41586 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422763Ab2JYKPi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 06:15:38 -0400
Content-Disposition: inline
In-Reply-To: <CAM=Q2ctcxO2eFFBDdF_Mwt1bm34pj5hvJW4AS6V-GQVTVGz98Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: balbi@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de

--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 25, 2012 at 03:04:29PM +0530, Shubhrajyoti Datta wrote:
> On Thu, Oct 25, 2012 at 12:06 PM, Felipe Balbi <balbi@ti.com> wrote:
>=20
> [...]
> >> +      * Don't write to this register if the IE state is 0 as it can
> >> +      * cause deadlock.
> >> +      */
> >> +     if (dev->iestate)
> >> +             omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
> >> +}
> >> +
> >>  static int omap_i2c_init(struct omap_i2c_dev *dev)
> >>  {
> >> -     u16 psc =3D 0, scll =3D 0, sclh =3D 0, buf =3D 0;
> >> +     u16 psc =3D 0, scll =3D 0, sclh =3D 0;
> >>       u16 fsscll =3D 0, fssclh =3D 0, hsscll =3D 0, hssclh =3D 0;
> >>       unsigned long fclk_rate =3D 12000000;
> >>       unsigned long timeout;
> >> @@ -337,11 +358,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> >>                        * REVISIT: Some wkup sources might not be neede=
d.
> >>                        */
> >>                       dev->westate =3D OMAP_I2C_WE_ALL;
> >> -                     omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
> >> -                                                     dev->westate);
> >
> > remove the comment too since now that's done by some other function ?
>=20
> The comment is applicable to the OMAP_I2C_WE_ALL value.
> So I thought it could be kept.
>=20
> dont feel strongly though.

I see. that's ok then.

--=20
balbi

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiQ/LAAoJEIaOsuA1yqREhwsQAJ5Obzkx3USXo0RHZjAm93wr
vdHZ/kClsCg+N6DJ5PQM5hvOHPyO3vNSYhWaxc6c+zRPr76/w3Qh1NIzhGW3Qgnc
bTCdxRpMvIIZPOenJcy1Ac+DmIu2ldslq0iZvSPa3jiRhyRVQ1JKg2eECYuD5roX
m5/z/aBb0H/O0qhKpHjT2vZ14YCBtyL33L1N1MyUYOA6rEf9yIOl3F5GvjBo2/NV
SHfbbj71lJc7M0qVgCoOf1ZB6MGrlZRClu02YwSv4H5Gbfjbm2IFCbPGNOBDgSf6
LQu1q/A1369aIP0NC65E5MuO7frIfh32LOj3ewSZh4k3jZVwDWWgMLxmj+CuDHDE
dEq/4wqzRBYoQcEqZ+BxOedH+WQeXDU2Akw5OzTGhZrSot9Fk2DHAqT7z8Kc8DMJ
g2LIA36y1cBydSfHSfy/Hkwc/wS1ZscXGbq5tIUx6FRqAqho20uZRqU8ffLg3t4i
BUbYv9C//ZAcirh6s49yA0Dt3Tfdjhxjtim7AvQAMFXxwRtHo8cqbe4zsRr+s/zj
lhEG+jas2SCJCvykzsuerMfxsw9JlQYx+StaZedYqqncIOPKkCk6RHuLQVWT1RJP
CampC4TXVaAyT95R4w1aBvx2DNXW69O04A2WmfaV/4hCEQh5aKkrHvrqw0KkVIzV
HQ9LgqqO2XYP+l5PERJW
=ibo+
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
