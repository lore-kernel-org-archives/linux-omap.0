From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv2 0/5] OMAP4: crypto support
Date: Tue, 13 Jun 2017 16:24:58 +0200
Message-ID: <20170613142458.32g3iqcijc4ij4b7@earth>
References: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
 <ab778bfd-9397-4cb0-0741-557da57bba83@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ujikfrwqnux7stmg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ab778bfd-9397-4cb0-0741-557da57bba83@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ujikfrwqnux7stmg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 13, 2017 at 04:49:18PM +0300, Tero Kristo wrote:
> On 13/06/17 12:28, Sebastian Reichel wrote:
> > This adds crypto support for OMAP4, which was missing for some reason.
> > This fixes error about missing hwmod on Droid 4. IP-Cores for AES and
> > DES are working according to selftest.
> >=20
> > Changes since PATCHv1:
> >   * remove patch adding des_fck to DT
> >   * add patch removing aes[12]_fck from DT
> >   * add patch renaming hwmod aes to aes1 in DT
> >   * update hwmod patches according to feedback from Tero
> >   * add patch for aes2 hwmod
> >=20
> > -- Sebastian
>=20
> I just posted a few extra patches on top of this series, for adding
> the missing dts data for aes2 and adding sham accelerator also.

Thanks :)

> The dts data should be applied first if you want to avoid any
> issues with hwmod core complaining about missing DT data, so the
> sequencing of this series and mine need to be done carefully.

There is also a warning printed if DT references a missing hwmod
entry (that's how I noticed this in the first place). It's less
noisy, though. Since kernel builds and boots with any order and
crypto hardware does not work at the moment there is no real
problem with bisect. I suggest to merge the DTS patches normally
through the separate dt branch.

> The patches themselves in this series look fine now, so:
>=20
> Acked-by: Tero Kristo <t-kristo@ti.com>

-- Sebastian

--ujikfrwqnux7stmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk/9bcACgkQ2O7X88g7
+poZEA/9G1omN+WxT54rNwhdXgCPDW4nvoB7rLlEiL15UFFhs40hk+kXz+OmFx+V
AsBiaWmuy2ocEo2EHfZ3LhOufX5Du44yTzvj6hooAswLC3YGJvg6GLwKk6m6jTx0
f9iDY5UXLyBQqO4gKUJ2g7AOMcN/tUoOBTqXbsDL5dj5oCYNq18Nfs/IuQeC4eOz
KUNqIpo0dRBrlwTo1hc/pIHsAd8+bDx93OXEgersG7589m7vzS54Bfo+9B30Ildr
OOxdHeX0Q8c10jJnl7FDfdW8ZAV5eqAzae5BZKD5wxQG8aSkVk2jNjyFHZFv2ZZw
lbbMGAJIFSi6d7jyJGkiSjx/7CjWrDOlPESifMNC3b+TR7cjBdY6XOwYc9XGGfYU
bKSchGoGSuAWvUswFpnEqU74yYn6pbZ8uFbftUFB1ns02ZkcbDjvX1eU37XFVyd8
JojeDzephNMn4IZZ1lyOZCqQxklincjJ7xnLWKFsd9zWQ/tFL3ud0Lpha55vwUuv
nOYGPEnT+DMfq5IKFvASIyIiNR6EJSxBFu1qRNTLNRTqgTeHL4ObJGrxfhr1GbAI
B5o9aKuexFXw5zgd1NL5XXYMe5w+0n4EjJWKW0NJiGW2/ZMmwsTbDIHfZONjtRKa
ZCLze52LlKPCzU8sS+lphyvVtOrT7aT4DDYlDRzfdcbSdTm9eDo=
=ech2
-----END PGP SIGNATURE-----

--ujikfrwqnux7stmg--
