From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: Please revert 3eea8b5d68c801fec788b411582b803463834752 as it
 breaks touchscreen on n900.
Date: Mon, 1 Jun 2015 23:22:26 +0200
Message-ID: <20150601212226.GH23777@lukather>
References: <20150529195629.GA9811@amd>
 <20150529201745.GC17267@lukather>
 <20150529202123.GY2026@saruman.tx.rr.com>
 <20150529202954.GA26494@localhost>
 <20150529203456.GC22083@amd>
 <20150601095556.GH17267@lukather>
 <20150601140605.GA26908@amd>
 <20150601145825.GA20557@lukather>
 <20150601152111.GA14015@amd>
 <20150601174730.GA30024@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="utPK4TBebyzZxMrE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39790 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752872AbbFAVZF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2015 17:25:05 -0400
Content-Disposition: inline
In-Reply-To: <20150601174730.GA30024@dtor-ws>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com


--utPK4TBebyzZxMrE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Mon, Jun 01, 2015 at 10:47:30AM -0700, Dmitry Torokhov wrote:
> On Mon, Jun 01, 2015 at 05:21:11PM +0200, Pavel Machek wrote:
> >=20
> >=20
> > > > > > The 3eea8b5d68c801fec788b411582b803463834752 is just bad.
> > > > >=20
> > > > > You were very welcome to review this patch at the time and/or sug=
gest
> > > > > a fix that pleases everyone.
> > > >=20
> > > > You should be the one that should suggest fixes, as you broke it in
> > > > the first place. But clearly you don't understand that.
> > >=20
> > > You actually never asked for a fix, and went head first calling this
> > > patch "bad" and asking for nothing but reverting it.
> >=20
> > Date: Fri, 29 May 2015 21:08:16 +0200
> > Subject: 4.1 touchscreen regression on n900 -- pinpointed [was Re:
> > linux-n900
> > ...
> > Maxime, can you suggest a fix?
>=20
> How about we do something like below (it needs a small edt-ft5x06 fixup
> that I'll send separately). Not tested.
>=20
> Thanks.
>=20
> --=20
> Dmitry
>=20
>=20
> Input: improve parsing OF parameters for touchscreens
>=20
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> When applying touchscreen parameters specified in device tree let's make
> sure we keep whatever setup was done by the driver and not reset the
> missing values to zero.
>=20
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c     |    2 -
>  drivers/input/touchscreen/of_touchscreen.c |   67 ++++++++++++++++++----=
------
>  drivers/input/touchscreen/tsc2005.c        |    2 -
>  include/linux/input/touchscreen.h          |    5 +-
>  4 files changed, 48 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touch=
screen/edt-ft5x06.c
> index 29d179a..394b1de 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -1041,7 +1041,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *c=
lient,
>  			     0, tsdata->num_y * 64 - 1, 0, 0);
> =20
>  	if (!pdata)
> -		touchscreen_parse_of_params(input);
> +		touchscreen_parse_of_params(input, true);
> =20
>  	error =3D input_mt_init_slots(input, MAX_SUPPORT_POINTS, INPUT_MT_DIREC=
T);
>  	if (error) {
> diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/t=
ouchscreen/of_touchscreen.c
> index b82b520..c132624 100644
> --- a/drivers/input/touchscreen/of_touchscreen.c
> +++ b/drivers/input/touchscreen/of_touchscreen.c
> @@ -14,14 +14,22 @@
>  #include <linux/input/mt.h>
>  #include <linux/input/touchscreen.h>
> =20
> -static u32 of_get_optional_u32(struct device_node *np,
> -			       const char *property)
> +static bool touchscreen_get_property_u32(struct device_node *np,
> +					 const char *property,
> +					 unsigned int default_value,
> +					 unsigned int *value)
>  {
>  	u32 val =3D 0;
> +	int error;
> =20
> -	of_property_read_u32(np, property, &val);
> +	error =3D of_property_read_u32(np, property, &val);
> +	if (error) {
> +		*value =3D default_value;
> +		return false;
> +	}
> =20
> -	return val;
> +	*value =3D val;
> +	return true;

This looks good.

However, of_property_read_u32 already does the right thing here by not
update val if the property is not found.

So I guess you could just do:

*value =3D default_value;
return of_property_read_u32(np, property, value) ? true : false;

It looks good otherwise.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--utPK4TBebyzZxMrE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbM0SAAoJEBx+YmzsjxAgBo0P/0yqiHHAm2samBbIpfHcoiSM
4Yf/kR0TA3Rmfb+/AXdfm1FtRb59HaSc3qA9O+JQ+yIliBX5i7FNdjENDzBFAzRT
o+uqsaq1tEgheh4d+/eInu7+eHydtP2BIzmSNACckkOQYF7Jv5y51FukmV3LzFFP
sl2bchYnvUgyz1s9UQUvUT/aTkPLFVDQUh0mXUa8ZJ9fZ5sMZ3oTU7o5yB5S+sxa
BpABUfhsFg1CMxsmYWJSpV0kiX94EVIzJDdQ0dTITlkIlM3ydNPl9IKWLQrNF2+a
0rqEykBag9rpK939Tig9yR4TYFBrsvbd/+QanifZdJnMTKz4dJlPfk7xV47WGrgB
tRU9UJg/ewKcksUraCvFhYPiMZFQrhrMRPIxfpeZYiOHgkZ8jlFF7R0sGoPhxaLk
Pq6LNxvcPdhn9yUp7vRnQUgdr2Q3tH9MnXlz4qY3dSTr1kIRi70wqinKSwgYXOvO
6EPZxTrfi3hmcn86U7sVFcU7SDgqaytedBX7FggR9qix+utWsZkXi2RjTxxIo5m7
7vhVwsOTPTA5O/9cAxD+MI1tqS4fG097VmBT1Fge2DIx1kRWgnrMxiGoSAY6LByq
l50Zhv1DaWwNJD2P5fS2p4q8ccjo3Q9UBC0B1mTh1mQs0ZRvr+N+P2JS/DKZeHsy
CRmHxbISVy91/SZrn7kl
=SxOu
-----END PGP SIGNATURE-----

--utPK4TBebyzZxMrE--
