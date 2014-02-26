From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 03/16] Documentation: dt: add OMAP iommu bindings
Date: Wed, 26 Feb 2014 17:14:01 -0600
Message-ID: <530E7539.6040106@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
	<530E682D.9070005@ti.com> <530E6A78.9060503@ti.com>
	<2109933.259zooPLHZ@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2109933.259zooPLHZ@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

 >
> On Wednesday 26 February 2014 16:28:08 Suman Anna wrote:
>> On 02/26/2014 04:18 PM, Suman Anna wrote:
>>> On 02/26/2014 02:36 PM, Laurent Pinchart wrote:
>>>> On Wednesday 26 February 2014 14:23:03 Suman Anna wrote:
>>>>>> On Wednesday 26 February 2014 11:02:24 Suman Anna wrote:
>>>>>>> On 02/25/2014 08:13 PM, Laurent Pinchart wrote:
>>>>>>>> On Tuesday 25 February 2014 17:02:35 Suman Anna wrote:
>>>>>>>>> On 02/25/2014 03:26 PM, Laurent Pinchart wrote:
>>>>>>>>>> On Thursday 13 February 2014 12:15:34 Suman Anna wrote:
>>>>>>>>>>> From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
>>>>>>>>>>>
>>>>>>>>>>> This patch adds the iommu bindings for all OMAP2+ SoCs. Apart from
>>>>>>>>>>> the standard bindings used by OMAP peripherals, this patch uses a
>>>>>>>>>>> 'dma-window' (already used by Tegra SMMU) and adds two OMAP custom
>>>>>>>>>>> bindings - 'ti,#tlb-entries' and 'ti,iommu-bus-err-back'.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
>>>>>>>>>>> [s-anna-l0cyMroinI0@public.gmane.org: split bindings document, add dra7 and bus error
>>>>>>>>>>> back]
>>>>>>>>>>> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
>>>>>>>>>>> ---
>>>>>>>>>>>
>>>>>>>>>>>   .../devicetree/bindings/iommu/ti,omap-iommu.txt    | 28 +++++++++
>>>>>>>>>>>   1 file changed, 28 insertions(+)
>>>>>>>>>>>   create mode 100644
>>>>>>>>>>>   Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
>>>>>>>>>>>
>>>>>>>>>>> diff --git
>>>>>>>>>>> a/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
>>>>>>>>>>> b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt new
>>>>>>>>>>> file
>>>>>>>>>>> mode 100644
>>>>>>>>>>> index 0000000..116492d
>>>>>>>>>>> --- /dev/null
>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
>>>>>>>>>>> @@ -0,0 +1,28 @@
>>>>>>>>>>> +OMAP2+ IOMMU
>>>>>>>>>>> +
>>>>>>>>>>> +Required properties:
>>>>>>>>>>> +- compatible : Should be one of,
>>>>>>>>>>> +        "ti,omap2-iommu" for OMAP2/OMAP3 IOMMU instances
>>>>>>>>>>> +        "ti,omap4-iommu" for OMAP4/OMAP5 IOMMU instances
>>>>>>>>>>> +        "ti,dra7-iommu" for DRA7xx IOMMU instances
>>>>>>>>>>> +- ti,hwmods  : Name of the hwmod associated with the IOMMU
>>>>>>>>>>> instance
>>>>>>>>>>> +- reg        : Address space for the configuration registers
>>>>>>>>>>> +- interrupts : Interrupt specifier for the IOMMU instance
>>>>>>>>>>> +- dma-window : IOVA start address and length
>>>>>>>>>>
>>>>>>>>>> Isn't the dma window more of a system configuration property than a
>>>>>>>>>> hardware property ? How do you expect it to be set?
>>>>>>>>>
>>>>>>>>> We are setting it based on the addressable range for the MMU.
>>>>>>>>
>>>>>>>> A quick look at the ISP and IVA IOMMUs in the OMAP3 shows that both
>>>>>>>> support the full 4GB VA space. Why do you need to restrict it ?
>>>>>>>
>>>>>>> I should have rephrased it better when I said addressable range. While
>>>>>>> the MMUs are capable of programming the full 4GB space, there are some
>>>>>>> address ranges that are private from the processor view. This
>>>>>>> window is currently used to set the range for the omap-iovmm driver
>>>>>>> (which only OMAP3 ISP is using atm), and there is no point in allowing
>>>>>>> the omap-iovmm driver the full range when the processor could never
>>>>>>> reach/access those addresses.
>>>>>>
>>>>>> But the IOMMU VA space is from a device point of view, not from a CPU
>>>>>> point of view. Could you point me to where those private ranges are
>>>>>> documented, in order to understand the problem correctly ?
>>>>>
>>>>> Yes, they are indeed from the device perspective. I meant DSP and/or IPU
>>>>> by processor.
>>>>>
>>>>> For example on OMAP3, you can refer to Table 2-9 in section 2.4.5 "DSP
>>>>> Subsystem Memory Space Mapping" of the OMAP36xx TRM, and the external
>>>>> addressable range starts from 0x11000000.
>>>>
>>>> OK, so it looks more like a property of the IOMMU master than a
>>>> property of the IOMMU itself. It would be better to express it as such,
>>>> but I wonder how that could be done, and if it would be worth it in this
>>>> case.
>>>
>>> This property is currently solely used to configure the range for the
>>> omap-iovmm module, which were supplied through platform data in the
>>> non-DT case.
>
> If I'm not mistaken omap-iovmm is something we want to get rid of. I know that
> the OMAP3 ISP driver is the only user of that module, and I've started working
> on fixing that, but I'm currently lacking time to complete the work.
>
> Now, if we get rid of omap-iovmm, does that mean that the dma-window property
> won't need to be specified anymore ? If so, given that the only omap-iovmm
> user is the OMAP3 ISP driver, I would propose to drop the property and just
> hardcode the value.

Yeah, none of our OMAP4+ stacks use omap-iovmm, or similar dynamic 
reservation scheme at the moment. I am perfectly fine with dropping the 
property and hard-coding it in the driver with a note. DSP/Bridge has a 
similar usage (in dmm.c), but that code is localized within the driver.

Thanks for all the comments.

regards
Suman


>
> Please let me know if there's something I've missed.


>
>>> I am wondering if the way to go here is to use iommu_domain_set_attr() and
>>> use the domain geometry values.
>>
>> The other option is to supply these as driver match data, and switching
>> the compatible strings to identify the MMU instance precisely.
>>
>> regards
>> Suman
>>
>>>> As not all masters (the OMAP3 ISP doesn't for instance) have restrictions
>>>> regarding the VA range they can address, should this property be at
>>>> least made
>>>> optional ?
>>>>
>>>>>>>>> We are reusing the existing defined property and it allows us to get
>>>>>>>>> rid of the IOVA start and end addresses defined in the pre-DT OMAP
>>>>>>>>> iommu platform data.
>
> [snip]
>
