From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 11/11] OMAPDSS: DPI: use VPLL2 regulator if VDDS_DSI is
 not found
Date: Sun, 17 Nov 2013 00:26:00 +0000
Message-ID: <20131117002600.GA14253@earth.universe>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
 <1384608224-9452-12-git-send-email-javier.martinez@collabora.co.uk>
 <20131116141853.GF10317@atomide.com>
 <5287908C.3040602@collabora.co.uk>
 <20131116154507.GL10317@atomide.com>
 <20131116160234.GB5104@earth.universe>
 <5287AB20.9070407@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:38061 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984Ab3KQA0F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Nov 2013 19:26:05 -0500
Content-Disposition: inline
In-Reply-To: <5287AB20.9070407@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Sat, Nov 16, 2013 at 06:28:00PM +0100, Javier Martinez Canillas wrote:
> > The hack, as being sent by Javier, will result in the wrong
> > regulator being used on the Nokia N900, which is using vaux1.
> > It must depend on the machine.
>=20
> I see, so this hack is not generic enough to be usable for all OMAP3 boar=
ds so I
> think is better to just add the hack on the DTS.
>
> I was more found about adding a hack on dpi.c since the DTB is an stable =
ABI
> while the dpi.c implementation is not.

I agree with this. My suggestion would be to get the vdds_dsi regulator name
=66rom platform data. This way each board can setup its own quirk until oma=
pdss
supports DT.

> But I guess is not that bad to change the DTS later once DSS DT
> bindings are added to mainline.

As far as I know DT bindings are supposed to be as stable as
possible.

> > At the same time the N900 device tree file uses V28 as
> > regulator-name for vaux1 (which is the same one as legacy boot
> > used). Nothing depends on this, but I don't think it's a
> > good idea to use this property. Apparently it does not work
> > if multiple drivers need the same regulator under different
> > names.
> >=20
> > -- Sebastian
> >=20
>=20
> So, what do you think about the following patch instead?
>=20
> [PATCH]

For Nokia N900 vaux1 is also used for si4713 radio chip, lis3lv02d
accelerometer and battery cover sensor, so I don't like this hack.

If vppl2 is only used for omapdss.dsi on IGEP boards it might be
sensible to label it, though? So it might be ok there.

-- Sebastian

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSiA0YAAoJENju1/PIO/qa7SQP/ingzGQ+p6c1gGfrF2aO/O/g
yFPLuv4OXYZfTjK2qBqJfgw5OyKCCQbvDrmZPaG7AQEauBfymhS46uwind/mHrVN
cxpOtJI4kL4SZzY2v10ceKQWL6LgM8eP15LoHyeS3NEXVVIVpaC1lA+JSTWa2uB1
PgbZUBLPMH1/3YGfenr+Dww7osysi+zgCdSkdmYXU3PyMwMFx8cthv34OS0Vu8va
lfhMtEVfKrmPemCH+KKShl65jwm8DsdNSp403/TGIOEV0GmP62KF+OYkdp4OXyaU
4Q9dIQZmbYvM96Jt0AeFhzOiP0MeC+/8xXwyH+wT2H0Snnganpp51Fmbcdeyd0TD
5AtXXmc2BGbhXucBX/mkVEhlxYSaYLWoCk0ToQI1NNXW4gPIR3stnjASQJYhb7J4
wFBsQP68fdm8FrwYCsISN1JKcdjMuLPiu9Yzt/iIrdQBDPZGE34iIR9W0RC0CHa1
vso9bETYO/t9knU8wcLp/sVN8MMu7fL3INlFPSzFH6n78qqqLlCpcQHsDKs9oV1G
QepTnrtbrk2fLudKVMiZSxXw/2j6fjEB6pvEaO9lWSEgLpW6xy78GStJTNdWv2is
EpugQfI1y0nvNyy9/oS5dFE18++ZCINEUA+ac9/McoY5YFP59bX5k0LI4rVA1i5Q
IsWu1J7+hXnAO6Rq+/cX
=UElP
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
