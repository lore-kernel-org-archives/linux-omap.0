From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Fri, 2 Nov 2012 14:57:04 -0500
Message-ID: <50942590.5010202@ti.com>
References: <1351794970-14675-1-git-send-email-zonque@gmail.com> <1351794970-14675-5-git-send-email-zonque@gmail.com> <5093A36B.70101@ti.com> <5093AB14.9090402@gmail.com> <50941C6C.3030403@ti.com> <50941DC4.2050209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40008 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237Ab2KBT5Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 15:57:16 -0400
In-Reply-To: <50941DC4.2050209@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, robherring2@gmail.com, linux-omap@vger.kernel.org, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com


On 11/02/2012 02:23 PM, Daniel Mack wrote:
> Hi Jon,
> 
> On 02.11.2012 20:18, Jon Hunter wrote:
>> On 11/02/2012 06:14 AM, Daniel Mack wrote:
>>> Hi Jon,
>>>
>>> as all comments so far focussed on patch 4/4, could we agree to merge
>>> 1-3 of this series already? These are all small and straight-forward
>>> things that don't depend on 4/4. That way, I only need to resend the
>>> last one under discussion.
>>
>> Not sure it makes sense to take 3 without 4.
> 
> Ok, no problem. I already submitted v3 :)
> 
>>>>>  Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  73 +++++++++++
>>>>>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  61 +++++++++
>>>>>  arch/arm/mach-omap2/gpmc.c                         | 139 +++++++++++++++++++++
>>>>>  3 files changed, 273 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>>>>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>>>> new file mode 100644
>>>>> index 0000000..6f44487
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>>>> @@ -0,0 +1,73 @@
>>>>> +Device tree bindings for OMAP general purpose memory controllers (GPMC)
>>>>> +
>>>>> +The actual devices are instantiated from the child nodes of a GPMC node.
>>>>> +
>>>>> +Required properties:
>>>>> +
>>>>> + - compatible:		Should be set to "ti,gpmc"
>>>>> + - reg:			A resource specifier for the register space
>>>>> +			(see the example below)
>>>>> + - ti,hwmods:		Should be set to "ti,gpmc" until the DT transition is
>>>>> +			completed.
>>>>> + - #address-cells:	Must be set to 2 to allow memory address translation
>>>>> + - #size-cells:		Must be set to 1 to allow CS address passing
>>>>> + - ranges:		Must be set up to reflect the memory layout
>>>>> +			Note that this property is not currently parsed.
>>>>> +			Calculated values derived from the contents of
>>>>> +			GPMC_CS_CONFIG7 as set up by the bootloader. That will
>>>>> +			change in the future, so be sure to fill the correct
>>>>> +			values here.
>>>>
>>>> I still think it would be good to add number of chip-selects and
>>>> wait-pins here.
>>>
>>> The number of chip-selects can be derived from the ranges property.
>>> Namely, each 4-value entry to this property maps to one chip-select. I
>>> can try and make the more clear in the documentation.
>>
>> Yes but that only tells you how many you are using. The binding should
>> describe the hardware and so should tell us how many chip-selects we
>> have. We should get away from using GPMC_CS_NUM in the code.
> 
> Maybe I don't get your point, but we only need to care for as many cs
> lines as we actually use, right?

But how many does your device have? How many clients can you support?

If we know how many the device has and then we can get rid of "#define
GPMC_CS_NUM". We currently allocate the CS by calling gpmc_cs_request().
Hmmm ... I now see that your patch is not calling this before
configuring the CS and so that needs to be fixed too.

Without knowing the total CS available, how do we ensure we have the CS
available that someone is asking for?

>> What about wait-pins?
> 
> Afaik, their use depends on the driver acting as GPMC client, right?
> Could you point me to code that acts conditionally and that should be
> reflected in DT?

Again we need to know how many the device has. Clients may or may not
use these. However, if a client wants one they need to request one which
is just like a chip-select. This is not in the current driver but Afzal
has a patch for this [1].

Bottom line, for such hardware specific features, device tree is a good
place to describe how many resources we have. Then we can eliminate such
#defines from the driver code.

>>>> I am still wondering if the above needs to be mandatory. Or if not then
>>>> may be these should be documented as optional and if these a omitted
>>>> then what the default configuration would be.
>>>
>>> In my docs, I referred to Documentation/devicetree/bindings/mtd/nand.txt
>>> which states:
>>>
>>> - nand-ecc-mode : String, operation mode of the NAND ecc mode.
>>>   Supported values are: "none", "soft", "hw", "hw_syndrome",
>>> "hw_oob_first", "soft_bch".
>>> - nand-bus-width : 8 or 16 bus width if not present 8
>>>
>>> So ecc-mode is mandatory, even though the code currently really defaults
>>> to 0 ("none"). nand-bus-width isn't. I don't know if it makes sense to
>>> duplicate the Documentation here.
>>
>> Well maybe there should be some reference?
> 
> Well, it's there already, that what I'm saying :)
> 
> Quoting Documentation/devicetree/bindings/mtd/gpmc-nand.txt:
> 
> 	For NAND specific properties such as ECC modes or bus width,
> 	please refer to Documentation/devicetree/bindings/mtd/nand.txt

Ok, thanks I see that now. Looking at other bindings, some also include
these details but not all. Could be worth listing ecc-mode under
mandatory and bus-width under optional with a reference to nand.txt
binding. I don't think it is worth duplicating but listing the actual
property names would be nice.

Cheers
Jon

[1]
http://gitorious.org/x0148406-public/linux-kernel/commit/f7cbee399ece42e64f9ad2205171c3c67c3f1a9e/diffs
