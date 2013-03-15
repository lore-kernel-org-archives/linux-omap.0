From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v2 1/1] gpio: omap: dts: Move interrupt-controller from
 #interrupt-cells description
Date: Fri, 15 Mar 2013 13:56:08 +0100
Message-ID: <51431A68.5090605@ti.com>
References: <1362430597-5855-1-git-send-email-javier.martinez@collabora.co.uk> <CAAwP0s1FynkxpFRK0oC7r2PAOQvxoATfrmU787n4k5PZmvt+XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49752 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221Ab3COM40 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Mar 2013 08:56:26 -0400
In-Reply-To: <CAAwP0s1FynkxpFRK0oC7r2PAOQvxoATfrmU787n4k5PZmvt+XQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Rob Landley <rob@landley.net>, Stephen Warren <swarren@nvidia.com>, Jon Hunter <jon-hunter@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap <linux-omap@vger.kernel.org>

Hi Javier,

On 03/15/2013 01:18 PM, Javier Martinez Canillas wrote:
> On Mon, Mar 4, 2013 at 9:56 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>> The binding documentation for the OMAP GPIO controller has the description
>> for the "#interrupt-cells" property after the "interrupt-controller".
>> This is confusing so is better to move the "interrupt-controller" after
>> "#interrupt-cells" description.

Mmm, your are doing the opposite  :-)

I guess what we do want is that:

    gpio-controller;
    #gpio-cells = <2>;
    interrupt-controller;
    #interrupt-cells = <2>;

So we move "#interrupt-cells" after the "interrupt-controller" description.

>> While being there, change the properties order to be consistent with
>> Documentation/devicetree/bindings/interrupt-controller/interrupts.txt and
>> Documentation/devicetree/bindings/gpio/gpio.txt.
>>
>> Reported-by: Stephen Warren <swarren@nvidia.com>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Acked-by: Jon Hunter <jon-hunter@ti.com>
>> ---
>>
>> Changes since v1:
>>   - Change the properties order to be consistent with the rest of the
>>     DT bindings docs suggested by Jon Hunter.
>>
>>  .../devicetree/bindings/gpio/gpio-omap.txt         |    8 ++++----
>>  1 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>> index bff51a2..a56e3a5 100644
>> --- a/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>> @@ -5,12 +5,12 @@ Required properties:
>>    - "ti,omap2-gpio" for OMAP2 controllers
>>    - "ti,omap3-gpio" for OMAP3 controllers
>>    - "ti,omap4-gpio" for OMAP4 controllers
>> +- gpio-controller : Marks the device node as a GPIO controller.
>>  - #gpio-cells : Should be two.
>>    - first cell is the pin number
>>    - second cell is used to specify optional parameters (unused)
>> -- gpio-controller : Marks the device node as a GPIO controller.
>> +- interrupt-controller: Mark the device node as an interrupt controller.
>>  - #interrupt-cells : Should be 2.
>> -- interrupt-controller: Mark the device node as an interrupt controller
>>    The first cell is the GPIO number.
>>    The second cell is used to specify flags:
>>      bits[3:0] trigger type and level flags:
>> @@ -29,8 +29,8 @@ Example:
>>  gpio4: gpio4 {
>>      compatible = "ti,omap4-gpio";
>>      ti,hwmods = "gpio4";
>> -    #gpio-cells = <2>;
>>      gpio-controller;
>> -    #interrupt-cells = <2>;
>> +    #gpio-cells = <2>;
>>      interrupt-controller;
>> +    #interrupt-cells = <2>;
>>  };
>> --
>> 1.7.7.6
>>
> 
> Hello,
> 
> Any comments on this patch?
> 
> I know is just a trivial documentation fix but I think it can be quite
> helpful for people referring to gpio-omap binding.

I do agree. The patch is good, but the changelog is confusing.

Regards,
Benoit

