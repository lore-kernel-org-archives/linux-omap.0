From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/5] Nokia N950 modem support
Date: Thu, 28 Jan 2016 18:04:31 +0100
Message-ID: <20160128170431.GD17038@earth>
References: <1453045749-22642-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453045749-22642-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Jan 17, 2016 at 04:49:04PM +0100, Sebastian Reichel wrote:
> This patchset adds support for the N950 modem.
>
> [...]

All of the patches are more or less mergable independent
of each other, so I suggest the following merging scheme:

> Sebastian Reichel (5):
>   ARM: OMAP2+: hwmod data: Add SSI data for omap36xx

This one should go in via Paul Walmsley.

>   HSI: nokia-modem: add n950 and n9 support
>   HSI: ssi-protocol: Use handshake logic from n950

I already took those via the HSI tree.

>   ARM: dts: OMAP3-N950-N9: Enable SSI module
>   ARM: dts: OMAP3-N950-N9: Enable modem

The DTS changes can go in via Tony's tree.

-- Sebastian

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWqkocAAoJENju1/PIO/qaQpwP/0JozBxrrskmxO1Mk0M6Lz6O
QUXAog0LL/r+SVXWvRtc+A1CcEGtU//2mjcoeML4i1bIfyEp9s9VsYKl+ov9Rbk+
MxmROD9gAdIXthA7kk7wQtTnAdsqFoaR/+uhcdlRJUIHvOPS8ypelt6iJcIvOBoj
x85Nt0TbK2L6gYBeKaXIlSDqGq3mHNiw6AyaksVt6zXLTI5zgCscH6go9nDvk9by
n/8lAPW4v+ggyd1MulNq+spJ1s7Uyt+qAsFsye9t6Y98/+Aj10ZuHOq8Su/5+19H
MWLN4K+ub6mb/X8xtdAV4wl+BgV2Cd3zijqwUV0FFvIAI9d41Ha7awK7GAqxZFPm
jlcipe4mn1VnaF6l4+ERfaEcHv/Ye/B8m1uUA9/fcdpS4i2hDMseVQ5d4QC2MQs/
Nlutueqg2z3LPVtH3iMdTkrTcbJ/+lmekoaHdF7vOjoVsp2VZDEVrkbEJukHFlcV
+490V1BFcshnP2ubmcub5D6Y00xdzp+caF1Bz/qaksdDrLtaA4RbtnJnD812LbrA
x5BoNn/mhv/3Mzl2VpPBSiHqGVdBFiZL1RyX8a1CIhK2NhhEY6T/69BOhNOmmsyZ
R+NZp2wH37ROLh4IRw4T/wMSAUOY9nC6BNz2xxtIiCfoR9s8X/oSQf+6IXGrQxMy
OKNPsfx8q6EhdN/wV2gT
=hsBs
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
