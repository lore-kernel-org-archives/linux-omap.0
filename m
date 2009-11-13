From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: [build errro on for-next branch] RE: [1/3] omap3evm: ehci: Add EHCI
 padconfig for board Rev >= E
Date: Fri, 13 Nov 2009 14:29:10 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394043702B09E@dbde02.ent.ti.com>
References: <20091112232832.GK24837@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47743 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754968AbZKMI7O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 03:59:14 -0500
In-Reply-To: <20091112232832.GK24837@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
> 
> * Ajay Kumar Gupta <ajay.gupta@ti.com> [091028 16:12]:
> > OMAP3EVM (Rev >= E) has EHCI port on main board itself. Apart from this
> > there is a slot to connect Mistral Daughter Card (MDC) to it which also
> > has one EHCI port. Only one EHCI port can be used at a time and we can
> > choose the port using GPIO61.
> >
> > These are the new GPIO lines used for different purpose on EHCI
> interface.
> > 	- GPIO21 - EHCI phy reset
> > 	- GPIO22 - EHCI VBUS enable
> > 	- GPIO61 - Selects EHCI port either on main board or on Mistral
> > 	  Daughter Card (MDC).
> 
> Let's put this on hold until we have the new mux framework. Should be
> trivial to do then.

Tony,

Another patch [1] which depends on this is already merged to 'for-next'
branch causing a compilation error.

[1] omap3evm: ehci: Update EHCI support on OMAP3EVM (Rev >= E)

So either revert the above patch from 'for-next' or merge the pinmux
patch also.

Regards,
Ajay
> 
> Tony
> 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> >
> > ---
> > arch/arm/mach-omap2/mux.c             |    7 +++++++
> >  arch/arm/plat-omap/include/plat/mux.h |    5 +++++
> >  2 files changed, 12 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> > index 32c953e..00ad592 100644
> > --- a/arch/arm/mach-omap2/mux.c
> > +++ b/arch/arm/mach-omap2/mux.c
> > @@ -551,6 +551,13 @@ MUX_CFG_34XX("AF13_3430_MMC3_DAT3", 0x5e2,
> >  MUX_CFG_34XX("AF26_34XX_SYS_NIRQ", 0x1E0,
> >  		OMAP3_WAKEUP_EN | OMAP34XX_PIN_INPUT_PULLUP |
> >  		OMAP34XX_MUX_MODE0)
> > +/* EHCI GPIO's on OMAP3EVM (Rev >= E) */
> > +MUX_CFG_34XX("AH14_34XX_GPIO21", 0x5ea,
> > +	OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
> > +MUX_CFG_34XX("AF9_34XX_GPIO22", 0x5ec,
> > +	OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
> > +MUX_CFG_34XX("U3_34XX_GPIO61", 0x0c8,
> > +	OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
> >  };
> >
> >  #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
> > diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-
> omap/include/plat/mux.h
> > index f3c1d8a..8316d4f 100644
> > --- a/arch/arm/plat-omap/include/plat/mux.h
> > +++ b/arch/arm/plat-omap/include/plat/mux.h
> > @@ -840,6 +840,11 @@ enum omap34xx_index {
> >
> >  	/* SYS_NIRQ T2 INT1 */
> >  	AF26_34XX_SYS_NIRQ,
> > +
> > +	/* EHCI GPIO's for OMAP3EVM (Rev >= E) */
> > +	AH14_34XX_GPIO21,
> > +	AF9_34XX_GPIO22,
> > +	U3_34XX_GPIO61,
> >  };
> >
> >  struct omap_mux_cfg {

