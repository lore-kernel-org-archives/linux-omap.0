From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: cpsw: Document cpsw-phy-sel usage
 but prefer phandle
Date: Wed, 29 Aug 2018 17:47:45 -0700
Message-ID: <20180830004745.GU7523@atomide.com>
References: <20180829150024.43210-1-tony@atomide.com>
 <90e0f25f-45f5-b2c0-59d9-cdf25eb06c0c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <90e0f25f-45f5-b2c0-59d9-cdf25eb06c0c@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Murali Karicheri <m-karicheri2@ti.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [180830 00:12]:
> Hi Tony,
> 
> On 08/29/2018 10:00 AM, Tony Lindgren wrote:
> > The current cpsw usage for cpsw-phy-sel is undocumented but is used for
> > all the boards using cpsw. And cpsw-phy-sel is not really a child of
> > the cpsw device, it lives in the system control module instead.
> > 
> > Let's document the existing usage, and improve it a bit where we prefer
> > to use a phandle instead of a child device for it. That way we can
> > properly describe the hardware in dts files for things like genpd.
> 
> I'm ok with this series, but I really don't like cpsw-phy-sel in general.

Yeah this binding predates any standards. This series
only fixes the nasty issue of cpsw claiming a module as a
child that's outside it's IO range.

> It was introduced long time back and now I'm thinking about possibility to replace it with
> one of current generic interfaces - for example mux-controller. 
> Each port will control up to 3 muxes (port mode, idmode and rmii_ext_clk) and  
> transform phy-mode => mux states.
> What do you think?

Sure a mux-controller here makes sense.

> Another option is to use phy, but it'd be complicated.

For the port muxes, how about a phy driver just using
a pinctrl driver?

In general, it seems cpsw is just an interconnect instance
(L4_FAST) with a control module (CPSW_WR) and a pile of
independent other modules. That's described nicely in
am437x TRM chapter "2.1.4 L4 Fast Peripheral Memory Map".
So from that point of view the binding reg entries right
now are all wrong :)

In the long run cpsw should be really treated as an
interconnect instance with it's control module providing
standard Linux framework services such as clock /
regulator / phy / pinctrl / iio whatever for the other
modules.

Just my 2c based on looking at the interconnect, I'm
not too familiar with cpsw otherwise.

Regards,

Tony
