From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 2/3 v5] arm: omap: am335x: enable phy controls
Date: Mon, 13 Feb 2012 09:40:26 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA9317F7709@DBDE01.ent.ti.com>
References: <1328675212-29693-1-git-send-email-ajay.gupta@ti.com>
 <1328675212-29693-2-git-send-email-ajay.gupta@ti.com>
 <20120210183143.GS1426@atomide.com>
 <47CEF8C4B26E8C44B22B028A650E0EA9317F6CF4@DBDE01.ent.ti.com>
 <20120213064930.GC6614@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34693 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754558Ab2BMJke convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Feb 2012 04:40:34 -0500
In-Reply-To: <20120213064930.GC6614@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
> On Mon, Feb 13, 2012 at 04:26:19AM +0000, Gupta, Ajay Kumar wrote:
> > Hi,
> > > * Ajay Kumar Gupta <ajay.gupta@ti.com> [120207 19:55]:
> > > > Switch on the phy for am335x.
> > > >
> > > > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > > > ---
> > > >  arch/arm/mach-omap2/omap_phy_internal.c |   21 ++++++++++++++----
> ---
> > > >  1 files changed, 14 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/arch/arm/mach-omap2/omap_phy_internal.c
> > > > b/arch/arm/mach-
> > > omap2/omap_phy_internal.c
> > > > index 4c90477..7129408 100644
> > > > --- a/arch/arm/mach-omap2/omap_phy_internal.c
> > > > +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> > > > @@ -266,7 +266,11 @@ void ti81xx_musb_phy_power(u8 on)
> > > >  	void __iomem *scm_base = NULL;
> > > >  	u32 usbphycfg;
> > > >
> > > > -	scm_base = ioremap(TI81XX_SCM_BASE, SZ_2K);
> > > > +	if (cpu_is_ti81xx())
> > > > +		scm_base = ioremap(TI81XX_SCM_BASE, SZ_2K);
> > > > +	else if (cpu_is_am33xx())
> > > > +		scm_base = ioremap(AM33XX_SCM_BASE, SZ_2K);
> > > > +
> > > >  	if (!scm_base) {
> > > >  		pr_err("system control module ioremap failed\n");
> > > >  		return;
> > > > @@ -278,16 +282,19 @@ void ti81xx_musb_phy_power(u8 on)
> > > >  		if (cpu_is_ti816x()) {
> > > >  			usbphycfg |= TI816X_USBPHY0_NORMAL_MODE;
> > > >  			usbphycfg &= ~TI816X_USBPHY_REFCLK_OSC;
> > > > -		} else if (cpu_is_ti814x()) {
> > > > -			usbphycfg &= ~(USBPHY_CM_PWRDN |
> USBPHY_OTG_PWRDN
> > > > -				| USBPHY_DPINPUT | USBPHY_DMINPUT);
> > > > -			usbphycfg |= (USBPHY_OTGVDET_EN |
> USBPHY_OTGSESSEND_EN
> > > > -				| USBPHY_DPOPBUFCTL | USBPHY_DMOPBUFCTL);
> > > > +		} else if (cpu_is_ti814x() || cpu_is_am33xx()) {
> > > > +			usbphycfg &= ~(USBPHY_CM_PWRDN |
> USBPHY_OTG_PWRDN);
> > > > +			usbphycfg |= USBPHY_OTGVDET_EN |
> USBPHY_OTGSESSEND_EN;
> > > > +			if (cpu_is_ti814x()) {
> > > > +				usbphycfg &= ~(USBPHY_DPINPUT |
> > > USBPHY_DMINPUT);
> > > > +				usbphycfg |= USBPHY_DPOPBUFCTL
> > > > +					| USBPHY_DMOPBUFCTL;
> > > > +			}
> > > >  		}
> > > >  	} else {
> > > >  		if (cpu_is_ti816x())
> > > >  			usbphycfg &= ~TI816X_USBPHY0_NORMAL_MODE;
> > > > -		else if (cpu_is_ti814x())
> > > > +		else if (cpu_is_ti814x() || cpu_is_am33xx())
> > > >  			usbphycfg |= USBPHY_CM_PWRDN |
> USBPHY_OTG_PWRDN;
> > > >
> > >
> > > Please remove all the cpu_is_xxxx calls from the *_phy_power
> functions.
> > > You should need those only in *_phy_init to set the right flags
> > > once, not every time you enable or disable the phy.
> >
> > Tony,
> >
> > This is a common function used by ti814x, ti816x and am335x and they
> > have mostly the same bit map but a few bits are different so we would
> > need to have cpu_is_xxxx.
> >
> > We use this *_phy_power(1) for phy on/init and *_phy_power(0) for phy
> > off and don't have separate *_phy_init(). Even in that case we would
> > require
> > cpu_is_xxxx() as phy power down bit is different for ti816x and same
> > for ti814x and am335x.
> >
> > Please let me know how should we handle this.
> 
> use cpu_is_xxxx() to set a flag, and check on the flag.

Are you saying save the flags once in a local static flag and use
the same later on?

Ajay

> 
> --
> balbi
