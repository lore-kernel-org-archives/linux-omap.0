From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/3 v5] arm: omap: am335x: enable phy controls
Date: Mon, 13 Feb 2012 08:49:31 +0200
Message-ID: <20120213064930.GC6614@legolas.emea.dhcp.ti.com>
References: <1328675212-29693-1-git-send-email-ajay.gupta@ti.com>
 <1328675212-29693-2-git-send-email-ajay.gupta@ti.com>
 <20120210183143.GS1426@atomide.com>
 <47CEF8C4B26E8C44B22B028A650E0EA9317F6CF4@DBDE01.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:46928 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751277Ab2BMGti (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Feb 2012 01:49:38 -0500
Content-Disposition: inline
In-Reply-To: <47CEF8C4B26E8C44B22B028A650E0EA9317F6CF4@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 13, 2012 at 04:26:19AM +0000, Gupta, Ajay Kumar wrote:
> Hi,
> > * Ajay Kumar Gupta <ajay.gupta@ti.com> [120207 19:55]:
> > > Switch on the phy for am335x.
> > >
> > > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/omap_phy_internal.c |   21 ++++++++++++++-------
> > >  1 files changed, 14 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-
> > omap2/omap_phy_internal.c
> > > index 4c90477..7129408 100644
> > > --- a/arch/arm/mach-omap2/omap_phy_internal.c
> > > +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> > > @@ -266,7 +266,11 @@ void ti81xx_musb_phy_power(u8 on)
> > >  	void __iomem *scm_base =3D NULL;
> > >  	u32 usbphycfg;
> > >
> > > -	scm_base =3D ioremap(TI81XX_SCM_BASE, SZ_2K);
> > > +	if (cpu_is_ti81xx())
> > > +		scm_base =3D ioremap(TI81XX_SCM_BASE, SZ_2K);
> > > +	else if (cpu_is_am33xx())
> > > +		scm_base =3D ioremap(AM33XX_SCM_BASE, SZ_2K);
> > > +
> > >  	if (!scm_base) {
> > >  		pr_err("system control module ioremap failed\n");
> > >  		return;
> > > @@ -278,16 +282,19 @@ void ti81xx_musb_phy_power(u8 on)
> > >  		if (cpu_is_ti816x()) {
> > >  			usbphycfg |=3D TI816X_USBPHY0_NORMAL_MODE;
> > >  			usbphycfg &=3D ~TI816X_USBPHY_REFCLK_OSC;
> > > -		} else if (cpu_is_ti814x()) {
> > > -			usbphycfg &=3D ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN
> > > -				| USBPHY_DPINPUT | USBPHY_DMINPUT);
> > > -			usbphycfg |=3D (USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN
> > > -				| USBPHY_DPOPBUFCTL | USBPHY_DMOPBUFCTL);
> > > +		} else if (cpu_is_ti814x() || cpu_is_am33xx()) {
> > > +			usbphycfg &=3D ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN);
> > > +			usbphycfg |=3D USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN;
> > > +			if (cpu_is_ti814x()) {
> > > +				usbphycfg &=3D ~(USBPHY_DPINPUT |
> > USBPHY_DMINPUT);
> > > +				usbphycfg |=3D USBPHY_DPOPBUFCTL
> > > +					| USBPHY_DMOPBUFCTL;
> > > +			}
> > >  		}
> > >  	} else {
> > >  		if (cpu_is_ti816x())
> > >  			usbphycfg &=3D ~TI816X_USBPHY0_NORMAL_MODE;
> > > -		else if (cpu_is_ti814x())
> > > +		else if (cpu_is_ti814x() || cpu_is_am33xx())
> > >  			usbphycfg |=3D USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
> > >
> >=20
> > Please remove all the cpu_is_xxxx calls from the *_phy_power functions.
> > You should need those only in *_phy_init to set the right flags once,
> > not every time you enable or disable the phy.
>=20
> Tony,
>=20
> This is a common function used by ti814x, ti816x and am335x and they have
> mostly the same bit map but a few bits are different so we would need to
> have cpu_is_xxxx.
>=20
> We use this *_phy_power(1) for phy on/init and *_phy_power(0) for phy off
> and don't have separate *_phy_init(). Even in that case we would require
> cpu_is_xxxx() as phy power down bit is different for ti816x and same for
> ti814x and am335x.
>=20
> Please let me know how should we handle this.

use cpu_is_xxxx() to set a flag, and check on the flag.

--=20
balbi

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOLJ6AAoJEIaOsuA1yqRE45QP/0fPR1kqi5413T6KZPPOWDku
7N7y3QR3s7pabc23slTjE3niLsA1YHsmeFtGuxEjAbADRboOr0eaGcZuCpQpORAF
aLohOI7r8LYpByqr8w8AjRc61bfs/LIxtQP50T71sljk40zsCEnw872HRw4opGTD
jy3Q8tf6Rxzsoswa8Y/F3vnejE9fS2CWUirvF1UJ6jy2Af/GP02cF3wgyTvnwoq8
GshY+w9SYfKnvYclfNQD0lDEQnZzpxD/+ZLjIO+4O8cXhHvflnWXSgXCP+KsaDEU
vC0HSG2bgDwP1fRMcFobo2GIaWvl/te9uMNS0aMJjGaSz6PAgA0IdLaY2578IhFG
dChRGWoyp0ibKBqTN0P6aqHv3FjqdD9Ku4smS/gJAXPSiBGNcROkKZUeR6bZpeGy
6tISfRFNZAjJ6BanFJNYZmYyuLKtG8z1e6KI47JLuXjMXFXFWVD1pK8/rxyMWMZD
ou6y7+4xGC+C5Of+Bw+5eJowV6K2oxRd3gGOXmrP4uI3z+2TdEFWDHHTbk73k9ye
5xkrEKI7JVHp2x39XCcn9c2DKqZbw460ITTwuEWTTfuGhb77z1clYhNx2x30lX0b
CITw0RYTS4+syQyHiZGu7DCUm+bQC/VxYVQOGz4FYCCUw/8tRwI+ofdxUKxge1Ol
u2AgMl9AngLIfsPDGdNq
=20lw
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
