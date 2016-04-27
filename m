From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2 4/5] ARM: dts: omap5: describe control for ckobuffer
Date: Wed, 27 Apr 2016 15:31:03 +0300
Message-ID: <5720B107.4000907@ti.com>
References: <cover.1461003660.git.hns@goldelico.com>
 <a5fb89737594a656318896a8e43814c21ca992eb.1461003660.git.hns@goldelico.com>
 <20160426172710.GI5995@atomide.com>
 <70572DA1-BEB4-4681-BA6C-2E1C9002D730@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <70572DA1-BEB4-4681-BA6C-2E1C9002D730@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Tony Lindgren <tony@atomide.com>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, ldewangan@nvidia.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, marek@goldelico.com, kernel@pyra-handheld.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On 27/04/16 09:04, H. Nikolaus Schaller wrote:
>
>> Am 26.04.2016 um 19:27 schrieb Tony Lindgren <tony@atomide.com>:
>>
>> Tero,
>>
>> * H. Nikolaus Schaller <hns@goldelico.com> [160418 11:23]:
>>> OMAP5 has a register to control if the ckobuffer is enabled
>>> and defines the polarity. ckobuffer is required to drive a twl6040
>>> with the system clock. Hence, add the pinctrl,single to the
>>> OMAP5 SoC description so that omap5-board-common can
>>> set up the ckobuffer as required.
>>
>> Is this really a mux or should it be a mux clock?
>
> It is a pinmux setting for the clock out buffer to choose what signal
> (and polarity) is presented on the fref_xtal_clk pad.
>
> The register is part of the CTRL_MODULE_WKUP.
> The clock signal is the xtal master clock of the whole SoC.
>
> Although there is a bit to choose an alternate clock, there is no
> alternate in the OMAP5 silicon.
>
> Therefore I would say it is about padconf and not clock or clock mux
> related.
>
> It just happens to be a clock signal which can be routed to this
> pad.

The two could very well be implemented as clock nodes, a mux and a gate. 
This would describe the hardware functionality better imo, if the 
assumptions made here are correct. Implementing the control as pinctrl 
hacks looks rather weird to me.

I could not find any documentation related to the ckobuffer usage 
though, maybe Peter can provide some insight? I think you spent some 
considerable time bringing up twl6040 a few years back...

-Tero

>
> BR,
> Nikolaus
>
>>
>> Regards,
>>
>> Tony
>>
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> ---
>>> arch/arm/boot/dts/omap5.dtsi | 10 ++++++++++
>>> 1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>>> index 120b6b8..1d9050f 100644
>>> --- a/arch/arm/boot/dts/omap5.dtsi
>>> +++ b/arch/arm/boot/dts/omap5.dtsi
>>> @@ -277,6 +277,16 @@
>>> 				pinctrl-single,register-width = <16>;
>>> 				pinctrl-single,function-mask = <0x7fff>;
>>> 			};
>>> +
>>> +			omap5_control_ckobuffer: pinmux@cdb4 {
>>> +				compatible = "ti,omap5-padconf",
>>> +					     "pinctrl-single";
>>> +				reg = <0xcdb4 4>;
>>> +				#address-cells = <1>;
>>> +				#size-cells = <0>;
>>> +				pinctrl-single,register-width = <32>;
>>> +				pinctrl-single,function-mask = <0xf0000000>;
>>> +			};
>>> 		};
>>>
>>> 		ocmcram: ocmcram@40300000 {
>>> --
>>> 2.7.3
>>>
>
