From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC 00/15] Device Tree schemas and validation
Date: Thu, 3 Oct 2013 09:38:59 +1000
Message-ID: <20131002233859.GB29875@voom.fritz.box>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
 <524A8289.3050107@baylibre.com>
 <524ACB76.1010001@gmail.com>
 <524AE4FB.4080906@baylibre.com>
 <CAL_JsqJ31TGFJCSeSOqgee=OLVfSUTAYdF4nSn7X2DiCequVAw@mail.gmail.com>
 <20131002135450.GH6506@voom.fritz.box>
 <20131002180841.GG27287@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:51922 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753089Ab3JBXiH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Oct 2013 19:38:07 -0400
Content-Disposition: inline
In-Reply-To: <20131002180841.GG27287@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robherring2@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Tomasz Figa <tomasz.figa@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, fparent@baylibre.com, Benoit Cousson <bcousson@baylibre.com>, Olof Johansson <olof@lixom.net>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2013 at 07:08:41PM +0100, Mark Brown wrote:
> On Wed, Oct 02, 2013 at 11:54:50PM +1000, David Gibson wrote:
> > On Tue, Oct 01, 2013 at 03:54:20PM -0500, Rob Herring wrote:
>=20
> > > I would expect the schema to replace
> > > Documentation/devicetree/bindings/* over time. I think the thing that
> > > needs to be worked out here is how to add free form multi-line text.
>=20
> > I'm not convinced that's a realistic goal.  As I see it, the
> > fundamental difference between a binding document and a formal schema
> > is that a binding defines both the syntax required of a node, and its
> > semantics, whereas a schema defines only syntax - the semantics still
> > need to be defined somewhere.
>=20
> So long as the schema lets you include free form text to define the
> semantics I'm not sure there's an incompatibility there - the same
> document can cover both.

True, there's no reason the machine-readable schema and human-readable
documentation can't be contained in the same file.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSTK6TAAoJEGw4ysog2bOSnEoP/26N9hpmK9OXk1FyPYmarpqn
LvBXmno3c3Xlpzhr8KQMtKd5BQGnk8vj8HeAHM2qZ1Ndjz9EeVcl0ZZyKg4SkgZW
YAg7mTs4xMQI//f/a8iWr/xPlpJ8a6i0+RIgWXIa3iQCVJFIK5Xh8g05YE0u6B0U
qwSsjyFhTll93dMLoH4/d/KERT2kP2UfQQVfyDnK/VyR/i7YwUtfmo4nlRlptApx
q4bjMLjGyXS81aOKPu6ogmNo5Kxdqszv9gnDT34mKVNI6k4EtIz/QLivNqIWjWmN
9ixQiekyWEAkRV0MRy7xeemsu87uBQA9ngMvAVOmYr6Zyw4ELT8YgbqEutpGdw5O
T9+c2uN6eyOU4G1qsq6DJfgQcxELIitD7sitoSUGLOksDYid2pUdJTU13j+qFavj
JPvevm1u1YloVEqFqDmXPtQ+CnwnACl3ZO/tbrxo0VE8AKhxONNFYupqcUjnnkr+
OV73GsW2H4/V2PdT0M9WBub8+RemPTAI+Y5dkEhgTBATT4G4t3JzHt4+eWQw/cwD
pH3/HmxRjSAnywEZNxdIEBtVoJdb/u8iIeTlMeOjvpuWTpEzKeVEiPzQo61SjepP
nIx7DI+ZZv8IHDL7O3fBXmlXwYAf7SKnsvViTB6pzcQlV47HYgCrM9P2cPcjxl3D
VFt6hNEYaR4emrdx+NGd
=27PK
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
