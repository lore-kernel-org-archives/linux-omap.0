From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: AM335x ICE board Linux support
Date: Thu, 5 May 2016 10:06:12 -0700
Message-ID: <20160505170612.GY5995@atomide.com>
References: <571E069A.20700@ti.com>
 <571F2982.2080702@ti.com>
 <20160426151046.GQ5995@atomide.com>
 <572332B2.6010203@ti.com>
 <20160429153158.GJ5995@atomide.com>
 <57270E8E.2040704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57270E8E.2040704-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, "Anna, Suman" <s-anna-l0cyMroinI0@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [160502 01:25]:
> On 29/04/16 18:31, Tony Lindgren wrote:
> > * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [160429 03:10]:
> >> On 26/04/16 18:10, Tony Lindgren wrote:
> >>> I guess for now if no runtime detection is possible in the kernel.
> >>
> >> There are 2 ways to detect them mode
> >> 1) Enabe GPIO rising edge detect interrupt and reset the Ethernet PHY
> >> 2) read a PHY register over MDIO bus
> >>
> >> I'm not very sure where this can be done in the kernel.
> > 
> > We already have some PHY detection over MDIO detection in place,
> > so that's probably the most generic solution.
> 
> Sorry, I didn't get you.
> Based on the PHY node we need to switch the MAC driver.
> i.e. either CPSW or PRUeth.
> The PHY driver remains the same in both modes.

OK

> >> Even if there is some place to do the detection, how do we go about reconfiguring the
> >> device tree?
> > 
> > You may not need to, you can have several named pin states:
> > 
> > pinctrl-names = "default", "phy-foo", "phy-bar";
> > pinctrl-0 = <&cpsw_default>;
> > pinctrl-1 = <&cpsw_phy_foo>;
> > pinctrl-2 = <&cpsw_phy_bar>;
> > ...
> > 
> > Then have the common pins in cpsw_default, and manually enable
> > the other pinctrl groups based on the detection. We already
> > have that going on in am335x-bone-common.dtsi with the &mac
> > entry for cpsw.
> 
> Probably I'm looking at the wrong place but in am353x-bone-common.dtsi
> I only see "default" and "sleep" pins.
> 
> > 
> > But maybe you have other detection issues too beyond setting
> > the pins?
> 
> It is not only about the pinmux but using an entirely different MAC driver.
> So we need to enable/disable different MAC drivers.
> 
> It gets even trickier if one port is assigned to one MAC driver and the other
> one to another MAC driver. The pinmux now has to be port specific and the
> cpsw driver has to be updated to support port specific pinmux. As of now
> it handles only one pinmux group for both its ports.

OK I guess up to you to figure out what makes most sense here.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
