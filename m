From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/8] ARM: DRA7: id: Add cpu detection support for
 DRA7xx based SoCs'
Date: Tue, 30 Jul 2013 16:18:37 +0300
Message-ID: <20130730131837.GB28162@radagast>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
 <1375183546-12758-2-git-send-email-rnayak@ti.com>
 <20130730131009.GA28162@radagast>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46695 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752982Ab3G3NTM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 09:19:12 -0400
Content-Disposition: inline
In-Reply-To: <20130730131009.GA28162@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com

--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2013 at 04:10:09PM +0300, Felipe Balbi wrote:
> Hi,
>=20
> On Tue, Jul 30, 2013 at 04:55:39PM +0530, Rajendra Nayak wrote:
> > @@ -379,6 +407,13 @@ IS_OMAP_TYPE(3430, 0x3430)
> >  # define soc_is_omap543x()		is_omap543x()
> >  #endif
> > =20
> > +# if defined(CONFIG_SOC_DRA7XX)
> > +# undef soc_is_dra7xx
> > +# undef soc_is_dra75x
> > +# define soc_is_dra7xx()		is_dra7xx()
> > +# define soc_is_dra75x()		is_dra75x()
>=20
> since this platform is DT-only, couldn't we just believe DT-data to be
> correct of_machine_is_compatible() ? 2/3 of this patch would be removed.

s/correct of_/correct and use of_

--=20
balbi

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR970tAAoJEIaOsuA1yqREhagP/i50Q3DjAb8sqmVbqJTR1s/Z
UX8hd0YCUpMmqoQWhD23v+ru1qGPz6zoxZIt8Qb/4ekxVR5xXcSCiWWH8g7Z8kRm
s9jzRO6Ld8jC15yJY47OP/0LhBCa6KvSBBS5za0gqPVPpyJ4yuRL8wSG7qko027a
T6aGdPzPT4wG3lq0gQLHDbNJN0WxKVHLOEHskpUArxKzUKVtk8o4bWVlhuJ5+RPg
SyoGUelmflSsnbj/2TiKE3yrNbGhrkdM8Qud3SGVEq3HoAlZQXVs8Pu/65vadL1X
97VTGdVKDBXXl0VElzoourvPcPE3Zz0OmsoGOe9sElOGgSrcHhrOPV7jH4BGU0NN
bOTeJHwBbe/Ya//lMNsmQLzdbzKqTQCgsIBGW9jwtMSWb7s1w/oC2syxA9kbHQfj
A95/KeH4hNmoKcqWkHiqSECz0TRAYtB6K+66OWX5C5CKyluZGfmk8dgrAPfR5Cc8
31OuR81XTJ1Gy7lQiU49HT8FNeOJnEmkw/h16YGVHIEqT2+/GBWEpX7lrs9MrSB5
561ccpvINCeTqRF8RkTyaeQvduI6fRj2DH55bWQHMRuNmrwWfG/dXVLpxQgbhN0w
pXb88LP4qPmjf0VDoMAu/AnuYh94Nm3/8GlgdJ0ib1mi7zICszCBOXUedBNiXQSL
yiVeM6S8IsvEZ7wqpNZR
=k05/
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
