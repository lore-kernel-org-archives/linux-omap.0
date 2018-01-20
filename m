From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] reset: ti-rstctrl: use the reset-simple driver
Date: Fri, 19 Jan 2018 18:43:21 -0600
Message-ID: <d5e1dda3-fb89-9280-6d68-b02996b5cd0c@ti.com>
References: <20180116011159.1386-1-tony@atomide.com>
 <1516095054.9022.1.camel@pengutronix.de> <20180116150314.GC4042@atomide.com>
 <d32d9836-5edd-d43d-547b-f22384950f2c@ti.com>
 <20180116232243.GD4042@atomide.com>
 <10dab35c-9c79-5a77-0654-1e99621e4c0f@ti.com>
 <20180119213310.GA4180@atomide.com>
 <06882c43-d689-2b85-a1c4-ae4e13a73046@ti.com>
 <20180119234938.GB4180@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180119234938.GB4180-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Parsons <lost.distance-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishant Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 01/19/2018 05:49 PM, Tony Lindgren wrote:
> * Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [180119 23:30]:
>> On 01/19/2018 03:33 PM, Tony Lindgren wrote:
>>> OK let's do some tests on that, I'll take a look at doing a dts
>>> file over next few weeks.
>>
>> You can look up the patches folder in the above repo, there are some
>> example nodes there already, they are rather straight-forward.
> 
> Just for reference, here's what I played with but keep getting
> -EPROBE_DEFER somewhere during init.

Hmm, What's the baseline branch you are using - mainline, linux-next or
your for-next?

> 
> Regards,
> 
> Tony
> 
> 	prm: prm@6000 {
> 		...
> 		ranges = <0 0x6000 0x3000>;
> 
> 		prm_dsp: prm@400 {
> 			compatible = "simple-bus";
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			ranges = <0 0x400 0x100>;
> 
> 			dsp_rstctrl: rstctrl@10 {
> 				compatible = "ti,rstctrl";
> 				reg = <0x10 0x4>;
> 				#reset-cells = <1>;
> 			};
> 		};
> 		...
> 	};
> 
> 	target-module@4a066000 {
> 		compatible = "ti,sysc-omap2", "ti,sysc";
> 		ti,hwmods = "mmu_dsp";
> 		reg = <0x4a066000 0x4>,
> 		      <0x4a066010 0x4>,
> 		      <0x4a066014 0x4>;
> 		reg-names = "rev", "sysc", "syss";
> 		ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
> 				 SYSC_OMAP2_SOFTRESET |
> 				 SYSC_OMAP2_AUTOIDLE)>;
> 		ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> 				<SYSC_IDLE_NO>,
> 				<SYSC_IDLE_SMART>;
> 		clocks = <&tesla_clkctrl OMAP4_DSP_CLKCTRL 0>;
> 		clock-names = "fck";
> 		resets = <&dsp_rstctrl 1>,
> 			 <&dsp_rstctrl 0>;
> 		reset-names = "rst2", "rst1";

We definitely do not want the two resets here for sure, as the rst2
belongs to the dsp core (I believe it would be a sibling node to mmu_dsp
here), and cannot be released from reset without programming the MMU and
loading the code.

regards
Suman

> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		ranges = <0 0x4a066000 0x1000>;
> 
> 		mmu_dsp: mmu@0 {
> 			compatible = "ti,omap4-iommu";
> 			reg = <0 0x100>;
> 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> 			#iommu-cells = <0>;
> 		};
> 	};
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
