From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH] ARM: dts: am33xx: Correct gpio #interrupt-cells property
Date: Wed, 21 Aug 2013 09:57:01 +0200
Message-ID: <201308210957.01956.poeschel@lemonage.de>
References: <1375873592-26881-1-git-send-email-larsi@wh2.tu-dresden.de> <20130821075016.GW7656@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130821075016.GW7656@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Lars Poeschel <larsi@wh2.tu-dresden.de>, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony!

On Wednesday 21 August 2013 at 09:50:16, Tony Lindgren wrote:
> Benoit,
> 
> Care to take a look at this too?

Benoit already applied this with Mark Rutlands Acked-By and Javier Martinez 
Canillas Reviewed-by.

Regards,
Lars
 
> * Lars Poeschel <larsi@wh2.tu-dresden.de> [130807 04:14]:
> > From: Lars Poeschel <poeschel@lemonage.de>
> > 
> > Following commit ff5c9059 and therefore other omap platforms using
> > the gpio-omap driver correct the #interrupt-cells property on am33xx
> > too. The omap gpio binding documentaion also states that
> > the #interrupt-cells property should be 2.
> > 
> > Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> > ---
> > 
> >  arch/arm/boot/dts/am33xx.dtsi |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi
> > b/arch/arm/boot/dts/am33xx.dtsi index 38b446b..033c5dd 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -102,7 +102,7 @@
> > 
> >  			gpio-controller;
> >  			#gpio-cells = <2>;
> >  			interrupt-controller;
> > 
> > -			#interrupt-cells = <1>;
> > +			#interrupt-cells = <2>;
> > 
> >  			reg = <0x44e07000 0x1000>;
> >  			interrupts = <96>;
> >  		
> >  		};
> > 
> > @@ -113,7 +113,7 @@
> > 
> >  			gpio-controller;
> >  			#gpio-cells = <2>;
> >  			interrupt-controller;
> > 
> > -			#interrupt-cells = <1>;
> > +			#interrupt-cells = <2>;
> > 
> >  			reg = <0x4804c000 0x1000>;
> >  			interrupts = <98>;
> >  		
> >  		};
> > 
> > @@ -124,7 +124,7 @@
> > 
> >  			gpio-controller;
> >  			#gpio-cells = <2>;
> >  			interrupt-controller;
> > 
> > -			#interrupt-cells = <1>;
> > +			#interrupt-cells = <2>;
> > 
> >  			reg = <0x481ac000 0x1000>;
> >  			interrupts = <32>;
> >  		
> >  		};
> > 
> > @@ -135,7 +135,7 @@
> > 
> >  			gpio-controller;
> >  			#gpio-cells = <2>;
> >  			interrupt-controller;
> > 
> > -			#interrupt-cells = <1>;
> > +			#interrupt-cells = <2>;
> > 
> >  			reg = <0x481ae000 0x1000>;
> >  			interrupts = <62>;
> >  		
> >  		};
