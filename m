From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/1] ARM: dts: omap5: Add clocks to USB3 PHY node
Date: Fri, 18 Apr 2014 15:29:54 -0700
Message-ID: <20140418222954.GH21823@atomide.com>
References: <1396348647-11545-1-git-send-email-rogerq@ti.com>
 <1396348647-11545-2-git-send-email-rogerq@ti.com>
 <20140401141308.GB4717@saruman.home>
 <534B8CC3.7050008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <534B8CC3.7050008-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [140414 00:23]:
> Hi Tony,
> 
> On 04/01/2014 05:13 PM, Felipe Balbi wrote:
> > On Tue, Apr 01, 2014 at 01:37:27PM +0300, Roger Quadros wrote:
> >> The USB3 PHY driver (ti-pipe3) was updated so that the relevant
> >> clock phandles are expected in the DT node.
> >> Provide the necessary clocks.
> >>
> >> Reported-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> >> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> > 
> > Great!!!
> > 
> > Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> 
> Could you please pick this up for 3.15-rc? Thanks.

Yes applying into omap-for-v3.15/fixes thanks.

Tony
 
> >>  arch/arm/boot/dts/omap5.dtsi | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> >> index 757f0b9..4df1e7a 100644
> >> --- a/arch/arm/boot/dts/omap5.dtsi
> >> +++ b/arch/arm/boot/dts/omap5.dtsi
> >> @@ -794,6 +794,12 @@
> >>  				      <0x4a084c00 0x40>;
> >>  				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
> >>  				ctrl-module = <&omap_control_usb3phy>;
> >> +				clocks = <&usb_phy_cm_clk32k>,
> >> +					 <&sys_clkin>,
> >> +					 <&usb_otg_ss_refclk960m>;
> >> +				clock-names =	"wkupclk",
> >> +						"sysclk",
> >> +						"refclk";
> >>  				#phy-cells = <0>;
> >>  			};
> >>  		};
> >> -- 
> >> 1.8.3.2
> >>
> > 
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
