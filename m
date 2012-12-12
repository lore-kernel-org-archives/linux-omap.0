From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v7 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Wed, 12 Dec 2012 10:13:42 +0100
Message-ID: <50C84AC6.5030307@gmail.com>
References: <1354734571-10774-1-git-send-email-zonque@gmail.com> <1354734571-10774-6-git-send-email-zonque@gmail.com> <20121205222232.67B2B3E0E22@localhost> <50BFCBCC.6030706@ti.com> <20121205232426.BAD573E0E22@localhost> <50C0C5AB.3030201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52037 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab2LLJNw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Dec 2012 04:13:52 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so177307bkw.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Dec 2012 01:13:50 -0800 (PST)
In-Reply-To: <50C0C5AB.3030201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, paul@pwsan.com, x0148406@ti.com, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, rob.herring@calxeda.com, tony@atomide.com, jacmet@sunsite.dk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 06.12.2012 17:19, Jon Hunter wrote:
> 
> On 12/05/2012 05:24 PM, Grant Likely wrote:
>> On Wed, 5 Dec 2012 16:33:48 -0600, Jon Hunter <jon-hunter@ti.com> wrote:
>>> Hi Grant,
>>>
>>> On 12/05/2012 04:22 PM, Grant Likely wrote:
>>>> On Wed,  5 Dec 2012 20:09:31 +0100, Daniel Mack <zonque@gmail.com> wrote:
>>>>> This patch adds basic DT bindings for OMAP GPMC.
>>>>>
>>>>> The actual peripherals are instantiated from child nodes within the GPMC
>>>>> node, and the only type of device that is currently supported is NAND.
>>>>>
>>>>> Code was added to parse the generic GPMC timing parameters and some
>>>>> documentation with examples on how to use them.
>>>>>
>>>>> Successfully tested on an AM33xx board.
>>>>>
>>>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  77 ++++++++++
>>>>>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  76 +++++++++
>>>>>  arch/arm/mach-omap2/gpmc.c                         | 171 ++++++++++++++++++++-
>>>>>  3 files changed, 323 insertions(+), 1 deletion(-)
>>>>>  create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>>>>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>>>> new file mode 100644
>>>>> index 0000000..7d2a645
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>>>> @@ -0,0 +1,77 @@
>>>>> +Device tree bindings for OMAP general purpose memory controllers (GPMC)
>>>>> +
>>>>> +The actual devices are instantiated from the child nodes of a GPMC node.
>>>>> +
>>>>> +Required properties:
>>>>> +
>>>>> + - compatible:		Should be set to "ti,gpmc"
>>>>
>>>> Please, be specific. Use something like "ti,am3340-gpmc" or
>>>> "ti,omap3430-gpmc". The compatible property is a list so that new
>>>> devices can claim compatibility with old. Compatible strings that are
>>>> overly generic are a pet-peave of mine.
>>>
>>> We aim to use the binding for omap2,3,4,5 as well as the am33xx devices
>>> (which are omap based). Would it be sufficient to have "ti,omap2-gpmc"
>>> implying all omap2+ based devices or should we have a compatible string
>>> for each device supported?
>>
>> Are they each register-level compatible with one another?
> 
> They are not 100% register compatible. There are a couple fields in the
> binding that are only applicable to OMAP3+ devices.
> 
>> The general recommended approach here is to make subsequent silicon
>> claim compatibility with the first compatible implementation.
>>
>> So, for an am3358 board:
>> 	compatible = "ti,am3358-gpmc", "ti,omap2420-gpmc";
>>
>> Essentially, what this means is that "ti,omap2420-gpmc" is the generic
>> value instead of "omap2-gpmc". The reason for this is so that the value
>> is anchored against a specific implementation, and not against something
>> completely imaginary or idealized. If a newer version isn't quite
>> compatible with the omap2420-gpmc, then it can drop the compatible claim
>> and the driver really should be told about the new device.
> 
> Ok, gotcha! I will do a register comparison and may be recommend to
> Daniel which compatible strings we will need.

Any idea yet how we want to continue on this? I'm asking because I'm
leaving for a longer trip by the end of this week, and so anything I
haven't finished until then will have to be postponed until February or
be taken over by someone else :)

Thanks,
Daniel

