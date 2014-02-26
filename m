From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 03/16] Documentation: dt: add OMAP iommu bindings
Date: Wed, 26 Feb 2014 11:02:24 -0600
Message-ID: <530E1E20.9000301@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
	<13151454.2tbkC7YZsi@avalon> <530D210B.3070602@ti.com>
	<1552997.8jd4jgn3Ze@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1552997.8jd4jgn3Ze@avalon>
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

On 02/25/2014 08:13 PM, Laurent Pinchart wrote:
> Hi Suman,
>
> On Tuesday 25 February 2014 17:02:35 Suman Anna wrote:
>> On 02/25/2014 03:26 PM, Laurent Pinchart wrote:
>>> On Thursday 13 February 2014 12:15:34 Suman Anna wrote:
>>>> From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
>>>>
>>>> This patch adds the iommu bindings for all OMAP2+ SoCs. Apart from
>>>> the standard bindings used by OMAP peripherals, this patch uses a
>>>> 'dma-window' (already used by Tegra SMMU) and adds two OMAP custom
>>>> bindings - 'ti,#tlb-entries' and 'ti,iommu-bus-err-back'.
>>>>
>>>> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
>>>> [s-anna-l0cyMroinI0@public.gmane.org: split bindings document, add dra7 and bus error back]
>>>> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
>>>> ---
>>>>
>>>>    .../devicetree/bindings/iommu/ti,omap-iommu.txt    | 28
>>>>    +++++++++++++++++++
>>>>    1 file changed, 28 insertions(+)
>>>>    create mode 100644
>>>>    Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
>>>> b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt new file mode
>>>> 100644
>>>> index 0000000..116492d
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
>>>> @@ -0,0 +1,28 @@
>>>> +OMAP2+ IOMMU
>>>> +
>>>> +Required properties:
>>>> +- compatible : Should be one of,
>>>> +		"ti,omap2-iommu" for OMAP2/OMAP3 IOMMU instances
>>>> +		"ti,omap4-iommu" for OMAP4/OMAP5 IOMMU instances
>>>> +		"ti,dra7-iommu" for DRA7xx IOMMU instances
>>>> +- ti,hwmods  : Name of the hwmod associated with the IOMMU instance
>>>> +- reg        : Address space for the configuration registers
>>>> +- interrupts : Interrupt specifier for the IOMMU instance
>>>> +- dma-window : IOVA start address and length
>>>
>>> Isn't the dma window more of a system configuration property than a
>>> hardware property ? How do you expect it to be set?
>>
>> We are setting it based on the addressable range for the MMU.
>
> A quick look at the ISP and IVA IOMMUs in the OMAP3 shows that both support
> the full 4GB VA space. Why do you need to restrict it ?

I should have rephrased it better when I said addressable range. While 
the MMUs are capable of programming the full 4GB space, there are some 
address ranges that are private from the processor view. This window is 
currently used to set the range for the omap-iovmm driver (which only 
OMAP3 ISP is using atm), and there is no point in allowing the 
omap-iovmm driver the full range when the processor could never 
reach/access those addresses.

>
>> We are reusing the existing defined property and it allows us to get rid of
>> the IOVA start and end addresses defined in the pre-DT OMAP iommu platform
>> data.
>>
>>>> +Optional properties:
>>>> +- ti,#tlb-entries : Number of entries in the translation look-aside
>>>> buffer. +                    Should be either 8 or 32 (default: 32)
>>>> +- ti,iommu-bus-err-back : Indicates the IOMMU instance supports throwing
>>>> +		          back a bus error response on MMU faults.
>>>
>>> Do these features vary per IOMMU instance or per IOMMU model ? In the
>>> latter case they could be inferred from the compatible string by the
>>> driver without requiring them to be explicit in DT (whether you want to
>>> do so is left to you though).
>>
>> Well, these are fixed features given an IOMMU instance, like the OMAP3
>> ISP is the only one that has 8 TLB entries, all the remaining ones have
>> 32, and the IPU iommu instances are the only ones that support the bus
>> error response back. I have no preference to any particular way, and
>> sure the driver can infer these easily based on unique compatible
>> strings per subsystem per SoC. I just happened to go with defining
>> compatible strings per SoC, with the optional properties differentiating
>> the fixed behavior between different IOMMU instances on that SoC. This
>> is where I was looking for some inputs/guidance from the DT bindings
>> maintainers on what is the preferred method.
>
> I think you've made the right choice. I wasn't sure whether those parameters
> varied across IOMMU instances of compatible devices (from a compatible string
> point of view) or were constant. As they vary they should be expressed in DT.

Yeah, I wasn't sure if these qualify as features (as per 
Documentation/devicetree/bindings/ABI.txt section II.2).

regards
Suman

>
>>>> +Example:
>>>> +	/* OMAP3 ISP MMU */
>>>> +	mmu_isp: mmu@480bd400 {
>>>> +		compatible = "ti,omap2-iommu";
>>>> +		reg = <0x480bd400 0x80>;
>>>> +		interrupts = <24>;
>>>> +		ti,hwmods = "mmu_isp";
>>>> +		ti,#tlb-entries = <8>;
>>>> +		dma-window = <0 0xfffff000>;
>>>> +	};
>
