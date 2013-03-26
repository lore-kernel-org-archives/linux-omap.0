From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v3 1/1] gpio: omap: dts: Move interrupt-controller from
 #interrupt-cells description
Date: Tue, 26 Mar 2013 15:29:13 +0100
Message-ID: <5151B0B9.7090308@ti.com>
References: <1363354317-14985-1-git-send-email-javier.martinez@collabora.co.uk> <CAAwP0s3PqsCF6TsMe6-aD9LKAOfQ=ToSXDXnnu5MvN01x3b5cw@mail.gmail.com> <5151AC59.5060802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58700 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759793Ab3CZO3s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 10:29:48 -0400
In-Reply-To: <5151AC59.5060802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Stephen Warren <swarren@nvidia.com>, Jon Hunter <jon-hunter@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap <linux-omap@vger.kernel.org>

On 03/26/2013 03:10 PM, Benoit Cousson wrote:
> Hi Javier,
> 
> On 03/26/2013 10:33 AM, Javier Martinez Canillas wrote:
>> On Fri, Mar 15, 2013 at 2:31 PM, Javier Martinez Canillas
>> <javier.martinez@collabora.co.uk> wrote:
>>> The binding documentation for the OMAP GPIO controller has the
>>> "#interrupt-cells" property listed before "#interrupt-controller"
>>> property but its description after.
>>> This is confusing so we move "#interrupt-cells" after the
>>> "interrupt-controller" property so is followed by its description.
>>>
>>> While being there, change the properties order to be consistent with
>>> Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>> and Documentation/devicetree/bindings/gpio/gpio.txt.
>>>
>>> According with these docs, the order of the properties for a gpio-omap
>>> device node should be:
>>>
>>>     gpio-controller;
>>>     #gpio-cells = <2>;
>>>     interrupt-controller;
>>>     #interrupt-cells = <2>;
>>>
>>> Reported-by: Stephen Warren <swarren@nvidia.com>
>>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>> Acked-by: Jon Hunter <jon-hunter@ti.com>
>>> ---
>>>
>>> Changes since v1:
>>>   - Change the properties order to be consistent with the rest of the
>>>     DT bindings docs suggested by Jon Hunter.
>>>
>>> Changes since v2:
>>>   - Fix changelog that explained the opposite of what the patch was doing as
>>>     suggested by Benoit Cousson.
>>>
>>>  .../devicetree/bindings/gpio/gpio-omap.txt         |    8 ++++----
>>>  1 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>> index bff51a2..a56e3a5 100644
>>> --- a/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>> +++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>> @@ -5,12 +5,12 @@ Required properties:
>>>    - "ti,omap2-gpio" for OMAP2 controllers
>>>    - "ti,omap3-gpio" for OMAP3 controllers
>>>    - "ti,omap4-gpio" for OMAP4 controllers
>>> +- gpio-controller : Marks the device node as a GPIO controller.
>>>  - #gpio-cells : Should be two.
>>>    - first cell is the pin number
>>>    - second cell is used to specify optional parameters (unused)
>>> -- gpio-controller : Marks the device node as a GPIO controller.
>>> +- interrupt-controller: Mark the device node as an interrupt controller.
>>>  - #interrupt-cells : Should be 2.
>>> -- interrupt-controller: Mark the device node as an interrupt controller
>>>    The first cell is the GPIO number.
>>>    The second cell is used to specify flags:
>>>      bits[3:0] trigger type and level flags:
>>> @@ -29,8 +29,8 @@ Example:
>>>  gpio4: gpio4 {
>>>      compatible = "ti,omap4-gpio";
>>>      ti,hwmods = "gpio4";
>>> -    #gpio-cells = <2>;
>>>      gpio-controller;
>>> -    #interrupt-cells = <2>;
>>> +    #gpio-cells = <2>;
>>>      interrupt-controller;
>>> +    #interrupt-cells = <2>;
>>>  };
>>> --
>>> 1.7.7.6
>>>
>>
>> Hello,
>>
>> any comments on this patch?
> 
> That's perfect. I've just applied it in my branch.

OK, in fact it is almost perfect :-)

The patch modified the documentation and not the driver itself, so I modified the subject to reflect that accurately.

Documentation: dt: gpio-omap: Move interrupt-controller from #interrupt-cell

Regards,
Benoit


