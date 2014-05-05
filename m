From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v5 0/5] Add USB nodes for am43xx epos and gp evm
Date: Mon, 5 May 2014 12:23:47 -0700
Message-ID: <20140505192346.GC15463@atomide.com>
References: <1395223803-4714-1-git-send-email-george.cherian@ti.com>
 <20140425161912.GY29632@saruman.home>
 <536745F6.9080402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <536745F6.9080402-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBg9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, anatol.pomozov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* George Cherian <george.cherian-l0cyMroinI0@public.gmane.org> [140505 01:04]:
> Hi Benoit,
> 
> On 4/25/2014 9:49 PM, Felipe Balbi wrote:
> >On Wed, Mar 19, 2014 at 03:39:58PM +0530, George Cherian wrote:
> >>The patch series adds USB dt nodes for am43xx epos and gp evm
> >>Boot tested with linux-next + Tony's omap-for-v3.15/dt
> >>
> >>Changes from v1 -> v2
> >>	* Reorder "doc: Add "ti,am437x-dwc3" comaptible for dwc3 glue"
> >>	* Address v1 coments on "ARM: dts: AM4372: Add USB nodes"
> >>
> >>Changes from v2 -> v3
> >>	* Removed unwanted dwc3_1 and dwc3_2 nodes from am437x-gp-evm.dts
> >>	  and am43x-epos-evm.dts
> >>
> >>Changes from v3 -> v4
> >>	* Refreshed on top of Tony's omap-for-v3.15/dt tree
> >>	* Added usb_phy0_always_on_clk32k and usb_phy1_always_on_clk32k Patch 2
> >>	* Used the above clocks in Patch 3
> >>	* Patch 4 and 5 edited the unwanted portions of commit log
> >>
> >>Changes from v4 -> v5
> >>	* Address Roger's comment for the clock data
> >>
> >>George Cherian (5):
> >>   doc: Add "ti,am437x-dwc3" comaptible for dwc3 glue
> >>   ARM: dts: am43xx clock data
> >>   ARM: dts: AM4372: Add USB nodes
> >>   ARM: dts: am437x-gp-evm: Enable USB
> >>   ARM: dts: am43x-epos-evm: Enable USB
> >>
> >>  Documentation/devicetree/bindings/usb/omap-usb.txt |  4 +-
> >>  arch/arm/boot/dts/am4372.dtsi                      | 94 ++++++++++++++++++++++
> >>  arch/arm/boot/dts/am437x-gp-evm.dts                | 18 +++++
> >>  arch/arm/boot/dts/am43x-epos-evm.dts               | 18 +++++
> >>  arch/arm/boot/dts/am43xx-clocks.dtsi               | 32 ++++++++
> >>  5 files changed, 165 insertions(+), 1 deletion(-)
> >Is this applied anywhere yet ? Benoit, are you taking this for v3.16
> >merge window ?
> >
> Ping on this series.

Applying these into omap-for-v3.16/dt as I'm applying patches today.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
