From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCHv2 0/6] Motorola Droid 4 Audio Support
Date: Tue, 18 Jul 2017 11:29:31 +0200
Message-ID: <20170718092931.be3lyp6m6xvjb5yv@earth>
References: <20170712151846.24621-1-sebastian.reichel@collabora.co.uk>
 <20170717092904.GG10026@atomide.com>
 <20170717101258.llyly7kwfnwtoftr@earth>
 <20170717101709.GI10026@atomide.com>
 <20170717141347.t2642xbkol3g36rv@earth>
 <20170718054833.GL10026@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6xvynjf42wkfexow"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170718054833.GL10026-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--6xvynjf42wkfexow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 17, 2017 at 10:48:33PM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> [170717 07:14]:
> > Hi,
> >=20
> > On Mon, Jul 17, 2017 at 03:17:10AM -0700, Tony Lindgren wrote:
> > > * Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> [170717 03:13=
]:
> > > > On Mon, Jul 17, 2017 at 02:29:04AM -0700, Tony Lindgren wrote:
> > > > > * Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> [170712 0=
8:19]:
> > > > > >  * Switch from simple-audio-card to audio-graph-card
> > > > >=20
> > > > > Gave this a quick try against v4.13-rc1 with SND_AUDIO_GRAPH_CARD
> > > > > enabled as a loadable module. However loading it oopses for me,
> > > > > see below. Maybe some dependencies are missing?
> > > >=20
> > > > It works for me on top of v4.13-rc1 (my kernel is monolithic).
> > > > Looking at the stacktrace it seems to be a bug in audio graph
> > > > card and not in the codec driver.
> > >=20
> > > OK I do also have:
> > >=20
> > > CONFIG_DEBUG_LOCKDEP=3Dy
> > > CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
> >=20
> > I added those and I do not get a stacktrace for anything sound
> > related and audio works. I noticed one issue in dapm routing,
> > that I accidently added. That will be fixed in PATCHv3, but its
> > in untestable path anyways (EXT capture, probably FM radio is
> > connected to EXT).
>=20
> Hmm maybe that was not with DEBUG_ATOMIC_SLEEP then?

$ grep DEBUG_ATOMIC_SLEEP .config
CONFIG_DEBUG_ATOMIC_SLEEP=3Dy

> I also verified it does not happen unless your dts patch "ARM:
> dts: omap4-droid4: add soundcard" is applied.

That's what I expected, since the stacktrace started in the
soundcard driver.

> I doubt that having it as loadable module makes any difference
> here as it's the might_sleep() in __mutex_lock_common() producing
> the BUG.

It might make a difference, since it changes the probe order. The
mutex may not even be called on my system.

-- Sebastian

--6xvynjf42wkfexow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllt1PgACgkQ2O7X88g7
+pq/kg//SrM2ssCOEO4Mz+LfwGQyYkVm0+6oeNoPqKipphlB67qbm+ZCGIMfoIuL
aWoM+opwpqFfMCulfT2p7A/4l1unRCnKY0uVi4X6F6WM44qMDtO65RFATZZl4MPq
wkLh3COjRPfkH2USVlTApF4hHE3wff7Cu5ZnF4SyKrMLwdc11NeABG4h8CNW9yGu
cA01HK09VbmUIW1XLcpB/1pH61JC3I8d6gn7l9vBJpm1oVRUetka7pRAaq3NyanP
tYkswpbSfCQr+cNFLTHZaR3IJSk4KfQZb2Ftiln7F1l6kjg5aDXsA7OPcUAgwPHj
9ZUCSGN35Q7OAvoDKMtxUWomIjPMLkbUBf/fIEND42hDoePncMFxQQsRIPfheUxw
Ixj6LVfsmapH+t9LPYNnD6Gaj0/4PTSTa3CMgvuaSESNppfnpIuzgYljqpizjieA
3Wy6kSUYPGogFi9U4pRdCWl7NmCkn2Mwk7bxQbpPlayl7/GPp8pXw9I0483XbCNe
9ix+EjcCPUYWvKErual4wC+6s1gZg1hhP71G/aAnd3FFPAt8Ej+Z6t4PAsE9z93/
c7slYjyqlMDSw4uRGlVTK+3S0KbPVmfJrZFLEQ9LU6cN7UF7unHwhKetCVbaqEqG
04nO9EiGOZnnkKIOZoAtbROIy6XwEVIHx0x+fznLU+YyjJJFHNA=
=qdXf
-----END PGP SIGNATURE-----

--6xvynjf42wkfexow--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
