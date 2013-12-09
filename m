From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP4+: hwmod data: Don't prevent RESET of USB
 Host module
Date: Sun, 8 Dec 2013 17:58:39 -0800
Message-ID: <20131209015838.GA11433@atomide.com>
References: <1386080748-17005-1-git-send-email-rogerq@ti.com>
 <1386080748-17005-2-git-send-email-rogerq@ti.com>
 <alpine.DEB.2.02.1312090125170.32309@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1312090125170.32309@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: bcousson@baylibre.com, Roger Quadros <rogerq@ti.com>, tomi.valkeinen@ti.com, balbi@ti.com, sr@denx.de, David.Laight@ACULAB.COM, michael@amarulasolutions.com, bigeasy@linutronix.de, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [131208 17:27]:
> Hi Beno=C3=AEt,
>=20
> On Tue, 3 Dec 2013, Roger Quadros wrote:
>=20
> > Without this, the USB devices are sometimes not detected on OMAP4 P=
anda
> > with u-boot v2013.10.
> >=20
> > Unlike what the comment states, errata i660 does not state that we
> > can't RESET the USB host module. Instead it states that RESET is th=
e
> > only way to recover from a deadlock situation.
> >=20
> > RESET ensures that the module is in a known good state irrespective
> > of what bootloader does with the module, so it must be done at boot=
=2E
> >=20
> > Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
>=20
> Acked-by: Paul Walmsley <paul@pwsan.com>
>=20
> Will you pick this up for the -rc series, or do you want me or Tony t=
o? =20
> Roger writes that this one's pretty important.

I suggest that you just queue this with your other fixes so we get
things working.

Regards,

Tony
=20
=20
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 12 ++----------
> >  arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 13 +++----------
> >  2 files changed, 5 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/=
mach-omap2/omap_hwmod_44xx_data.c
> > index 1e5b12c..3318cae9 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > @@ -2937,7 +2937,7 @@ static struct omap_hwmod_class_sysconfig omap=
44xx_usb_host_hs_sysc =3D {
> >  	.sysc_offs	=3D 0x0010,
> >  	.syss_offs	=3D 0x0014,
> >  	.sysc_flags	=3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE |
> > -			   SYSC_HAS_SOFTRESET),
> > +			   SYSC_HAS_SOFTRESET | SYSC_HAS_RESET_STATUS),
> >  	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> >  			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
> >  			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
> > @@ -3001,15 +3001,7 @@ static struct omap_hwmod omap44xx_usb_host_h=
s_hwmod =3D {
> >  	 * hence HWMOD_SWSUP_MSTANDBY
> >  	 */
> > =20
> > -	/*
> > -	 * During system boot; If the hwmod framework resets the module
> > -	 * the module will have smart idle settings; which can lead to de=
adlock
> > -	 * (above Errata Id:i660); so, dont reset the module during boot;
> > -	 * Use HWMOD_INIT_NO_RESET.
> > -	 */
> > -
> > -	.flags		=3D HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY |
> > -			  HWMOD_INIT_NO_RESET,
> > +	.flags		=3D HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
> >  };
> > =20
> >  /*
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/=
mach-omap2/omap_hwmod_54xx_data.c
> > index 9e08d69..e297d62 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> > @@ -1544,7 +1544,8 @@ static struct omap_hwmod_class_sysconfig omap=
54xx_usb_host_hs_sysc =3D {
> >  	.rev_offs	=3D 0x0000,
> >  	.sysc_offs	=3D 0x0010,
> >  	.sysc_flags	=3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_RESET_STATUS |
> > -			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
> > +			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
> > +			   SYSC_HAS_RESET_STATUS),
> >  	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> >  			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
> >  			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
> > @@ -1598,15 +1599,7 @@ static struct omap_hwmod omap54xx_usb_host_h=
s_hwmod =3D {
> >  	 * hence HWMOD_SWSUP_MSTANDBY
> >  	 */
> > =20
> > -	/*
> > -	 * During system boot; If the hwmod framework resets the module
> > -	 * the module will have smart idle settings; which can lead to de=
adlock
> > -	 * (above Errata Id:i660); so, dont reset the module during boot;
> > -	 * Use HWMOD_INIT_NO_RESET.
> > -	 */
> > -
> > -	.flags		=3D HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY |
> > -			  HWMOD_INIT_NO_RESET,
> > +	.flags		=3D HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
> >  	.main_clk	=3D "l3init_60m_fclk",
> >  	.prcm =3D {
> >  		.omap4 =3D {
> > --=20
> > 1.8.3.2
> >=20
>=20
>=20
> - Paul
