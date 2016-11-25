From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: twl6030: add dependency on OF
Date: Fri, 25 Nov 2016 13:17:55 +0000
Message-ID: <20161125131755.7qbtcbjwjeuff4og@sirena.org.uk>
References: <20161125074335.6947-1-Nicolae_Rosia@mentor.com>
 <20161125130337.lf33cysb4cyq6axl@sirena.org.uk>
 <CAKP5S=1Ds0-cz7qHiRbLPQj2e0fwaPXFExhRBcZ5qMkWUTaumA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ex6ppfvob2mqvipi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKP5S=1Ds0-cz7qHiRbLPQj2e0fwaPXFExhRBcZ5qMkWUTaumA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Cc: Nicolae Rosia <Nicolae_Rosia@mentor.com>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ex6ppfvob2mqvipi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 25, 2016 at 03:09:43PM +0200, Nicolae Rosia wrote:
> On Fri, Nov 25, 2016 at 3:03 PM, Mark Brown <broonie@kernel.org> wrote:

> >> -             .of_match_table = of_match_ptr(twl_of_match),
> >> +             .of_match_table = twl_of_match,

> > This buys us nothing, it's not going to make any practical difference
> > but on the other hand it costs nothing to have it there either.  The
> > only impact I can see this having is causing someone doing a cut'n'paste
> > to miss the of_match_ptr() out.

> I did this because I received a comment on another patch [0].

OK, but that still doesn't really explain what the benefit is!

--ex6ppfvob2mqvipi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYODoCAAoJECTWi3JdVIfQXqkH/iJ3ugd19D9emT0/hdtbN8n4
KGt/CpxkvCF/3mVhwjgLvsDxBquODN4v82bc48Xw2Xj7G4h6haE8HYqZwukp5869
npQ9y0eD15OQQlGhZoAx8MctphEQeE+xgeTrWXseOQ2vK5KeL9tOaNPC8HB1ZBSD
7A2AyA7x37E9VvimO7Gw2+u4vizu/nJgtrmj/kwVb9WpKnSaJf9gWoRJfNpuKC4/
KC0g7cZSSGYHUuKtlaaqj9unTa18io+555YfaAGakZEpRbaQ74oFxH9M6DyTuaDU
OAcHB9zaSxAx+rxt/cZqUJI1s6Py86tWhNdyKlCWzGNjNCyUefcwkSe2olbB5rY=
=15b+
-----END PGP SIGNATURE-----

--ex6ppfvob2mqvipi--
