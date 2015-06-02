From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: Please revert 3eea8b5d68c801fec788b411582b803463834752 as it
 breaks touchscreen on n900.
Date: Tue, 2 Jun 2015 11:44:47 +0200
Message-ID: <20150602094447.GW23777@lukather>
References: <20150529202123.GY2026@saruman.tx.rr.com>
 <20150529202954.GA26494@localhost>
 <20150529203456.GC22083@amd>
 <20150601095556.GH17267@lukather>
 <20150601140605.GA26908@amd>
 <20150601145825.GA20557@lukather>
 <20150601152111.GA14015@amd>
 <20150601174730.GA30024@dtor-ws>
 <20150601212226.GH23777@lukather>
 <20150601213213.GB14395@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kigERAySUJmIn/9g"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52725 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754625AbbFBJpD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 05:45:03 -0400
Content-Disposition: inline
In-Reply-To: <20150601213213.GB14395@dtor-ws>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com


--kigERAySUJmIn/9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2015 at 02:32:13PM -0700, Dmitry Torokhov wrote:
> On Mon, Jun 01, 2015 at 11:22:26PM +0200, Maxime Ripard wrote:
> > Hi Dmitry,
> >=20
> > On Mon, Jun 01, 2015 at 10:47:30AM -0700, Dmitry Torokhov wrote:
> > > On Mon, Jun 01, 2015 at 05:21:11PM +0200, Pavel Machek wrote:
> > > >=20
> > > >=20
> > > > > > > > The 3eea8b5d68c801fec788b411582b803463834752 is just bad.
> > > > > > >=20
> > > > > > > You were very welcome to review this patch at the time and/or=
 suggest
> > > > > > > a fix that pleases everyone.
> > > > > >=20
> > > > > > You should be the one that should suggest fixes, as you broke i=
t in
> > > > > > the first place. But clearly you don't understand that.
> > > > >=20
> > > > > You actually never asked for a fix, and went head first calling t=
his
> > > > > patch "bad" and asking for nothing but reverting it.
> > > >=20
> > > > Date: Fri, 29 May 2015 21:08:16 +0200
> > > > Subject: 4.1 touchscreen regression on n900 -- pinpointed [was Re:
> > > > linux-n900
> > > > ...
> > > > Maxime, can you suggest a fix?
> > >=20
> > > How about we do something like below (it needs a small edt-ft5x06 fix=
up
> > > that I'll send separately). Not tested.
> > >=20
> > > Thanks.
> > >=20
> > > --=20
> > > Dmitry
> > >=20
> > >=20
> > > Input: improve parsing OF parameters for touchscreens
> > >=20
> > > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > >=20
> > > When applying touchscreen parameters specified in device tree let's m=
ake
> > > sure we keep whatever setup was done by the driver and not reset the
> > > missing values to zero.
> > >=20
> > > Reported-by: Pavel Machek <pavel@ucw.cz>
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >  drivers/input/touchscreen/edt-ft5x06.c     |    2 -
> > >  drivers/input/touchscreen/of_touchscreen.c |   67 ++++++++++++++++++=
----------
> > >  drivers/input/touchscreen/tsc2005.c        |    2 -
> > >  include/linux/input/touchscreen.h          |    5 +-
> > >  4 files changed, 48 insertions(+), 28 deletions(-)
> > >=20
> > > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/t=
ouchscreen/edt-ft5x06.c
> > > index 29d179a..394b1de 100644
> > > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > > @@ -1041,7 +1041,7 @@ static int edt_ft5x06_ts_probe(struct i2c_clien=
t *client,
> > >  			     0, tsdata->num_y * 64 - 1, 0, 0);
> > > =20
> > >  	if (!pdata)
> > > -		touchscreen_parse_of_params(input);
> > > +		touchscreen_parse_of_params(input, true);
> > > =20
> > >  	error =3D input_mt_init_slots(input, MAX_SUPPORT_POINTS, INPUT_MT_D=
IRECT);
> > >  	if (error) {
> > > diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/inp=
ut/touchscreen/of_touchscreen.c
> > > index b82b520..c132624 100644
> > > --- a/drivers/input/touchscreen/of_touchscreen.c
> > > +++ b/drivers/input/touchscreen/of_touchscreen.c
> > > @@ -14,14 +14,22 @@
> > >  #include <linux/input/mt.h>
> > >  #include <linux/input/touchscreen.h>
> > > =20
> > > -static u32 of_get_optional_u32(struct device_node *np,
> > > -			       const char *property)
> > > +static bool touchscreen_get_property_u32(struct device_node *np,
> > > +					 const char *property,
> > > +					 unsigned int default_value,
> > > +					 unsigned int *value)
> > >  {
> > >  	u32 val =3D 0;
> > > +	int error;
> > > =20
> > > -	of_property_read_u32(np, property, &val);
> > > +	error =3D of_property_read_u32(np, property, &val);
> > > +	if (error) {
> > > +		*value =3D default_value;
> > > +		return false;
> > > +	}
> > > =20
> > > -	return val;
> > > +	*value =3D val;
> > > +	return true;
> >=20
> > This looks good.
> >=20
> > However, of_property_read_u32 already does the right thing here by not
> > update val if the property is not found.
>=20
> I know but it is not documented anywhere (as far as I know) so I'd
> rather not rely on the implementation detail that might change in the
> future. This is not a hot path so extra assignment should not hurt.

It is actually: http://lxr.free-electrons.com/source/drivers/of/base.c#L1231

But you're right that it's mostly a cosmetic change.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--kigERAySUJmIn/9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbXsPAAoJEBx+YmzsjxAg8QUP/jVDfeVUTeFycL4CTKovR1Yv
WtASSD2tUs+xBILWhVbUq8MlkxhFouabnffOvZzm/7n7gODx0LIorIr+ydq6XVC4
N2ykQHZdvjmrMZfn3EBOAHj1qOkjD4yN/VpcoEi5axa/15LuSSukeyJ/fg+qtY9o
UdiCRxXGq1+7GHj/rbQyq27KNRJQEBFswONikxf/e65QnlD/hCtcgThCB+Lk1MyP
HwPEfVyNnId6o2mLNi1AMkejXvP+kVDqMAIxwd2I+dzSzqpsXrbnx03/ljBbAHeo
ELGc96w0QWYNqstmG9PEuG28ZrY5NGqWcDatIW8Crq94zr0CKDvtOeSXzMQ0GKjk
TsCD5TX+gbKXIg85q1Enz0qIwSXEnuCq8Qv4hZe3UzOhDBNpj06M92Jb6B+lcFoy
vqJoUdD/Wjg6qO5ivnMtcP7hskvbkD+gwjwOpexcrI4Ru6+6goHaCJ9thuCZdWn7
xiD9Qi2KM6k8MvTVggVPhyZkEIiVbCYqx+MvpJ8kd2SyZaAp5OhaEPkb8Bz3Jyb3
JWmjSABdNdFOApBiA50LdjTPJqnnZg4/OMFzO3m9SwUY7y9F99pwlgjBS1jzREos
IDZ7bBHwyYMQgiqMu1MUpha6DhWYMlnV/7JTOmd7WXAKqAXwsLHN9FlLAdYYSbqa
X+8iVQSwPlRVSM8GOn4t
=4cRU
-----END PGP SIGNATURE-----

--kigERAySUJmIn/9g--
