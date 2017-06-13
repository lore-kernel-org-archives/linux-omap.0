From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] regulator: tps65910: Allow supply references to
 the same chip
Date: Tue, 13 Jun 2017 21:42:39 +0100
Message-ID: <20170613204239.ans4j535st7kjee6@sirena.org.uk>
References: <f2aee03834d8cdcc7195b9272982617d93f978dc.1497364762.git.mirq-linux@rere.qmqm.pl>
 <053529c206a2afc453b52e2c0f024acd85341a83.1497364762.git.mirq-linux@rere.qmqm.pl>
 <20170613174628.sv4v76s7torrn5jx@sirena.org.uk>
 <20170613202217.nj23xkahpz3jc4h5@qmqm.qmqm.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p5j3qn75wj7kj2dj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170613202217.nj23xkahpz3jc4h5@qmqm.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, j-keerthy@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--p5j3qn75wj7kj2dj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 10:22:17PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> On Tue, Jun 13, 2017 at 06:46:28PM +0100, Mark Brown wrote:

> > at all.  Is this happening for you with current kernels, we have a few
> > mechanisms for deferring bindings of supplies which should help here.

> What mechanisms would that be? What I observed is that whenever
> a regulator's supply is not available but described in device-tree,
> the whole device's registration is deferred.

Mainly "Don't use regulators as supplies until the parent is bound",
there were some older ones IIRC.

--p5j3qn75wj7kj2dj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllATj8ACgkQJNaLcl1U
h9CnWgf+Ii6mBvf0hARwh9WR9SbfjjMHySd26hcr0fd1gRTQUOAw3zT315ZD9llf
IAk29CoU9v4zKb7YNL0oHCrMZSlcyIkb/aQolRICF9gd7CNYPgvIu9hgIxnf4uEz
ihQIytNlLiY6N8hCnmNkRUhZjre1A5BlLDFKy7OfdVssnJkMtoMf7IzHwTh2de+I
XY5vM3B8VdtKz34gVa0n0tm6NPSIpDUaSO+Nv9OtxG4sK5xRgtlslL1/K4U5PII7
X5f6UAwHlX1uEpkAUji0XEXbL/fRu4m6DgxMhLV0fgzW5SLW1TYACMTzwWR1y9Jn
3juRmgY29CMSrR/YrRe2j3zC0llz5Q==
=JrJv
-----END PGP SIGNATURE-----

--p5j3qn75wj7kj2dj--
