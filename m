From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 4/5] ARM: dts: omap5: describe control for ckobuffer
Date: Wed, 27 Apr 2016 17:10:35 +0300
Message-ID: <5720C85B.9010701@ti.com>
References: <cover.1461003660.git.hns@goldelico.com>
 <a5fb89737594a656318896a8e43814c21ca992eb.1461003660.git.hns@goldelico.com>
 <20160426172710.GI5995@atomide.com>
 <70572DA1-BEB4-4681-BA6C-2E1C9002D730@goldelico.com>
 <5720B107.4000907@ti.com>
 <A90F1BFC-A834-4EC0-81F9-2C8222AAA010@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A90F1BFC-A834-4EC0-81F9-2C8222AAA010-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, "Ujfalusi, Peter" <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 27/04/16 16:10, H. Nikolaus Schaller wrote:
>
>> Am 27.04.2016 um 14:31 schrieb Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>:
>>
>> On 27/04/16 09:04, H. Nikolaus Schaller wrote:
>>>
>>>> Am 26.04.2016 um 19:27 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
>>>>
>>>> Tero,
>>>>
>>>> * H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [160418 11:23]:
>>>>> OMAP5 has a register to control if the ckobuffer is enabled
>>>>> and defines the polarity. ckobuffer is required to drive a twl6040
>>>>> with the system clock. Hence, add the pinctrl,single to the
>>>>> OMAP5 SoC description so that omap5-board-common can
>>>>> set up the ckobuffer as required.
>>>>
>>>> Is this really a mux or should it be a mux clock?
>>>
>>> It is a pinmux setting for the clock out buffer to choose what signal
>>> (and polarity) is presented on the fref_xtal_clk pad.
>>>
>>> The register is part of the CTRL_MODULE_WKUP.
>>> The clock signal is the xtal master clock of the whole SoC.
>>>
>>> Although there is a bit to choose an alternate clock, there is no
>>> alternate in the OMAP5 silicon.
>>>
>>> Therefore I would say it is about padconf and not clock or clock mux
>>> related.
>>>
>>> It just happens to be a clock signal which can be routed to this
>>> pad.
>>
>> The two could very well be implemented as clock nodes, a mux and a gate. This would describe the hardware functionality better imo, if the assumptions made here are correct. Implementing the control as pinctrl hacks looks rather weird to me.
>
> Why do you consider it a "pinctrl hack"? IMHO it is not a hack, but 100% proper use of pinctrl.

It is just the level of abstraction we are talking about here. If it is 
a clock we are controlling, we should rather control it as a clock 
(higher level abstraction), not a pin.

>
> The control register for the clock output buffer is part of the CTRL_MODULE_WKUP, which includes the well known pin controls of gpio1_wk but also this ckobuffer control. So it is grouped with these in a single control register block of the SoC. See "19.6.5.1 CTRL_MODULE_WKUP_PAD" of the TRM.
>
> And IMHO, the naming "buffer" indicates that it controls the pad buffer (like all pinmux) and not the clock.
>
> Yes, of course if can be described differently, as you propose. And one might argue that the twl6040 might want to request its master clock input (19.2 MHz) which could turn on the buffer on demand.

 From logic point of view, it might be better to describe it as a clock 
node, so TWL6040 driver can ask for a clock and ask it be enabled.

>
> The question it raises to me are:
> * isn't it "overkill" to describe a static pinmux register setup (it does not need to be turned on/off during operation) as mux (without function in OMAP5 SoC) + gate?

If the mux doesn't exist in hardware, no need to worry about it then.

> * does it require new driver code to correctly write to the control register?

No, we should just be able to add some beef in the DT to describe the 
clock nodes.

> * does it work if the twl6040 is hooked up differently?

Define hooked up differently. Does the setup you propose work in that case?

>
>>
>> I could not find any documentation related to the ckobuffer usage though,
>
> On the EVM it is the FREF_XTAL_OUT (Ball L33) which goes as signal H_SYSCLK through a jumper (R87) and then as signal P_SYSCLK to the MCLK (Ball K7) of the twl6040.
>
> Description of FREF_XTAL_OUT is in section 3.3.1 of the TRM.

I was just looking for ckobuffer but the TRM indeed seems to talk about 
this as FREF_XTAL_CLK. It looks like there is probably no mux in the 
hardware. The bit of doc I am missing right now is the description of 
the SCM register in relation to what hardware actually does. Namely, 
some bits in the register are rather a mystery to me.

-Tero

>
>> maybe Peter can provide some insight?
>> I think you spent some considerable time bringing up twl6040 a few years back...
>
> Yes, that would certainly help to decide how to proceed.
>
>>
>
>>
>> -Tero
>
> BR and thanks,
> NIkolaus
>
>>
>>>
>>> BR,
>>> Nikolaus
>>>
>>>>
>>>> Regards,
>>>>
>>>> Tony
>>>>
>>>>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>>>>> ---
>>>>> arch/arm/boot/dts/omap5.dtsi | 10 ++++++++++
>>>>> 1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>>>>> index 120b6b8..1d9050f 100644
>>>>> --- a/arch/arm/boot/dts/omap5.dtsi
>>>>> +++ b/arch/arm/boot/dts/omap5.dtsi
>>>>> @@ -277,6 +277,16 @@
>>>>> 				pinctrl-single,register-width = <16>;
>>>>> 				pinctrl-single,function-mask = <0x7fff>;
>>>>> 			};
>>>>> +
>>>>> +			omap5_control_ckobuffer: pinmux@cdb4 {
>>>>> +				compatible = "ti,omap5-padconf",
>>>>> +					     "pinctrl-single";
>>>>> +				reg = <0xcdb4 4>;
>>>>> +				#address-cells = <1>;
>>>>> +				#size-cells = <0>;
>>>>> +				pinctrl-single,register-width = <32>;
>>>>> +				pinctrl-single,function-mask = <0xf0000000>;
>>>>> +			};
>>>>> 		};
>>>>>
>>>>> 		ocmcram: ocmcram@40300000 {
>>>>> --
>>>>> 2.7.3
>>>>>
>>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
