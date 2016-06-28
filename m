From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC 00/19] Runtime PM fixes for omap-ssi
Date: Tue, 28 Jun 2016 02:33:04 +0200
Message-ID: <20160628003303.GA24501@earth>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 18, 2016 at 06:26:50PM +0200, Sebastian Reichel wrote:
> This series fixes runtime PM for omap-ssi, so that
> the OMAP SoC can idle correctly. After applying the
> series, the SSI module correctly goes into idle if
> phonet0 interface is not configured or if it's
> used by ofono (*). Apart from me Pavel Machek did
> some testing of my devel branch [0] and reported,
> that he was able to get the phone into full idle.
>=20
> Note: I did my testing with kernel flashing over USB, so
> idle is broken. But I found the bit in cm_idlest1_core,
> that stands for SSI blocking status: 0x00800000 (documented
> as "reserved" in the public TRM).
>=20
> (*) "ifconfig phonet0 up" will result in blocking ssi module
>     until modem setup has finished (data communication via
> 	phonet0 device), since it enables ssi wakelines.
>=20
> [0] https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/log/?h=
=3Druntime-pm-fixes

I just added this patchset to hsi's for-next branch.

-- Sebastian

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXccW9AAoJENju1/PIO/qaC58QAJ4rZFSgU5rS+/fR3YP+3mB2
tous/2GlDRClFJweyfZ0ctNk28y2vh+qMaKprWAK/omYs5Ha5hmvyp8dQOP/Ps4v
n9kF7kMDUNYKQ9PvqmahZTAgmyLxfIGbfs2OuwjK7ejB/1RdN6zTBb8JDoO81Se1
Fy37qDNZjz9q0dVg9aRQNad4bbraK/Sl6kx3TlGaSFZHKUGlDO5PUhRtWxE9AMr4
I5EWZ1BFCmMWizMmJc+rOVj8mdTabRU2a0cJWK5m/Z9PaOKaAU8EyqZua22TDs1b
fcf4KQhW2MpCV1s4/Vkp15PyOGV7fwmKhlr8lirNcDm5nNPy4o+56rV1Y299cVJP
8J+4Ael+EEjCuPr6mCe1szWz4z2zfzzstjQpJoSeSklsZwYOSLwQ35WJeAlEJ+vi
jQrwG83X10o5X0tcq4pFlOxIBl2zxXAvP7pB+gx21uw7voS6vJupq00OWP07xTCp
RpeoB84CsS1QppvqeD93WJ9ioPfB6XUbkzy60BGbCcniEaBgXZ027JDN+AYC9siK
GOOVxHkM0EXlwRB70NOpGKoqWLvNd+cfBk4UG46DLvMjFPdUwmNe6UEg84wVnGjI
PuSpsztmvZoGgGmDiMtlBXooH9ZS3xQtsX84F5Tz05CPTxr5uDpWIr4mi1JkQDFg
Tzkm9DDRWfsf5aAgwOht
=pHT1
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
