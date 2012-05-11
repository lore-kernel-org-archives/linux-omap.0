From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] pinctrl: Add generic pinctrl-simple driver that supports
 omap2+ padconf
Date: Fri, 11 May 2012 13:17:44 -0600
Message-ID: <4FAD65D8.30109@wwwdotorg.org>
References: <4FA30805.5050804@wwwdotorg.org> <20120504044305.GD7788@game.jcrosoft.org> <20120504150342.GI5140@atomide.com> <20120504153251.GE7788@game.jcrosoft.org> <20120504163420.GA5613@atomide.com> <4FA42631.6060304@wwwdotorg.org> <20120504220809.GW5613@atomide.com> <4FAAD141.3090306@wwwdotorg.org> <20120509204925.GV5088@atomide.com> <4FABF553.20601@wwwdotorg.org> <20120510172722.GE21851@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120510172722.GE21851@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 05/10/2012 11:27 AM, Tony Lindgren wrote:
> * Stephen Warren <swarren@wwwdotorg.org> [120510 10:09]:
>> On 05/09/2012 02:49 PM, Tony Lindgren wrote:
>>> * Stephen Warren <swarren@wwwdotorg.org> [120509 13:22]:
>>>> On 05/04/2012 04:08 PM, Tony Lindgren wrote:
>>>>> * Stephen Warren <swarren@wwwdotorg.org> [120504 11:59]:
>>>>>> On 05/04/2012 10:34 AM, Tony Lindgren wrote:
>>>>>>> * Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> [120504 08:58]:
>>>>>>>> On 08:03 Fri 04 May     , Tony Lindgren wrote:
>>>>>>>>>>
>>>>>>>>>> so I was thinking to do like on gpio
>>>>>>>>>>
>>>>>>>>>> uart {
>>>>>>>>>> 	pin = < &pioA 12 {pararms} >
>>>>>>>>>>
>>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> Hmm I assume the "12" above the gpio number?
>>>>>>>> no pin number in the bank because it could not be gpio
>>>>>>>
>>>>>>> Yes OK, but pin number 12 in the gpio bank, not in the mux register.
>>>>>>> Got it.
>>>>>>
>>>>>> I'd prefer to avoid any references to GPIOs here; not all muxable pins
>>>>>> are GPIOs and not all GPIOs are muxable pins. Lets keep the two concepts
>>>>>> independent.
>>>>>
>>>>> And it seems that &pioA 12 is not always enough information for the pinctrl
>>>>> driver to request a GPIO. So it's best to specify it separately.
>>>>
>>>> Why would a pinctrl driver "request a GPIO"?
>>>
>>> Hmm what would pinctrl_request_gpio do if the GPIO driver is separate driver?
>>
>> Well, that's a GPIO driver requesting a GPIO from the pinctrl system,
>> rather than the pinctrl driver requesting a GPIO (sorry to be picky).
> 
> Oh sorry maybe I misunderstood what pinctrl_request_gpio is doing.
> Seems like that should work the same way from binding point of view.
>  
>> It wasn't at all obvious to me from your binding proposal that you
>> intended the pinctrl-simple driver to support the GPIO operations at
>> all. If you do want this, I think you'd need some properties (perhaps
>> some kind of explicit table) in order to set up the GPIO ID -> pinctrl
>> pin ID mapping. I don't recall seeing those; did I just miss them? I
>> think we'd want this to be explicit because:
>>
>> a) It may well be the case that not all users of pinctrl-simple actually
>> mux/control GPIOs at all. It's certainly possible to only mux "special
>> functions", and have dedicated pins for a GPIO controller.
>>
>> b) Even when GPIOs do come into the picture, it may be that only some of
>> the pins are available as GPIOs.
> 
> Right, we need some pinctrl to gpio mapping eventually. That comes
> automatically from DT for the pins and gpios we care about.
> 
> And that's why the binding needs to be flexible enough so we can add
> optional pin specific options as needed in addition to parsing a larger
> set of pins with no options.

The mapping of GPIO to pinctrl pins would presumably be driven solely by
the HW design of the pin controller and GPIO, and not by the mux
selection in the pin controller (otherwise, I'd argue this isn't a
simple case that should be handled by pinctrl-simple).

As such, I'd expect some properties/table at the top-level of the pin
controller object to describe the GPIO mapping. In turn, that implies
that the individual per-pin mux-selection/configuration nodes don't need
to describe any GPIO-related information.
