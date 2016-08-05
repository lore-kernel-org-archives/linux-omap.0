From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/2] Drop last two remaining omap3 legacy board files
Date: Fri, 5 Aug 2016 19:45:57 +0200
Message-ID: <20160805174557.GA27448@earth>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0946296753900497597=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465987689-14812-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Russell King <rmk+kernel@armlinux.org.uk>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============0946296753900497597==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Wed, Jun 15, 2016 at 03:48:07AM -0700, Tony Lindgren wrote:
> Here are two patches to drop the last remaining omap3 legacy boot
> files. We have device tree based booting working for these boards,
> and the legacy booting has been mostly kept around to validate
> against regressions.
>=20
> Let's not touch the rest of the platform init code until around
> v4.9 so we can revert these two patches if needed.
>
> Cheers,
>=20
> Tony
>=20
> Tony Lindgren (2):
>   ARM: OMAP2+: Drop legacy board file for n900
>   ARM: OMAP2+: Drop legacy board file for LDP

I wonder what happened to these patches. I see, that you have a
omap-for-v4.8/legacy branch, which contains them. But as far as I
can see its not in linux-next and it was not included in the ARM
pull request.

-- Sebastian

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXpNDSAAoJENju1/PIO/qap8YP/AsfqvlFHd9aknM4CTBU1Aae
fqu7VVPThpMzZWLm8glpNqNzNhcUCBEdMjtgUoFDu6VV2FjU/3akSxpKesB/IFor
jygJwvLMzi0crJ27PwVxfOu1h0IPMmvot3YFYSYeV2NNoS+KmLITh6Z3zE8MyXFs
DBSskG0xIsJ1OYTnegwQiiK96YQtsQWKnyhBCxgSfXTf2QdDRoHF/hvJtSAwigfg
Y1kO+JV0a0oJ4BxcN0OAKxTerp4ONta820i87kHZvihLvbq00SEQbktTa4jz8eAf
aHINi8wusDrfhPNhVDTyXAU4jIkDVvBBA1j074RWiKF2pnaxaRSaZ5vbwYd8Vz8l
2TM3VVwIoKLwziG6fHW9fhQlRAumpuuyqdrjsoMJZViKO+AJHyfLhHtZhuJ+Pqv/
IHQScycN+eCOMupem7mgovcmaXZWoiK4TOR3eTf5fopS1DGRWbgyAkhR9CRKtLNC
KdJvYp/vuNAsn+59Lgtndmm+NuyhAeNHB6wjwUHnmaZ/A52IR4ERq69MapD0L3B6
erCl67JCzgyThLx3MWCdZeQWt/PyXI0rR+oiqFZAxLAPTj2QpmsnIHqRkhSjl6CY
5UUYvb4qMf3yAN4zsyKkX4X0WDWVcCz/llV51YxFyCUzP0ouzdBLWJiDpMdY7MOx
N9jjz8mrd37BlFWf9jiP
=E1ZV
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--


--===============0946296753900497597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0946296753900497597==--
