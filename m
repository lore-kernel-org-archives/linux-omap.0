From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] regulator: tps65910: Allow supply references to
 the same chip
Date: Tue, 13 Jun 2017 18:46:28 +0100
Message-ID: <20170613174628.sv4v76s7torrn5jx@sirena.org.uk>
References: <f2aee03834d8cdcc7195b9272982617d93f978dc.1497364762.git.mirq-linux@rere.qmqm.pl>
 <053529c206a2afc453b52e2c0f024acd85341a83.1497364762.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fbiwv7eh7gezzp6y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <053529c206a2afc453b52e2c0f024acd85341a83.1497364762.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, j-keerthy@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--fbiwv7eh7gezzp6y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 04:41:58PM +0200, Micha=C5=82 Miros=C5=82aw wrote:

> This allows for (acyclic) references from tps6591x supplies to
> its outputs.

This is clearly not something that should be open coded in individual
drivers, aside from the code duplication it is obviously possible to
have two different chips supplying each other which this wouldn't help
at all.  Is this happening for you with current kernels, we have a few
mechanisms for deferring bindings of supplies which should help here.

--fbiwv7eh7gezzp6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllAJPQACgkQJNaLcl1U
h9Byngf+PsbSDFQsYSR6kPlYcvT8XfMHkJICyz/gRIAIvUo5HRbTVuRNIXrzGmJ/
8PkidBuH7BjiMIcSGA2cKVZ6ijfPgfkX3vn53jzs3jQJZbNXBKhbzKLkF+3CAjzM
+aH1vlFHqbGb6BAmooSuhuDcZRQA3U/DoZZQIr7UbjRw34EIj+W3HaUv3eDMmfGz
+ohGlHFhs1YBr8NZmagg76QWoq2fQBjcAE21Bkst5beAtBz2IedUIgBRKbtSRBUY
XTGmoX6QklPHzXJo9ha0kEkIqoEhvqXWlb81cTUmsExuQryeFzdqcx0UjgGENgVc
uEIuta7omWHBWrthrKrA+nosWc5VYg==
=iRR+
-----END PGP SIGNATURE-----

--fbiwv7eh7gezzp6y--
