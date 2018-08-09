From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] net: ethernet: cpsw-phy-sel: prefer phandle for phy sel
 and update binding
Date: Thu, 9 Aug 2018 03:46:53 -0700
Message-ID: <20180809104653.GV99251@atomide.com>
References: <20180808080354.100146-1-tony@atomide.com>
 <20180808115838.GA18314@lunn.ch>
 <20180808134836.GS99251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180808134836.GS99251@atomide.com>
Sender: netdev-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Murali Karicheri <m-karicheri2@ti.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180808 13:52]:
> * Andrew Lunn <andrew@lunn.ch> [180808 12:02]:
> > 
> > Do you need to handle EPROBE_DEFER here? The phandle points to a
> > device which has not yet been loaded? I'm not sure exactly where it
> > will be returned, maybe it is bus_find_device(), but i expect to see
> > some handling of it somewhere in this function.

If no device is found the driver just produces a warning currently.
And in that case cpsw attempts to continue with bootloader settings.

And looking at the caller function cpsw_slave_open() it also just
produces warnings for phy_connect() too..

I agree that in general this this whole pile of cpsw related drivers sure
could use some better error handling. Starting with making cpsw_slave_open()
and cpsw_phy_sel() return errors instead of just ignoring them might be a
good start.

Grygorii, care to add that note of things to do into your cpsw maintainer
hat?

> With the proper interconnect hierarchy in the device tree there should be
> no EPROBE_DEFER happening here as the interconnects are probed in the
> right order with the always on interrupt with system control module first :)
>
> But then again, adding support for EPROBE_DEFER here won't hurt either,
> will take a look.

I'll just add some notes about that to the patch description considering
the above.

Regards,

Tony
