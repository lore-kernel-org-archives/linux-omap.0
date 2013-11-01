From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 08/43] clk: ti: add composite clock support
Date: Fri, 1 Nov 2013 11:40:30 +0200
Message-ID: <5273770E.6090500@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-9-git-send-email-t-kristo@ti.com> <527284DC.2070701@ti.com> <5272861E.3090506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56348 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380Ab3KAJlP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Nov 2013 05:41:15 -0400
In-Reply-To: <5272861E.3090506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10/31/2013 06:32 PM, Nishanth Menon wrote:
> On 10/31/2013 11:27 AM, Nishanth Menon wrote:
>> On 10/25/2013 10:57 AM, Tero Kristo wrote:
>>> This is a multipurpose clock node, which contains support for multiple
>>> sub-clocks. Uses basic composite clock type to implement the actual
>>> functionality, and TI specific gate, mux and divider clocks.
>>>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> ---
>>>   .../devicetree/bindings/clock/ti/composite.txt     |   54 +++++
>>>   drivers/clk/ti/Makefile                            |    2 +-
>>>   drivers/clk/ti/composite.c                         |  222 ++++++++++++++++++++
>>>   include/linux/clk/ti.h                             |    8 +
>>>   4 files changed, 285 insertions(+), 1 deletion(-)
>>>   create mode 100644 Documentation/devicetree/bindings/clock/ti/composite.txt
>>>   create mode 100644 drivers/clk/ti/composite.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/ti/composite.txt b/Documentation/devicetree/bindings/clock/ti/composite.txt
>>> new file mode 100644
>>> index 0000000..5f43c47
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/ti/composite.txt
>>> @@ -0,0 +1,54 @@
>>> +Binding for TI composite clock.
>>> +
>>> +Binding status: Unstable - ABI compatibility may be broken in the future
>>> +
>>> +This binding uses the common clock binding[1]. It assumes a
>>> +register-mapped composite clock with multiple different sub-types;
>>> +
>>> +a multiplexer clock with multiple input clock signals or parents, one
>>> +of which can be selected as output, this behaves exactly as [2]
>>> +
>>> +an adjustable clock rate divider, this behaves exactly as [3]
>>> +
>>> +a gating function which can be used to enable and disable the output
>>> +clock, this behaves exactly as [4]
>>> +
>>> +The binding must provide a list of the component clocks that shall be
>>> +merged to this clock. The component clocks shall be of one of the
>>> +"ti,*composite*-clock" types.
>>> +
>>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>>> +[2] Documentation/devicetree/bindings/clock/ti/mux.txt
>>> +[3] Documentation/devicetree/bindings/clock/ti/divider.txt
>>> +[4] Documentation/devicetree/bindings/clock/ti/gate.txt
>>> +
>>> +Required properties:
>>> +- compatible : shall be: "ti,composite-clock"
>>> +- clocks : link phandles of component clocks
>>> +- #clock-cells : from common clock binding; shall be set to 0.
>>> +
>>> +Examples:
>>> +
>>> +usb_l4_gate_ick: usb_l4_gate_ick {
>>> +	#clock-cells = <0>;
>>> +	compatible = "ti,composite-interface-clock";
>>> +	clocks = <&l4_ick>;
>>> +	ti,bit-shift = <5>;
>>> +	reg = <0x0a10>;
>>> +};
>>> +
>>> +usb_l4_div_ick: usb_l4_div_ick {
>>> +	#clock-cells = <0>;
>>> +	compatible = "ti,composite-divider-clock";
>>> +	clocks = <&l4_ick>;
>>> +	ti,bit-shift = <4>;
>>> +	ti,max-div = <1>;
>>> +	reg = <0x0a40>;
>>> +	ti,index-starts-at-one;
>>> +};
>>> +
>>> +usb_l4_ick: usb_l4_ick {
>>> +	#clock-cells = <0>;
>>> +	compatible = "ti,composite-clock";
>>> +	clocks = <&usb_l4_gate_ick>, <&usb_l4_div_ick>;
>>> +};
>
>  From Topology perspective, would this be a better approach?
>
> usb_l4_ick: usb_l4_ick {
> 	#clock-cells = <0>;
> 	compatible = "ti,composite-clock";
>
> 	usb_l4_gate_ick: usb_l4_gate_ick {
> 		#clock-cells = <0>;
> 		compatible = "ti,composite-interface-clock";
> 		clocks = <&l4_ick>;
> 		ti,bit-shift = <5>;
> 		reg = <0x0a10>;
> 	};
>
> 	usb_l4_div_ick: usb_l4_div_ick {
> 		#clock-cells = <0>;
> 		compatible = "ti,composite-divider-clock";
> 		clocks = <&l4_ick>;
> 		ti,bit-shift = <4>;
> 		ti,max-div = <1>;
> 		reg = <0x0a40>;
> 		ti,index-starts-at-one;
> 	};
> };

Well I was considering this, however this would require extra level of 
registration also:

of_ti_composite_clk_setup ->
   (match children against composite types)
   of_ti_composite_divider_setup
   of_ti_composite_gate_setup

Might be cleaner overall though, so I can take a look at this.

-Tero
