From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/3 v5] arm: omap: am335x: enable phy controls
Date: Mon, 13 Feb 2012 12:11:18 +0200
Message-ID: <20120213101117.GI6614@legolas.emea.dhcp.ti.com>
References: <1328675212-29693-1-git-send-email-ajay.gupta@ti.com>
 <1328675212-29693-2-git-send-email-ajay.gupta@ti.com>
 <20120210183143.GS1426@atomide.com>
 <47CEF8C4B26E8C44B22B028A650E0EA9317F6CF4@DBDE01.ent.ti.com>
 <20120213064930.GC6614@legolas.emea.dhcp.ti.com>
 <47CEF8C4B26E8C44B22B028A650E0EA9317F7709@DBDE01.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4IYkFBVPN84tP7K"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53865 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751696Ab2BMKLX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Feb 2012 05:11:23 -0500
Content-Disposition: inline
In-Reply-To: <47CEF8C4B26E8C44B22B028A650E0EA9317F7709@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--T4IYkFBVPN84tP7K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2012 at 09:40:26AM +0000, Gupta, Ajay Kumar wrote:
> Hi,
> > On Mon, Feb 13, 2012 at 04:26:19AM +0000, Gupta, Ajay Kumar wrote:
> > > Hi,
> > > > * Ajay Kumar Gupta <ajay.gupta@ti.com> [120207 19:55]:
> > > > > Switch on the phy for am335x.
> > > > >
> > > > > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > > > > ---
> > > > >  arch/arm/mach-omap2/omap_phy_internal.c |   21 ++++++++++++++----
> > ---
> > > > >  1 files changed, 14 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm/mach-omap2/omap_phy_internal.c
> > > > > b/arch/arm/mach-
> > > > omap2/omap_phy_internal.c
> > > > > index 4c90477..7129408 100644
> > > > > --- a/arch/arm/mach-omap2/omap_phy_internal.c
> > > > > +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> > > > > @@ -266,7 +266,11 @@ void ti81xx_musb_phy_power(u8 on)
> > > > >  	void __iomem *scm_base =3D NULL;
> > > > >  	u32 usbphycfg;
> > > > >
> > > > > -	scm_base =3D ioremap(TI81XX_SCM_BASE, SZ_2K);
> > > > > +	if (cpu_is_ti81xx())
> > > > > +		scm_base =3D ioremap(TI81XX_SCM_BASE, SZ_2K);
> > > > > +	else if (cpu_is_am33xx())
> > > > > +		scm_base =3D ioremap(AM33XX_SCM_BASE, SZ_2K);
> > > > > +
> > > > >  	if (!scm_base) {
> > > > >  		pr_err("system control module ioremap failed\n");
> > > > >  		return;
> > > > > @@ -278,16 +282,19 @@ void ti81xx_musb_phy_power(u8 on)
> > > > >  		if (cpu_is_ti816x()) {
> > > > >  			usbphycfg |=3D TI816X_USBPHY0_NORMAL_MODE;
> > > > >  			usbphycfg &=3D ~TI816X_USBPHY_REFCLK_OSC;
> > > > > -		} else if (cpu_is_ti814x()) {
> > > > > -			usbphycfg &=3D ~(USBPHY_CM_PWRDN |
> > USBPHY_OTG_PWRDN
> > > > > -				| USBPHY_DPINPUT | USBPHY_DMINPUT);
> > > > > -			usbphycfg |=3D (USBPHY_OTGVDET_EN |
> > USBPHY_OTGSESSEND_EN
> > > > > -				| USBPHY_DPOPBUFCTL | USBPHY_DMOPBUFCTL);
> > > > > +		} else if (cpu_is_ti814x() || cpu_is_am33xx()) {
> > > > > +			usbphycfg &=3D ~(USBPHY_CM_PWRDN |
> > USBPHY_OTG_PWRDN);
> > > > > +			usbphycfg |=3D USBPHY_OTGVDET_EN |
> > USBPHY_OTGSESSEND_EN;
> > > > > +			if (cpu_is_ti814x()) {
> > > > > +				usbphycfg &=3D ~(USBPHY_DPINPUT |
> > > > USBPHY_DMINPUT);
> > > > > +				usbphycfg |=3D USBPHY_DPOPBUFCTL
> > > > > +					| USBPHY_DMOPBUFCTL;
> > > > > +			}
> > > > >  		}
> > > > >  	} else {
> > > > >  		if (cpu_is_ti816x())
> > > > >  			usbphycfg &=3D ~TI816X_USBPHY0_NORMAL_MODE;
> > > > > -		else if (cpu_is_ti814x())
> > > > > +		else if (cpu_is_ti814x() || cpu_is_am33xx())
> > > > >  			usbphycfg |=3D USBPHY_CM_PWRDN |
> > USBPHY_OTG_PWRDN;
> > > > >
> > > >
> > > > Please remove all the cpu_is_xxxx calls from the *_phy_power
> > functions.
> > > > You should need those only in *_phy_init to set the right flags
> > > > once, not every time you enable or disable the phy.
> > >
> > > Tony,
> > >
> > > This is a common function used by ti814x, ti816x and am335x and they
> > > have mostly the same bit map but a few bits are different so we would
> > > need to have cpu_is_xxxx.
> > >
> > > We use this *_phy_power(1) for phy on/init and *_phy_power(0) for phy
> > > off and don't have separate *_phy_init(). Even in that case we would
> > > require
> > > cpu_is_xxxx() as phy power down bit is different for ti816x and same
> > > for ti814x and am335x.
> > >
> > > Please let me know how should we handle this.
> >=20
> > use cpu_is_xxxx() to set a flag, and check on the flag.
>=20
> Are you saying save the flags once in a local static flag and use
> the same later on?

that's correct.

--=20
balbi

--T4IYkFBVPN84tP7K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOOHFAAoJEIaOsuA1yqREe4QP/26cmGrQsMksf1ZFfQQyB1c6
na0JXalnz5EfbDZcLKCc27pYR4nJDXMA6wJOitP5agvSWKHG+LhZaePxAtt7sv6Y
OEeafUruOoKf7r929+Za2CQTQ/veyFuAbxJseZW18GT8X9wwlFxoxPlklf3adB97
xRkcGCohLJxcyZkmY8+cQl1GKleELBC7HeH2g+49bQkQUwYDbxB8GsdRDp5SInhB
gwzlvTQpW5gzTqk856rNLZpgTKlVx8Y+0tjMDmlNdJelRgfRRgABc26W/iy+/QIY
n/03uAukPeEsg9J6+VaRWsc+CGFpEsSV+Pe7asSASVB+XG1G2pVIDhDehWQ0jkCB
SUfn/0m1l1Jm6jkXDJ5mHzihcUBSWku7VBja9FmvGJdtrOykdmrSaJ9Z19ucGikN
YRS1OOfxzrMtx+3Gxxj3wMHJuCLHIAHIgCrEi8yqKeVIGeNR9RNtx9FvyTCOX/uY
Es2xabgPIiEDXzFNSDRIDVkHlMIC5CW+sANegzVAGTW9AXe3wbxz9BQuttvmOY2B
rLvzbff4vLQjAIVRJox76EDVPDbhid4u7A4eRvlLKw+NScUzyu4PQrFvDPzDZ8+7
v+fKt+9hm8vGAXWkLQLObSZpks4WsZe75qu61T40tI8QPC7GScRIL7g0jDxH/XkG
s3o/HApBb1jwMNmsD8nl
=+TkV
-----END PGP SIGNATURE-----

--T4IYkFBVPN84tP7K--
