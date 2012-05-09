From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] pinctrl: Add generic pinctrl-simple driver that supports
 omap2+ padconf
Date: Wed, 09 May 2012 14:24:20 -0600
Message-ID: <4FAAD274.3000907@wwwdotorg.org>
References: <20120502172401.GG3739@atomide.com> <20120503065131.GA3738@game.jcrosoft.org> <20120503152708.GC5140@atomide.com> <4FA30805.5050804@wwwdotorg.org> <20120504044305.GD7788@game.jcrosoft.org> <20120504150342.GI5140@atomide.com> <20120504153251.GE7788@game.jcrosoft.org> <20120504163420.GA5613@atomide.com> <4FA42631.6060304@wwwdotorg.org> <20120505020414.GJ7788@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120505020414.GJ7788@game.jcrosoft.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 05/04/2012 08:04 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 12:55 Fri 04 May     , Stephen Warren wrote:
>> On 05/04/2012 10:34 AM, Tony Lindgren wrote:
>>> * Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> [120504 08:58]:
>>>> On 08:03 Fri 04 May     , Tony Lindgren wrote:
>>>>>>
>>>>>> so I was thinking to do like on gpio
>>>>>>
>>>>>> uart {
>>>>>> 	pin = < &pioA 12 {pararms} >
>>>>>>
>>>>>> }
>>>>>
>>>>> Hmm I assume the "12" above the gpio number?
>>>> no pin number in the bank because it could not be gpio
>>>
>>> Yes OK, but pin number 12 in the gpio bank, not in the mux register.
>>> Got it.
>>
>> I'd prefer to avoid any references to GPIOs here; not all muxable pins
>> are GPIOs and not all GPIOs are muxable pins. Lets keep the two concepts
>> independent.
>
> my idea was to have a phandle pinctrl specific to represent the bank
> and use it in the same way as done on gpio

OK, so when you're talking about GPIOs in this thread, you really mean
pins; nothing to do with real GPIOs? You're just using the existing GPIO
binding as an example/base for your pinctrl pin proposal.

...
>> I don't really see how that DT format represents pins, functions, and
>> nodes directly, and separately from which of those a board chooses to
>> use. I think this binding and the one Tony originally proposed are
>> eseentially semantically identical.
>>
>> Going back to my idea of separating SoC and board configurations, if we
>> did that, I'd expect to see something more like:
>>
>> soc.dtsi or board.dts:
>>
>> This is the data that the pin controller driver needs to export to
>> pinctrl core. This can be completely enumerated in the soc.dtsi, or
>> perhaps for uncommonly used pins/groups/functions, only included in the
>> board.dts that actually uses it to cut down on soc.dtsi's size:
>>
>> This data is not needed for SoCs whose pinctrl drivers include it in
>> their driver file instead of DT.
>
> I agree on at91 I propose exactly this but get the following comment tat we
> are going to have too much node.

That's why I put it in the Tegra driver not DT:-)

> so the idea I propoose with the pins array is to avoid this issue

OK, to some extent that makes sense, but it doesn't allow you to do
stuff like have the correct names for each pin, since each pin would be
something like "Bank 1 Pin 5" or "Bank 6 Pin 2"; not very descriptive.

> my first bindings on at91
...
> 1) we describe one functin per pin
> 
> functions {
> 	rxd_pb12 {
> 		atmel,pin-id = <&pioB 12>;
> 		atmel,mux = <0>;
> 	};
> 
> 	txd_pb13 {
> 		atmel,pin-id = <&piaB 13>;
> 		atmel,pull = <2>;
> 		atmel,mux = <0>;
> 	};

A function is a specific mux value you select on a pin or group. As
such, specifying "pull" within the definition of a function doesn't
really make sense.

Now, I know that many people want to auto-generate the functions and
groups from device tree, but actually calling them functions in the DT
binding isn't right, because those nodes represent the entire pin
configuration of a pin, not a function, which is some signal you can mux
onto a pin.
