From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] regulator: twl: voltage lists for vdd1/2 on twl4030
Date: Mon, 9 Sep 2019 15:04:18 +0100
Message-ID: <20190909140418.GH2036@sirena.org.uk>
References: <20190814214319.24087-1-andreas@kemnade.info>
 <CAHCN7xL4K+1nJDXDRs7yVi6LhGL-4uPu9M+SN1dcOPu8=M8s2g@mail.gmail.com>
 <CAHCN7xJ0RmRQwo3bSF6FoLjOtrg5YZAMD9+=332LMzLLR1qdDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3VRmKSg17yJg2MZg"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xJ0RmRQwo3bSF6FoLjOtrg5YZAMD9+=332LMzLLR1qdDA@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, vireshk@kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--3VRmKSg17yJg2MZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 09, 2019 at 08:32:06AM -0500, Adam Ford wrote:

> I am not sure who the right maintainer is, but as of today, cpufreq
> for users of twl4030 on 5.3-RC8 is still broken without this patch.
> Is there any way it can be applied before the final release?

Ugh, this affects cpufreq :/  I hadn't realized, sorry.  At this
point it's probably a bit late to get it into the release, but it
is tagged for stable so if it doesn't make it in it will be in
one of the first stable releases.

--3VRmKSg17yJg2MZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl12W98ACgkQJNaLcl1U
h9B5Egf/RSjS9nKNpgdxDfA8C+vwvwNwsFjhjR9RlJ2MbT2bQhFOeDiV/x6bYOJS
97B50GiDQ/srWPPpvHfFQDhYVrlbBFPuBVYxD8HcpvXvEooKdyKvsrarPxgMSxn0
hqrWt0DaPWjlhQRqs9PIMZctl+92QT2+YtA40uF2xbESgYOr1GSP76vPJrph/gS2
woFz8MjXyZL8bHtRv7vGhJem61Fcm8CjRZFWLX3h5B4k7mAKH1W5gZWoB2PaZicD
7+X9001/NbA1xirpe2cdUkwnjPJ6xfHqYQcm2kT233A4X57q88Et4l0rYFG3nqJp
2BHnXooXkmnlQHLXs2kgZuTxldDSZA==
=UEcM
-----END PGP SIGNATURE-----

--3VRmKSg17yJg2MZg--
