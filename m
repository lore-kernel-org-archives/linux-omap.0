From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v2 4/5] ARM: dts: omap5: describe control for ckobuffer
Date: Wed, 27 Apr 2016 08:04:43 +0200
Message-ID: <70572DA1-BEB4-4681-BA6C-2E1C9002D730@goldelico.com>
References: <cover.1461003660.git.hns@goldelico.com> <a5fb89737594a656318896a8e43814c21ca992eb.1461003660.git.hns@goldelico.com> <20160426172710.GI5995@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160426172710.GI5995-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


> Am 26.04.2016 um 19:27 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
> 
> Tero,
> 
> * H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [160418 11:23]:
>> OMAP5 has a register to control if the ckobuffer is enabled
>> and defines the polarity. ckobuffer is required to drive a twl6040
>> with the system clock. Hence, add the pinctrl,single to the
>> OMAP5 SoC description so that omap5-board-common can
>> set up the ckobuffer as required.
> 
> Is this really a mux or should it be a mux clock?

It is a pinmux setting for the clock out buffer to choose what signal
(and polarity) is presented on the fref_xtal_clk pad.

The register is part of the CTRL_MODULE_WKUP.
The clock signal is the xtal master clock of the whole SoC.

Although there is a bit to choose an alternate clock, there is no
alternate in the OMAP5 silicon.

Therefore I would say it is about padconf and not clock or clock mux
related.

It just happens to be a clock signal which can be routed to this
pad.

BR,
Nikolaus

> 
> Regards,
> 
> Tony
> 
>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>> ---
>> arch/arm/boot/dts/omap5.dtsi | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>> index 120b6b8..1d9050f 100644
>> --- a/arch/arm/boot/dts/omap5.dtsi
>> +++ b/arch/arm/boot/dts/omap5.dtsi
>> @@ -277,6 +277,16 @@
>> 				pinctrl-single,register-width = <16>;
>> 				pinctrl-single,function-mask = <0x7fff>;
>> 			};
>> +
>> +			omap5_control_ckobuffer: pinmux@cdb4 {
>> +				compatible = "ti,omap5-padconf",
>> +					     "pinctrl-single";
>> +				reg = <0xcdb4 4>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				pinctrl-single,register-width = <32>;
>> +				pinctrl-single,function-mask = <0xf0000000>;
>> +			};
>> 		};
>> 
>> 		ocmcram: ocmcram@40300000 {
>> -- 
>> 2.7.3
>> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
