From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 2/3 v5] arm: omap: am335x: enable phy controls
Date: Mon, 12 Mar 2012 12:52:14 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93186A329@DBDE01.ent.ti.com>
References: <1328686872-22924-1-git-send-email-ajay.gupta@ti.com>
 <1328686872-22924-2-git-send-email-ajay.gupta@ti.com>
 <20120305225042.GI12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38156 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754978Ab2CLMwT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 08:52:19 -0400
In-Reply-To: <20120305225042.GI12083@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>

Hi Tony,
> * Ajay Kumar Gupta <ajay.gupta@ti.com> [120207 23:10]:
> > Switch on the phy for am335x.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_phy_internal.c |   21 ++++++++++++++-------
> >  1 files changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-
> omap2/omap_phy_internal.c
> > index 4c90477..7129408 100644
> > --- a/arch/arm/mach-omap2/omap_phy_internal.c
> > +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> > @@ -266,7 +266,11 @@ void ti81xx_musb_phy_power(u8 on)
> >  	void __iomem *scm_base = NULL;
> >  	u32 usbphycfg;
> >
> > -	scm_base = ioremap(TI81XX_SCM_BASE, SZ_2K);
> > +	if (cpu_is_ti81xx())
> > +		scm_base = ioremap(TI81XX_SCM_BASE, SZ_2K);
> > +	else if (cpu_is_am33xx())
> > +		scm_base = ioremap(AM33XX_SCM_BASE, SZ_2K);
> > +
> >  	if (!scm_base) {
> >  		pr_err("system control module ioremap failed\n");
> >  		return;
> > @@ -278,16 +282,19 @@ void ti81xx_musb_phy_power(u8 on)
> >  		if (cpu_is_ti816x()) {
> >  			usbphycfg |= TI816X_USBPHY0_NORMAL_MODE;
> >  			usbphycfg &= ~TI816X_USBPHY_REFCLK_OSC;
> > -		} else if (cpu_is_ti814x()) {
> > -			usbphycfg &= ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN
> > -				| USBPHY_DPINPUT | USBPHY_DMINPUT);
> > -			usbphycfg |= (USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN
> > -				| USBPHY_DPOPBUFCTL | USBPHY_DMOPBUFCTL);
> > +		} else if (cpu_is_ti814x() || cpu_is_am33xx()) {
> > +			usbphycfg &= ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN);
> > +			usbphycfg |= USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN;
> > +			if (cpu_is_ti814x()) {
> > +				usbphycfg &= ~(USBPHY_DPINPUT |
> USBPHY_DMINPUT);
> > +				usbphycfg |= USBPHY_DPOPBUFCTL
> > +					| USBPHY_DMOPBUFCTL;
> > +			}
> >  		}
> >  	} else {
> >  		if (cpu_is_ti816x())
> >  			usbphycfg &= ~TI816X_USBPHY0_NORMAL_MODE;
> > -		else if (cpu_is_ti814x())
> > +		else if (cpu_is_ti814x() || cpu_is_am33xx())
> >  			usbphycfg |= USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
> >
> >  	}
> 
> Hmm I think I might have commented on this earlier..

Yes, you have already provided this comment and I need to post
the updated patches.

> But anyways,
> please change the code so cpu_is_xxxx tests are done only once
> during the init, not every time phy_power gets called.
> 
> So initialize something in phy_init so things get set for the
> board that's booted.

I will send the updated patches soon.

Thanks,
Ajay


> 
> Regards,
> 
> Tony
