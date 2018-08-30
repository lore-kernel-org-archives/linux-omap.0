From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: cpsw: Document cpsw-phy-sel usage
 but prefer phandle
Date: Thu, 30 Aug 2018 14:55:32 -0700
Message-ID: <20180830215532.GW7523@atomide.com>
References: <20180829150024.43210-1-tony@atomide.com>
 <90e0f25f-45f5-b2c0-59d9-cdf25eb06c0c@ti.com>
 <20180830004745.GU7523@atomide.com>
 <69161960-259c-6911-67b5-546ccb433165@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <69161960-259c-6911-67b5-546ccb433165@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Murali Karicheri <m-karicheri2@ti.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [180830 17:08]:
> On 08/29/2018 07:47 PM, Tony Lindgren wrote:
> > In general, it seems cpsw is just an interconnect instance
> > (L4_FAST) with a control module (CPSW_WR) and a pile of
> > independent other modules. That's described nicely in
> > am437x TRM chapter "2.1.4 L4 Fast Peripheral Memory Map".
> > So from that point of view the binding reg entries right
> > now are all wrong :)
> 
> TRM not consistent - for am5 it's one MMIO region.

Well that same information is there in 57xx TRM in chapter
"Table 26-1454. GMAC_SW Instance Summary". But yeah, all
the cpsw internal devices are stuffed into a single
interconnect target module.

> > In the long run cpsw should be really treated as an
> > interconnect instance with it's control module providing
> > standard Linux framework services such as clock /
> > regulator / phy / pinctrl / iio whatever for the other
> > modules.
> > 
> > Just my 2c based on looking at the interconnect, I'm
> > not too familiar with cpsw otherwise.
> 
> It's not separate modules. this is composite module which have only one
> fck/ick and most of blocks can't even function without each other.
> Above might be the case for Keystone 2, but not omap CPSW.
> Keystone 2 - has packet processor, security accelerator, queue manager in
> addition to its basic switch block.

Yeah there's just one fck/ick as it's all in a single
interconnect module. But you might want to look at the
CPSW_WR device registers and see what gate clocks and other
Linux generic subsystem services CPSW_WR could provide for
the other cpsw internal devices. It might just make your
life easier maintaining all these variants ;)

Regards,

Tony
