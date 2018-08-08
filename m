From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] net: ethernet: cpsw-phy-sel: prefer phandle for phy sel
 and update binding
Date: Wed, 8 Aug 2018 06:48:36 -0700
Message-ID: <20180808134836.GS99251@atomide.com>
References: <20180808080354.100146-1-tony@atomide.com>
 <20180808115838.GA18314@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180808115838.GA18314@lunn.ch>
Sender: netdev-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Murali Karicheri <m-karicheri2@ti.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Andrew Lunn <andrew@lunn.ch> [180808 12:02]:
> > +++ b/Documentation/devicetree/bindings/net/cpsw.txt
> > @@ -19,6 +19,9 @@ Required properties:
> >  - slaves		: Specifies number for slaves
> >  - active_slave		: Specifies the slave to use for time stamping,
> >  			  ethtool and SIOCGMIIPHY
> > +- cpsw-phy-sel		: Specifies the phandle to the CPSW phy mode selection
> > +			  device. Note that in legacy cases cpsw-phy-sel may be
> > +			  a child device instead of a phandle.
> 
> Hi Tony
> 
> It would be good to reference cpsw-phy-sel.txt.

OK will add.

> > --- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
> > +++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
> > @@ -170,10 +170,13 @@ void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave)
> >  	struct device_node *node;
> >  	struct cpsw_phy_sel_priv *priv;
> >  
> > -	node = of_get_child_by_name(dev->of_node, "cpsw-phy-sel");
> > +	node = of_parse_phandle(dev->of_node, "cpsw-phy-sel", 0);
> >  	if (!node) {
> 
> Do you need to handle EPROBE_DEFER here? The phandle points to a
> device which has not yet been loaded? I'm not sure exactly where it
> will be returned, maybe it is bus_find_device(), but i expect to see
> some handling of it somewhere in this function.

With the proper interconnect hierarchy in the device tree there should be
no EPROBE_DEFER happening here as the interconnects are probed in the
right order with the always on interrupt with system control module first :)

But then again, adding support for EPROBE_DEFER here won't hurt either,
will take a look.

Regards,

Tony
