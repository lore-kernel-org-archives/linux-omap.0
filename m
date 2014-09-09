From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 5/7] net: cpsw: Add am33xx MACID readout
Date: Tue, 9 Sep 2014 07:48:02 -0700
Message-ID: <20140909144802.GJ10785@atomide.com>
References: <1410110375-3570-1-git-send-email-mpa@pengutronix.de>
 <1410110375-3570-6-git-send-email-mpa@pengutronix.de>
 <20140908165116.GH3238@atomide.com>
 <20140909060522.GD24081@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32532 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbaIIOsU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2014 10:48:20 -0400
Content-Disposition: inline
In-Reply-To: <20140909060522.GD24081@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Rostedt <rostedt@goodmis.org>, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

* Markus Pargmann <mpa@pengutronix.de> [140908 23:05]:
> On Mon, Sep 08, 2014 at 09:51:17AM -0700, Tony Lindgren wrote:
> > * Markus Pargmann <mpa@pengutronix.de> [140907 10:20]:
> > > This patch adds a function to get the MACIDs from the am33xx SoC
> > > control module registers which hold unique vendor MACIDs. This is only
> > > used if of_get_mac_address() fails to get a valid mac address.
> > ...
> > 
> > > @@ -1928,8 +1960,16 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
> > >  			 PHY_ID_FMT, mdio->name, phyid);
> > >  
> > >  		mac_addr = of_get_mac_address(slave_node);
> > > -		if (mac_addr)
> > > +		if (mac_addr) {
> > >  			memcpy(slave_data->mac_addr, mac_addr, ETH_ALEN);
> > > +		} else {
> > > +			if (of_machine_is_compatible("ti,am33xx")) {
> > > +				ret = cpsw_am33xx_cm_get_macid(&pdev->dev, i,
> > > +							slave_data->mac_addr);
> > > +				if (ret)
> > > +					return ret;
> > > +			}
> > > +		}
> > >  
> > >  		slave_data->phy_if = of_get_phy_mode(slave_node);
> > >  		if (slave_data->phy_if < 0) {
> > 
> > Thanks for updating this, this looks more future proof for adding
> > the dra7 related patch.
> > 
> > For the long run, it probably makes sense to add SoC specific
> > compatible values such as "ti,cpsw-am3350" and so on. Then the
> > mac address functions can be initialized based on the of_device_id
> > entry for .data. The wiring is cleary SoC specific here.
> 
> The hardware doesn't differ across the SoCs, so I thought it may be
> better to keep one compatible and parse the machine compatible for the
> MACID location. But different compatible values are also ok.

Yes both will work, and you're right the Ethernet hardware is
the same. I already forgot that we're getting mac address from the
system control module.. And that's really SoC specific so your solution
is better at least for now.

Regards,

Tony
