From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 03/13] twl4030_charger: correctly handle -EPROBE_DEFER
 from devm_usb_get_phy_by_node
Date: Thu, 10 Sep 2015 10:08:50 +0200
Message-ID: <20150910080849.GA6164@earth>
References: <20150730001113.4012.18086.stgit@noble>
 <20150730001124.4012.31980.stgit@noble>
 <CAMAWPa__hFOuz24YBcFiR+m5mOUArSuNpuqh3Ju1H+yj6qadfA@mail.gmail.com>
 <CAMAWPa_s2ELgRBRtWzFucmREMuLXS_V5Akmad5yFU13-GrzBDA@mail.gmail.com>
 <87si6x4a2f.fsf@notabene.neil.brown.name>
 <20150902130724.GQ4215@atomide.com>
 <CAMAWPa8q1BOMvvKqqU88vYq4-_QhuxefVqkM6=4BP4-FGZxRPw@mail.gmail.com>
 <20150908201417.GG4215@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150908201417.GG4215@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@kernel.org>, Neil Brown <neil@brown.name>, Samuel Ortiz <sameo@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, lkml <linux-kernel@vger.kernel.org>, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap <linux-omap@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Tyler Baker <tyler.baker@linaro.org>
List-Id: linux-omap@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 08, 2015 at 01:14:17PM -0700, Tony Lindgren wrote:
> * Kevin Hilman <khilman@kernel.org> [150908 11:36]:
> > On Wed, Sep 2, 2015 at 6:07 AM, Tony Lindgren <tony@atomide.com> wrote:
> > > * Neil Brown <neil@brown.name> [150901 23:23]:
> > >> Kevin Hilman <khilman@kernel.org> writes:
> > >>
> > >> > ping... this boot failure has now landed in mainline
> > >>
> > >> sorry, I'm on leave at the moment and travelling so I'm unlikely to =
be
> > >> able to look at this properly.  I should be able to examine this iss=
ue
> > >> before the end of the month but cannot promise sooner than that (tho=
ugh
> > >> it is not impossible).
> > >>
> > >> Maybe it would be best to just revert it until a proper analysis can=
 be
> > >> done.
> > >
> > > OK yeah let's revert this one for now until we know what goes wrong.
> >=20
> > Looks like this is still in mainline.
> >=20
> > Tony, can you revert?
>=20
> Probably best that Sebastian does it as there's another fix needed
> too. It seems the following are needed:
>=20
> - Revert $subject patch 3fc3895e4fe1 ("twl4030_charger: correctly
>   handle -EPROBE_DEFER from devm_usb_get_phy_by_node")
>=20
> - Apply compile fix "[PATCH] twl4030_charger: fix another compile
>   error"
>=20
> Just in case Sebastian is travelling or something..

Right, I was on vacation without internet access until now.

> Sebastian, can you please confirm?

Sounds fine to me. I will take care of it once I've slept a bit.

-- Sebastian

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJV8TqJAAoJENju1/PIO/qa6SwP/jepTsWYlxhOsM4Dz0LICkpD
DLK1cvFAJgPDj9nI1a6IKdLqX7fqB8kJ7UnFm+MY75mI8Q0N5TT+7hiQkgQczB8e
xzQpOasfoHaccZTTljxcbERxK7JKsqQN+qDlsMEvCd22gs6LeEYSyv57glHGFZey
AXuw0ISxeXyG9vV5+U47FFszhv7FXVW2CDFxiblt9yFRObtIo+aXqG9JtaO1ZTbN
kbTqS7pma+Rm489884+Wws+TVd0t7djOssVTskA/YZ4VIWMwJNTvYpv5SnGmrk3L
V1TKCmhnYmf14GHa6V+dJwTHktSwPGDIzUTh7lPIYRA4GxN+nkDZHaRlI/krynBo
fjD6Qbhb6YIxOkq9RZkQSh1xpWdnTHwvRwv+eXEsQ1WMi+cc2fznzLx1UIO/nfAu
sWCo4Mt76hKvOCZZtK6lTm9tsUz9LZAfXSBJAo7XH37NjwMqXKmWE3309LPFvAnC
haXWQwNwFSt4guTMSFOoQI1L37fqdy9ifDHmFeMHle/0nh4x9cRbCt40dQtp5dU/
UfBXDcEvN5xc70uxcmlqQL7T0XKeW+m98pQSBSU4JAaA4b+ZfiCxoZwTz1TOOPAt
THM8080GJ6T5cA4M5yoEaqzLsLSA6jchTmoJhTWgRfastxzqLnYtP6gUdqzzqiHj
LB/69vmQgOUg8in/OS9V
=DbD4
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
