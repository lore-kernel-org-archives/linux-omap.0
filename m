From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 02/12] ASoC: davinci-evm: Add device tree binding
Date: Tue, 22 Oct 2013 13:39:24 +0100
Message-ID: <20131022123923.GF9388@sirena.org.uk>
References: <cover.1382110089.git.jsarha@ti.com>
 <66c21e66320e30453e6deded0f37ef582b4fba7c.1382110089.git.jsarha@ti.com>
 <20131022110147.GA9388@sirena.org.uk>
 <52666EE3.8070607@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:35321 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab3JVMjf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Oct 2013 08:39:35 -0400
Content-Disposition: inline
In-Reply-To: <52666EE3.8070607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, mark.rutland@arm.com, linux-omap@vger.kernel.org, joelf@ti.com, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, Darren Etheridge <detheridge@ti.com>


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2013 at 03:26:11PM +0300, Jyri Sarha wrote:
> On 10/22/2013 02:01 PM, Mark Brown wrote:

> >>+	/*
> >>+	 * If dtb is there, the devices will be created dynamically.
> >>+	 * Only register platfrom driver structure.
> >>+	 */
> >>+	if (of_have_populated_dt())
> >>+		return platform_driver_register(&davinci_evm_driver);

> >Why not register the driver unconditionally?

> I am just trying touch the legacy davinci audio support as little as
> possible. Would registering the driver in non DT mode do some good?

It would look a good deal less odd which is useful in itself; the best
thing would be if they could both use the same driver which uses both
platform and DT data.

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZnH4AAoJELSic+t+oim9+eQP/2wx/r8r+tQIUCrIl9CmaFUT
KK6eiqUHaOJWFvbL3rWepRNMHFvgrWJ8na8PbLE58/aBwWtFmtiaewNR2vV9w0XK
YMyGrkv+pXJ7aWNb4wsNrN4B8MwSz8SoJAP2YK7jP9lAb8SSW9RWY/QiHq7JIRz7
81/13bzRmC5h3N/PQlqHy5NzC/54VHgNEc5HR6EFibqRZYhqgRRsUnkDcq0cHqdj
priH9GGo+bRhOS57KTY+AeFTkHnj7Qej3l108A/0qqQ72k0Zl3I9LcsCcPjiB5eX
TLTnWpAe1FYYi9D1pgj0E1GvyPdUx10SYKg/WccRsuuIKXfDHQR539250y4J/z+i
wexl84w3ZS8egIx/fZXTrBWXh9KeCutapYhf7sdBiTnKFVmoXk7PMuYG9+Tm7cbJ
y2GoQ4WIhHaJwgn8tJ1HLYI6sfa5DYRFSJOTdfsqPnqvXjZwuhJZFvX93U2f37bP
pcJzZUzc2dTv5bGme2Ynv29N9NuE6FEHQH6mcc78If7PRUTyMTjaslvEPk/6IZRl
6cZETB3NHOpl979o/aLDveRBK6Y4oybDIk6AhV24wVXIiwV/9pDAFuLXGYqd8lPZ
D+9R6lDCYeiUWkEqjB4tYNFsgr3XLddWETPpS9PN1pQZi3TCLDTNeFGCyayigXQ1
UQSTBhKGIc3LgTVYC9f+
=mnsN
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
