From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Configure omap5 AESS
Date: Tue, 14 Jan 2020 09:16:34 -0800
Message-ID: <20200114171634.GS5885@atomide.com>
References: <20200114150937.18304-1-tony@atomide.com>
 <52905C15-A2D1-4372-9781-D602D0B274B6@goldelico.com>
 <20200114164613.GR5885@atomide.com>
 <D51230C4-2642-4388-959F-313A3382AB99@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <D51230C4-2642-4388-959F-313A3382AB99-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [200114 17:05]:
> > Am 14.01.2020 um 17:46 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
> > Care to clarify what you have in mind? The module is generic, aess
> > device will be the child node.
> 
> The existing driver is hooked into the sound root-node and looks for a
> ti,aess = <&aess>; link:
> 
> / {
> 	sound: sound {
> 		compatible = "ti,abe-twl6040";
> 		ti,model = "omap5-uevm";
> 
> 		ti,jack-detection;
> 		ti,mclk-freq = <19200000>;
> 
> 		ti,mcpdm = <&mcpdm>;
> 		ti,mcbsp1 = <&mcbsp1>;
> 		ti,mcbsp2 = <&mcbsp2>;
> 		ti,mcbsp3 = <&mcbsp3>;
> 
> 		ti,twl6040 = <&twl6040>;
> 		ti,aess = <&aess>;
> 
> 		...
> 	};
> };
> 
> Well, this could be simply wrong... I.e. the aess node should request
> all the phandles to mcpdm and mcbsps because it is connected to.

The aess label above should be in the child aess node, not in the
target-module.

> Or it is right to use the sound node to "connect" all subsystems.

Sounds like that's all taken care of nowadays with the generic
graph binding:

Documentation/devicetree/bindings/graph.txt

See also snd-soc-audio-graph-card and various users for it:

Documentation/devicetree/bindings/sound/audio-graph-card.txt

> Then the "aess" core could also become the child node of the target-module:
> 
> target-module@f1000 {			/* 0x401f1000, ap 32 20.0 */
> 	...
> 	aess: aess {
> 		compatible = "ti,aess";
> 		status = "disabled";
> 	};
> };

Yeah this is how it should be :)

> Although it looks better this way, it may make it even one step
> more difficult to resurrect the old code...

Well the old phandles and properties should work the same, just put them
into the child aess node. No need to stuff anything else there at the
target-module level AFAIK.

> And DT maintainers are not happy with otherwise undefined compatible
> definitions.
> 
> So maybe:
> 
> target-module@f1000 {			/* 0x401f1000, ap 32 20.0 */
> 	...
> 
> 	aess: aess {
> 		/* revisit
> 		compatible = "ti,aess";
> 		status = "disabled";
> 		*/
> 	};
> };

But we have no binding and no driver for the aess at this point..
If and when the aess driver work the child node can be just added :)

Regards,

Tony
