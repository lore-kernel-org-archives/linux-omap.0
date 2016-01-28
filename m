From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/5] HSI: nokia-modem: add n950 and n9 support
Date: Thu, 28 Jan 2016 17:53:38 +0100
Message-ID: <20160128165337.GB17038@earth>
References: <1453045749-22642-1-git-send-email-sre@kernel.org>
 <1453045749-22642-4-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453045749-22642-4-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 17, 2016 at 04:49:07PM +0100, Sebastian Reichel wrote:
> The Nokia N950 and Nokia N9 also have a SSI connected
> modem, which use the same protocols as the Nokia N900,
> but with slightly other GPIO setup and increased link
> speed (96000 kbps instead of 55000 kbps).
>=20
> Since it's unclear, if the N950 and the N9 use exactly
> the same modem, each of them gets their own compatible
> string.

I queued this patch with the modified commit message:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/commit/?h=3D=
for-next&id=3D633f67a51d078bea627f22d6208442e1e1f391cb

-- Sebastian

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWqkeKAAoJENju1/PIO/qaa8YP/iuS3HXxaBTc6Z/mFnaUzkJY
RjvkwyAwEAefQqipZ0KckvB+MUr2Ft99kaigq0GQR5rEw+qNTY4w4jLpCZZXif0Q
XPw+tDDhMFMs2/aYd8HnCywhIl4LdRDi9qcKbJh9mE43T6YCW7G4WsYNmpsbJMTF
cv6aKsqwc1jLKGzDnZ/fykJ+vHDMhwuecNIoMDHpZp45qtkWDbBvBqKq8NtIycoB
LVU/sQLfh4zfEssjks6cWu62cPyBb0SQSO9FyLh3pe3+IlTR1mUvfYAf0FljNSv+
VWDDEc2yV8N/lRl4k2ZREK1YoDDQTv2FRVyJ10rFism1J6Z5bTG8OEXxruDxk+tg
bO2GGHldIDv5Y/7Oi3dWp79xs4FLShLVNIH0lvINqBwK3mS8VOBwhwqVH6EDTkMx
6ZNP74CS3yO70iToXWb53uMd8YmgmnmKsyPThHn9lrNUkUiMRcsOaZEWKJ6jdfPZ
1KiJ4kvb9LXE+6qQy9UJRE1uxY5NoGs27gYpwebuhYc6QFrGm4l5r3rXPnd40pMg
yFWNdBLnIufA/MTjol12FnsREo+6cS3tTs33egZbdJ1A6wPB3owhNRVCrsj2Qhgs
1Tpan9cBRvzx+0YN/BbBk9QvZPAy+RcxgeGsF0s+z3zENOOUzzIhrGYb46ZfUZe6
InO+r0JkzlRqWsmBPiDI
=gzbs
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
