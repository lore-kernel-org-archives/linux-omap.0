From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] ARM: dts: dra7: add PRU-ICSS modules
Date: Mon, 1 Apr 2019 07:30:37 -0700
Message-ID: <20190401143036.GF49658@atomide.com>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
 <1549295637-24890-4-git-send-email-rogerq@ti.com>
 <20190204180359.GM5720@atomide.com>
 <454fbfc1-e05b-494e-6e27-0945ebed0154@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <454fbfc1-e05b-494e-6e27-0945ebed0154@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: s-anna@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, david@lechnology.com, woods.technical@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190329 14:02]:
> Hi Tony,
> 
> On 04/02/2019 20:03, Tony Lindgren wrote:
> > * Roger Quadros <rogerq@ti.com> [190204 15:54]:
> >> --- a/arch/arm/boot/dts/dra7.dtsi
> >> +++ b/arch/arm/boot/dts/dra7.dtsi
> >> @@ -167,6 +167,200 @@
> >>  		l4_per3: interconnect@48800000 {
> >>  		};
> >>  
> >> +		pru_icss1: target-module@4b200000 {
> > 
> > I suggest you add these into dra7-pruss.dtsi as they
> > have internal interconnects. And eventually some of
> > the *pruss.dtsi files might become shared :) And we
> > avoid moving these around when we define the l3
> > interconnects and avoid a lot of extra long dtsi
> > line lengths with the added nestedness later on.
> 
> PRUSS is only present on AM57x variants.
> I will move this to am57x-pruss.dtsi.
> 
> This means all AM57x boards will have to include it.
> 
> Is this OK?

Sure sounds good to me.

Regards,

Tony
