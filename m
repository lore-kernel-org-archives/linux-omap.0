From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/7] phy: omap-usb2: Use generic clock names "wkupclk"
 and "refclk"
Date: Tue, 29 Apr 2014 11:14:20 -0500
Message-ID: <20140429161420.GH633@saruman.home>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com>
 <1398693687-13967-4-git-send-email-rogerq@ti.com>
 <20140428160347.GG30292@saruman.home>
 <535F59CF.6050002@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgApRN/oydYDdnYz"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <535F59CF.6050002-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--OgApRN/oydYDdnYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2014 at 10:50:39AM +0300, Roger Quadros wrote:
> +Nishant
>=20
> Hi,
>=20
> On 04/28/2014 07:03 PM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Mon, Apr 28, 2014 at 05:01:23PM +0300, Roger Quadros wrote:
> >> As clocks might be named differently on multiple platforms, use a gene=
ric
> >> name in the driver and allow device tree node to specify the platform
> >> specific clock name.
> >>
> >> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> >> ---
> >>  drivers/phy/phy-omap-usb2.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
> >> index a2205a8..fb5e515 100644
> >> --- a/drivers/phy/phy-omap-usb2.c
> >> +++ b/drivers/phy/phy-omap-usb2.c
> >> @@ -275,16 +275,16 @@ static int omap_usb2_probe(struct platform_devic=
e *pdev)
> >>  	if (IS_ERR(phy_provider))
> >>  		return PTR_ERR(phy_provider);
> >> =20
> >> -	phy->wkupclk =3D devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
> >> +	phy->wkupclk =3D devm_clk_get(phy->dev, "wkupclk");
> >=20
> > doesn't this patch cause a regression ? I mean, you're changing the
> > clock name before fixing DTS. Also, that DTS has been in a major version
> > of the kernel, so we need to maintain compatibility with it. How about:
>=20
> I'm changing the DTS in Patch 4, but I prefer to do it in this patch
> to prevent synchronization issues in -next.
>=20
> About backward compatibility, I agree with you but at the same time I
> don't think anyone using TI SoCs burns the DTB to ROM and needs
> backward compatibility. We supply our BSPs/SDKs with the updated DTBs.
> Do you feel strict backward compatibility is worth the effort for TI
> specific blocks?

dunno, but it would, at least, avoid "synchronization issues with
linux-next" :-)

--=20
balbi

--OgApRN/oydYDdnYz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTX8/cAAoJEIaOsuA1yqREQxwQAJRtNsq/K98yDIaeQNP5UEGR
RPv3O973cL/I0qTyrz5e4Ep/Ff5Ucf/b+3sB9rAy9p58vlu59tT63HaSy7azTdtp
TYB5NIPJlmUCA+Njl3XZIboo6k2YxHjRm2R9Pn3mTc2eoVRVVY7H/I3iNiT/WHfr
8OdIbz3KlqdYfiB9klBSHEnN8WVsGLX3kjbYPUY8uzBY7i7eIcOFGmnYnA7M+xeG
H4vGoKI8FiO7r4duzlD/lkCu69BylStvaQDSPN+0gzaWGPXAhOuqAr79KLquaRIj
Ltpzc7LjyuPu9vihDZF/V3g0lJYm/C72aBLaOF6MpLM+VdnBSWT+CJWem7FpSA5P
HKMbJjd4rHhCYAO0JA6ezTkQLlFyUdRKvLe1kwMPoHEloYjzEO68dYhESUVJLnxh
Z0538PbM3sSJXTFMPZSL0OCZJn/s3RsXx/9AtAONZoUB0RnvoyRajUaP0XlymQcD
7j/MmgxotwWPHY7pD+cLn5Lf4c0ST4VWx603F0Lgq7hjB8fOy9Qds98GSkal5+FU
EdYDIQGjKINFrKNE0z/FptYHuxSgEPXvtgvDbSVI7Rxco2um5TbL+23XovPU4BC8
YKTzkTZd4DBRwZD3Lkg9Li3sHDsb7C/tL6r+gOpurgiZ0jkjX/SDMAa4ESL/3PuJ
16oRmBWOHBsC2MsOvr+Q
=hY4M
-----END PGP SIGNATURE-----

--OgApRN/oydYDdnYz--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
