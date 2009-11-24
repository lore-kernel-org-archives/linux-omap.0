From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] Mux configuration for AM3517 TouchScreen support
Date: Tue, 24 Nov 2009 19:45:58 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404370D7731@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1258641974-2223-1-git-send-email-hvaibhav@ti.com>
 <20091123175326.GD22923@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20091123175326.GD22923@atomide.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Monday, November 23, 2009 11:23 PM
> To: Hiremath, Vaibhav
> Cc: linux-input@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/3] Mux configuration for AM3517 TouchScreen
> support
> 
> * hvaibhav@ti.com <hvaibhav@ti.com> [091119 06:45]:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> >  arch/arm/mach-omap2/mux.c             |    3 +++
> >  arch/arm/plat-omap/include/plat/mux.h |    1 +
> >  2 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> > index c18a94e..f64ce14 100644
> > --- a/arch/arm/mach-omap2/mux.c
> > +++ b/arch/arm/mach-omap2/mux.c
> > @@ -566,6 +566,9 @@ MUX_CFG_34XX("AF9_34XX_GPIO22", 0x5ec,
> >  	OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
> >  MUX_CFG_34XX("U3_34XX_GPIO61", 0x0c8,
> >  	OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
> > + /*Touch-screen*/
> > + MUX_CFG_34XX("U1_34XX_GPIO65", 0x0d2,
> > +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
> >  };
> >
> >  #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
> > diff --git a/arch/arm/plat-omap/include/plat/mux.h
> b/arch/arm/plat-omap/include/plat/mux.h
> > index ba77de6..244afee 100644
> > --- a/arch/arm/plat-omap/include/plat/mux.h
> > +++ b/arch/arm/plat-omap/include/plat/mux.h
> > @@ -854,6 +854,7 @@ enum omap34xx_index {
> >  	AH14_34XX_GPIO21,
> >  	AF9_34XX_GPIO22,
> >  	U3_34XX_GPIO61,
> > +	U1_34XX_GPIO65,
> >  };
> >
> >  struct omap_mux_cfg {
> 
> Let's put this on hold until we have the new mux framework
> up and running. This should not stop getting in the driver
> patch integrated.
> 
[Hiremath, Vaibhav] Ok. 

Thanks,
Vaibhav

> Regards,
> 
> Tony
