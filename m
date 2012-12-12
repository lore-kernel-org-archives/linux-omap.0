From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Wed, 12 Dec 2012 17:02:10 -0600
Message-ID: <50C90CF2.1090405@ti.com>
References: <1354734571-10774-1-git-send-email-zonque@gmail.com>
 <1354734571-10774-6-git-send-email-zonque@gmail.com>
 <20121205222232.67B2B3E0E22@localhost> <50BFCBCC.6030706@ti.com>
 <20121205232426.BAD573E0E22@localhost> <50C0C5AB.3030201@ti.com>
 <50C84AC6.5030307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50C84AC6.5030307-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: x0148406-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On 12/12/2012 03:13 AM, Daniel Mack wrote:
> On 06.12.2012 17:19, Jon Hunter wrote:
>>
>> On 12/05/2012 05:24 PM, Grant Likely wrote:
>>> On Wed, 5 Dec 2012 16:33:48 -0600, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org> wrote:
>>>> Hi Grant,
>>>>
>>>> On 12/05/2012 04:22 PM, Grant Likely wrote:
>>>>> On Wed,  5 Dec 2012 20:09:31 +0100, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>>> This patch adds basic DT bindings for OMAP GPMC.
>>>>>>
>>>>>> The actual peripherals are instantiated from child nodes within the GPMC
>>>>>> node, and the only type of device that is currently supported is NAND.
>>>>>>
>>>>>> Code was added to parse the generic GPMC timing parameters and some
>>>>>> documentation with examples on how to use them.
>>>>>>
>>>>>> Successfully tested on an AM33xx board.
>>>>>>
>>>>>> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  77 ++++++++++
>>>>>>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  76 +++++++++
>>>>>>  arch/arm/mach-omap2/gpmc.c                         | 171 ++++++++++++++++++++-
>>>>>>  3 files changed, 323 insertions(+), 1 deletion(-)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>>>>>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>>>>> new file mode 100644
>>>>>> index 0000000..7d2a645
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>>>>> @@ -0,0 +1,77 @@
>>>>>> +Device tree bindings for OMAP general purpose memory controllers (GPMC)
>>>>>> +
>>>>>> +The actual devices are instantiated from the child nodes of a GPMC node.
>>>>>> +
>>>>>> +Required properties:
>>>>>> +
>>>>>> + - compatible:		Should be set to "ti,gpmc"
>>>>>
>>>>> Please, be specific. Use something like "ti,am3340-gpmc" or
>>>>> "ti,omap3430-gpmc". The compatible property is a list so that new
>>>>> devices can claim compatibility with old. Compatible strings that are
>>>>> overly generic are a pet-peave of mine.
>>>>
>>>> We aim to use the binding for omap2,3,4,5 as well as the am33xx devices
>>>> (which are omap based). Would it be sufficient to have "ti,omap2-gpmc"
>>>> implying all omap2+ based devices or should we have a compatible string
>>>> for each device supported?
>>>
>>> Are they each register-level compatible with one another?
>>
>> They are not 100% register compatible. There are a couple fields in the
>> binding that are only applicable to OMAP3+ devices.
>>
>>> The general recommended approach here is to make subsequent silicon
>>> claim compatibility with the first compatible implementation.
>>>
>>> So, for an am3358 board:
>>> 	compatible = "ti,am3358-gpmc", "ti,omap2420-gpmc";
>>>
>>> Essentially, what this means is that "ti,omap2420-gpmc" is the generic
>>> value instead of "omap2-gpmc". The reason for this is so that the value
>>> is anchored against a specific implementation, and not against something
>>> completely imaginary or idealized. If a newer version isn't quite
>>> compatible with the omap2420-gpmc, then it can drop the compatible claim
>>> and the driver really should be told about the new device.
>>
>> Ok, gotcha! I will do a register comparison and may be recommend to
>> Daniel which compatible strings we will need.
> 
> Any idea yet how we want to continue on this? I'm asking because I'm
> leaving for a longer trip by the end of this week, and so anything I
> haven't finished until then will have to be postponed until February or
> be taken over by someone else :)

Thanks for the reminder!

So looking at this today, here is what I see when comparing the
registers ...

omap2430 != omap2420
omap3430 != omap2430
omap3630 == omap3430
omap4430 != omap3430
omap4460 == omap4430
omap543x == omap4430
am335x != omap4430

Therefore, I believe that we need to have the following compatible
strings ...

ti,omap2420-gpmc
ti,omap2430-gpmc
ti,omap3430-gpmc (omap3430 & omap3630)
ti,omap4430-gpmc (omap4430 & omap4460 & omap543x)
ti,am3352-gpmc (am335x devices)

Probably worth adding a comment to the Documentation what should be used
for which device.

Cheers
Jon
