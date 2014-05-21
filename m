From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv5 09/10] DTS: ARM: OMAP3-N900: Add SSI support
Date: Wed, 21 May 2014 22:09:28 +0200
Message-ID: <20140521200928.GA27602@earth.universe>
References: <1399739870-13526-1-git-send-email-sre@kernel.org>
 <1399739870-13526-10-git-send-email-sre@kernel.org>
 <20140514215503.GM27426@atomide.com>
 <20140520003538.GD15793@atomide.com>
 <20140521182513.GA26285@earth.universe>
 <20140521184319.GL17417@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140521184319.GL17417-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Carlos Chinea <cch.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon-uiMcrn6V0Vs@public.gmane.org>, Joni Lapilainen <joni.lapilainen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 21, 2014 at 11:43:19AM -0700, Tony Lindgren wrote:
> > > Just noticed that this patch seems to somehow break idle
> > > modes on n900, so dropping both dts changes for now.
> > >=20
> > > Basically the n900 debug LEDs won't ever go off with
> > > these two dts patches enabled, even without the modem
> > > drivers loaded. I did not dig deeper, but it's probably
> > > something related to hwmod using this data for some
> > > settings.
> >=20
> > Is hwmod data interpreted at all without the DT entries?
>=20
> Yes for autoidling unused devices. We parse that with
> omap_device_build_from_dt().

That function seems to parse DT stuff. What I meant was
not without the *driver*, but without the *DT entry*.

I think the hwmod entries are completly ignored until there
is a DT device?

> > The hwmod data may be wrong. The information from commit
> > 398917ce161e10d3c66afaefdb89c73c64c4b02d was simply
> > interpolated from all information I found. The OMAP3
> > public TRM does not contain *any* information about the
> > ssi IP-Core.
>=20
> It's probably something with the sysc or idlemodes that
> keeps things from idling. Maybe wrong address? Or wrong
> flags? I'm pretty sure it was the first .dts patch out of
> these two as the second one alone did not apply.
> =20
> > > Sorry did not notice it earlier as I did not have the
> > > PM regression fix patches merged with my testing branch.
> >=20
> > I hoped to see working modem in 3.16, which will probably
> > be used for the next Debian stable :(
>=20
> That would indeed be nice, let's try to debug it as we
> still have few days.

I will have a look at it now.

> I'm finally able to test for PM regressions with DT patches,
> too > bad we did not have that earlier because of multiple issues.

Yes. More time would have been nice.

> Anyways, this dts issue should not prevent merging the
> driver changes, I'm all for that!

Of course, driver changes are unrelated. They are already
in linux-next btw.

-- Sebastian

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTfQf3AAoJENju1/PIO/qaWU0P/3vysiu5gPpGFreQQu57RqGP
lVzlQ5xczUbYN+Z8FGUR6VzPXD0/uTsAer7EXrwe+h7WeMdeQo7m4w6UEi6urCWD
n4X6eW7rnT7DeFhEY0dWRgWXTDQMGz+EmhWjfeclMkKVQEa6R3MFXfi79Vbr3BL8
BMddwDOjTjtPZCngwWxLoWrZLcvM+rDJ4XlBzi+XyvQGKJufoJgpXDinK63YqIdG
eE8VNP8D1xJLri5Hiaz7reHRW8EgyJbkqMjWrY1jskyyfiZRae0PAIPhfRc2b1Wa
tQFiZd+pMaga0N8JbEh1cjgx90wyRSskcn0x0MSXqs6RVj3bX03qxZgVApKA2JpJ
kK0sqWhtQdM4qol6x+TyezvMF+1qoQKP4OfvpDsNpbUtGx1cWK/Ae0EVSP6LgRMC
lWl2GMP3/J0UiHcqMM7ncDt67XfjSnuzON656w1DOAJBK3gJyLb2miU0umJEQnlP
IHgUxZ3kwSMFfCfjWSopZFujeBpsz30rVK0tWV/jPs3mVpYGW6F0KoS84ZwwTOdV
d5FnBl7PspkjLDvi8pZxSGvmEl3i3nUZtJXlmZHip1eCDCzwmOBc7zood478PP07
ZTpZzQ3iVWi/YjctAqzAGHtqRe53r/dKRrD0UFtiKVZdqNpxlPRNe+j3ErT1sdrr
zaHuSiOvdVHxHn5UwuPu
=NHrf
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
