From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 06/15] twl4030_charger: split uA calculation into a
 function.
Date: Wed, 4 Mar 2015 20:20:33 +1100
Message-ID: <20150304202033.653292df@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
	<20150224043351.4243.86053.stgit@notabene.brown>
	<20150302210518.GM13270@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/.X.8r_4kaduJJ_QggtAFZ0I"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150302210518.GM13270@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/.X.8r_4kaduJJ_QggtAFZ0I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2015 22:05:18 +0100 Pavel Machek <pavel@ucw.cz> wrote:

> On Tue 2015-02-24 15:33:51, NeilBrown wrote:
> > We will need this calculation in other places, so
> > create functions to map between register value and uA value.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks.


>=20
> > +static int regval2ua(int regval, bool cgain)
> > +{
> > +	if (cgain)
> > +		return (regval * 16618 - 8500 * 1000) / 5;
> > +	else
> > +		return (regval * 16618 - 8500 * 1000) / 10;
> > +}
>=20
>    int res =3D (regval * 16618 - 8500 * 1000);
>    if (cgain)
>       return res / 5;
>    return res / 10;
>=20
> ?
> 									Pavel

Maybe ... not sure it is really more readable.  I think I'll leave it as is.

Thanks,
NeilBrown

--Sig_/.X.8r_4kaduJJ_QggtAFZ0I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPbOYTnsnt1WYoG5AQKqZw/9HVdxzOzOovcpsmM5jxO51ge9Yi37Lric
IYOGJYjG/2nV8gHtc/rl9KxAWizvBrhIiTDNPEmMuYSZX82Y1sDZVKLKkZJX5xbM
FdpSw/GkPBYcy/unasMuMcLz/S2yTyxWktbDUYgdbpX/Dn+R/XJ6SUKKYlB32GV0
sGf/trYN+SB/S1gjWhQyZGg9liLKyl1b9/rjuLrIYUSdCslbE4jimR2t0Nab+nhq
rfUu0kq1RfVHR4tmmfPTehM5m/SV71xQYirs0L7KpUr7VzuAnlbocBQwwb6wvv47
bGlXA87v+TbdgQiug0SvpTM9Z1jX5WVZslj9zT9iPIP0y24EoVZ2q3xWiRMwUnbt
kqvkR8oynggNkRf3wjihbE6LZzI+QYN3trJhCokNNE+a04xpAjC+RNW8ZWTPJtT7
+knHIkJsSkKQAreIZ8seILMRKOO4Lf/Hn7yh8Ze/0IGuxjWbIs9cPkQFObmDFAlw
fIzpXJxcxC/JqP9Yzp2W80dJ1qnca8dcVqZMBovb6JQe/uMTKqeM3jtu9eaWLHnw
fpq7DsPKinImNlaALVNOzVeYpY3MfIaxp6tCiLEZw+NA0Y1siiuJe5HqgjiU/Kxv
D1K9e/ebbDJ6hfMHpLJPP1p6xp9nvRyCyfOVtB/yFsoDvVKxNBkYycYtlQSK/jy4
HpAxfcg6aZM=
=2ueh
-----END PGP SIGNATURE-----

--Sig_/.X.8r_4kaduJJ_QggtAFZ0I--
