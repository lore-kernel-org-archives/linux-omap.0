From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] regulator: ltc3589: make IRQ optional
Date: Mon, 25 Jan 2016 13:52:20 +0000
Message-ID: <20160125135220.GR6588@sirena.org.uk>
References: <20160121102015.GI6588@sirena.org.uk>
 <20160121112611.34e17cb2@ipc1.ka-ro>
 <20160121111115.GJ6588@sirena.org.uk>
 <20160121123311.5346e40d@ipc1.ka-ro>
 <20160121162646.GK6588@sirena.org.uk>
 <20160122064145.36b7f2b4@ipc1.ka-ro>
 <20160122162610.GZ6588@sirena.org.uk>
 <20160125133731.72669115@ipc1.ka-ro>
 <20160125124123.GQ6588@sirena.org.uk>
 <20160125135109.760ba5f0@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NC4+cM2ybgOHGbSg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160125135109.760ba5f0@ipc1.ka-ro>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--NC4+cM2ybgOHGbSg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2016 at 01:51:09PM +0100, Lothar Wa=DFmann wrote:
> On Mon, 25 Jan 2016 12:41:23 +0000 Mark Brown wrote:

> > The above, for example - make the interrupt optional.

> This will make it impossible to notify the system about
> overtemperature (and undervoltage).
> I implemented polling to be able to get at least overtemperature
> warnings.
> (Undervoltage cannot be handled sensibly without interrupt anyway)

I'm not convinced that justifies constantly polling, if the system
designers cared you'd hope they'd have wired it up to a working
interrupt.  People commonly don't, realistically thermal warnings are
usually set near the point where the silicon will be physically damaged
and typically by the time they fire the system is already experiencing
catastrophic problems at a system level.

The polling is at the very least a separate change, and making the
interrupt work would be a much better option.

--NC4+cM2ybgOHGbSg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWpiiTAAoJECTWi3JdVIfQLqUH/2UkzSxFLwMoV1HhdhQHBygn
oXFFg8TZvVVLzMQw5heNPMuxfYU6mTNMLFiJ5oywaAwoOfz3/FzD2g6I+mwgmxDo
DFZkdBFCbtj8OLs/eV/AuiatQCcvuRtwL+NUNVH3KJ0aTBZ5S941dVTN6SEhjFPV
fiOd2j9Jikssr4E+RVY0eN5quG7YQiq9ppOsW+hPjhi2cp/Jxdh1SxUEoV5h3FNS
H61lO9cveHAQfRqSe2LJKsq5qaEW7U7hdsfkKfOaYvRx24crXgalhb7FWH8ui7xI
w0+ImKq6Lj53K97l++vLui3XlYJLtGGFjmRlH25Pge+s5vNhsxQIgmY7QFtwM+c=
=nDvb
-----END PGP SIGNATURE-----

--NC4+cM2ybgOHGbSg--
