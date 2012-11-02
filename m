From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Fri, 02 Nov 2012 20:23:48 +0100
Message-ID: <50941DC4.2050209@gmail.com>
References: <1351794970-14675-1-git-send-email-zonque@gmail.com> <1351794970-14675-5-git-send-email-zonque@gmail.com> <5093A36B.70101@ti.com> <5093AB14.9090402@gmail.com> <50941C6C.3030403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33549 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab2KBTXz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Nov 2012 15:23:55 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1489368bkc.19
        for <linux-omap@vger.kernel.org>; Fri, 02 Nov 2012 12:23:54 -0700 (PDT)
In-Reply-To: <50941C6C.3030403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, robherring2@gmail.com, linux-omap@vger.kernel.org, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com

Hi Jon,

On 02.11.2012 20:18, Jon Hunter wrote:
> On 11/02/2012 06:14 AM, Daniel Mack wrote:
>> Hi Jon,
>>
>> as all comments so far focussed on patch 4/4, could we agree to merge
>> 1-3 of this series already? These are all small and straight-forward
>> things that don't depend on 4/4. That way, I only need to resend the
>> last one under discussion.
> 
> Not sure it makes sense to take 3 without 4.

Ok, no problem. I already submitted v3 :)

>>>>  Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  73 +++++++++++
>>>>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  61 +++++++++
>>>>  arch/arm/mach-omap2/gpmc.c                         | 139 +++++++++++++++++++++
>>>>  3 files changed, 273 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>>>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>>> new file mode 100644
>>>> index 0000000..6f44487
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>>> @@ -0,0 +1,73 @@
>>>> +Device tree bindings for OMAP general purpose memory controllers (GPMC)
>>>> +
>>>> +The actual devices are instantiated from the child nodes of a GPMC node.
>>>> +
>>>> +Required properties:
>>>> +
>>>> + - compatible:		Should be set to "ti,gpmc"
>>>> + - reg:			A resource specifier for the register space
>>>> +			(see the example below)
>>>> + - ti,hwmods:		Should be set to "ti,gpmc" until the DT transition is
>>>> +			completed.
>>>> + - #address-cells:	Must be set to 2 to allow memory address translation
>>>> + - #size-cells:		Must be set to 1 to allow CS address passing
>>>> + - ranges:		Must be set up to reflect the memory layout
>>>> +			Note that this property is not currently parsed.
>>>> +			Calculated values derived from the contents of
>>>> +			GPMC_CS_CONFIG7 as set up by the bootloader. That will
>>>> +			change in the future, so be sure to fill the correct
>>>> +			values here.
>>>
>>> I still think it would be good to add number of chip-selects and
>>> wait-pins here.
>>
>> The number of chip-selects can be derived from the ranges property.
>> Namely, each 4-value entry to this property maps to one chip-select. I
>> can try and make the more clear in the documentation.
> 
> Yes but that only tells you how many you are using. The binding should
> describe the hardware and so should tell us how many chip-selects we
> have. We should get away from using GPMC_CS_NUM in the code.

Maybe I don't get your point, but we only need to care for as many cs
lines as we actually use, right?

> What about wait-pins?

Afaik, their use depends on the driver acting as GPMC client, right?
Could you point me to code that acts conditionally and that should be
reflected in DT?

>>> I am still wondering if the above needs to be mandatory. Or if not then
>>> may be these should be documented as optional and if these a omitted
>>> then what the default configuration would be.
>>
>> In my docs, I referred to Documentation/devicetree/bindings/mtd/nand.txt
>> which states:
>>
>> - nand-ecc-mode : String, operation mode of the NAND ecc mode.
>>   Supported values are: "none", "soft", "hw", "hw_syndrome",
>> "hw_oob_first", "soft_bch".
>> - nand-bus-width : 8 or 16 bus width if not present 8
>>
>> So ecc-mode is mandatory, even though the code currently really defaults
>> to 0 ("none"). nand-bus-width isn't. I don't know if it makes sense to
>> duplicate the Documentation here.
> 
> Well maybe there should be some reference?

Well, it's there already, that what I'm saying :)

Quoting Documentation/devicetree/bindings/mtd/gpmc-nand.txt:

	For NAND specific properties such as ECC modes or bus width,
	please refer to Documentation/devicetree/bindings/mtd/nand.txt


Thanks for your review,

Daniel


