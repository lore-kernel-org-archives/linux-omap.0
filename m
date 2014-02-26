From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCHv2 03/16] Documentation: dt: add OMAP iommu bindings
Date: Wed, 26 Feb 2014 21:36:19 +0100
Message-ID: <1825184.Z7lGjn3qsj@avalon>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com> <8258385.uITvkIdEvn@avalon> <530E4D27.4010205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:45875 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbaBZUfA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Feb 2014 15:35:00 -0500
In-Reply-To: <530E4D27.4010205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>, Florian Vaussard <florian.vaussard@epfl.ch>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>

Hi Suman,

On Wednesday 26 February 2014 14:23:03 Suman Anna wrote:
> > On Wednesday 26 February 2014 11:02:24 Suman Anna wrote:
> >> On 02/25/2014 08:13 PM, Laurent Pinchart wrote:
> >>> On Tuesday 25 February 2014 17:02:35 Suman Anna wrote:
> >>>> On 02/25/2014 03:26 PM, Laurent Pinchart wrote:
> >>>>> On Thursday 13 February 2014 12:15:34 Suman Anna wrote:
> >>>>>> From: Florian Vaussard <florian.vaussard@epfl.ch>
> >>>>>> 
> >>>>>> This patch adds the iommu bindings for all OMAP2+ SoCs. Apart from
> >>>>>> the standard bindings used by OMAP peripherals, this patch uses a
> >>>>>> 'dma-window' (already used by Tegra SMMU) and adds two OMAP custom
> >>>>>> bindings - 'ti,#tlb-entries' and 'ti,iommu-bus-err-back'.
> >>>>>> 
> >>>>>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> >>>>>> [s-anna@ti.com: split bindings document, add dra7 and bus error back]
> >>>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
> >>>>>> ---
> >>>>>> 
> >>>>>>  .../devicetree/bindings/iommu/ti,omap-iommu.txt    | 28 ++++++++++++
> >>>>>>  1 file changed, 28 insertions(+) 
> >>>>>>  create mode 100644
> >>>>>>  Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
> >>>>>> 
> >>>>>> diff --git
> >>>>>> a/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
> >>>>>> b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt new file
> >>>>>> mode 100644
> >>>>>> index 0000000..116492d
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
> >>>>>> @@ -0,0 +1,28 @@
> >>>>>> +OMAP2+ IOMMU
> >>>>>> +
> >>>>>> +Required properties:
> >>>>>> +- compatible : Should be one of,
> >>>>>> +		"ti,omap2-iommu" for OMAP2/OMAP3 IOMMU instances
> >>>>>> +		"ti,omap4-iommu" for OMAP4/OMAP5 IOMMU instances
> >>>>>> +		"ti,dra7-iommu" for DRA7xx IOMMU instances
> >>>>>> +- ti,hwmods  : Name of the hwmod associated with the IOMMU instance
> >>>>>> +- reg        : Address space for the configuration registers
> >>>>>> +- interrupts : Interrupt specifier for the IOMMU instance
> >>>>>> +- dma-window : IOVA start address and length
> >>>>> 
> >>>>> Isn't the dma window more of a system configuration property than a
> >>>>> hardware property ? How do you expect it to be set?
> >>>> 
> >>>> We are setting it based on the addressable range for the MMU.
> >>> 
> >>> A quick look at the ISP and IVA IOMMUs in the OMAP3 shows that both
> >>> support the full 4GB VA space. Why do you need to restrict it ?
> >> 
> >> I should have rephrased it better when I said addressable range. While
> >> the MMUs are capable of programming the full 4GB space, there are some
> >> address ranges that are private from the processor view. This window is
> >> currently used to set the range for the omap-iovmm driver (which only
> >> OMAP3 ISP is using atm), and there is no point in allowing the
> >> omap-iovmm driver the full range when the processor could never
> >> reach/access those addresses.
> > 
> > But the IOMMU VA space is from a device point of view, not from a CPU
> > point of view. Could you point me to where those private ranges are
> > documented, in order to understand the problem correctly ?
> 
> Yes, they are indeed from the device perspective. I meant DSP and/or IPU
> by processor.
> 
> For example on OMAP3, you can refer to Table 2-9 in section 2.4.5 "DSP
> Subsystem Memory Space Mapping" of the OMAP36xx TRM, and the external
> addressable range starts from 0x11000000.

OK, so it looks more like a property of the IOMMU master than a property of 
the IOMMU itself. It would be better to express it as such, but I wonder how 
that could be done, and if it would be worth it in this case.

As not all masters (the OMAP3 ISP doesn't for instance) have restrictions 
regarding the VA range they can address, should this property be at least made 
optional ?

> >>>> We are reusing the existing defined property and it allows us to get
> >>>> rid of the IOVA start and end addresses defined in the pre-DT OMAP
> >>>> iommu platform data.
> >>>> 
> >>>>>> +Optional properties:
> >>>>>> +- ti,#tlb-entries : Number of entries in the translation look-aside
> >>>>>> buffer. +                    Should be either 8 or 32 (default: 32)
> >>>>>> +- ti,iommu-bus-err-back : Indicates the IOMMU instance supports
> >>>>>> throwing
> >>>>>> +		          back a bus error response on MMU faults.
> >>>>> 
> >>>>> Do these features vary per IOMMU instance or per IOMMU model ? In the
> >>>>> latter case they could be inferred from the compatible string by the
> >>>>> driver without requiring them to be explicit in DT (whether you want
> >>>>> to do so is left to you though).
> >>>> 
> >>>> Well, these are fixed features given an IOMMU instance, like the OMAP3
> >>>> ISP is the only one that has 8 TLB entries, all the remaining ones have
> >>>> 32, and the IPU iommu instances are the only ones that support the bus
> >>>> error response back. I have no preference to any particular way, and
> >>>> sure the driver can infer these easily based on unique compatible
> >>>> strings per subsystem per SoC. I just happened to go with defining
> >>>> compatible strings per SoC, with the optional properties
> >>>> differentiating the fixed behavior between different IOMMU instances on
> >>>> that SoC. This is where I was looking for some inputs/guidance from the
> >>>> DT bindings maintainers on what is the preferred method.
> >>> 
> >>> I think you've made the right choice. I wasn't sure whether those
> >>> parameters varied across IOMMU instances of compatible devices (from a
> >>> compatible string point of view) or were constant. As they vary they
> >>> should be expressed in DT.
> >> 
> >> Yeah, I wasn't sure if these qualify as features (as per
> >> Documentation/devicetree/bindings/ABI.txt section II.2).
> >> 
> >> regards
> >> Suman
> >> 
> >>>>>> +Example:
> >>>>>> +	/* OMAP3 ISP MMU */
> >>>>>> +	mmu_isp: mmu@480bd400 {
> >>>>>> +		compatible = "ti,omap2-iommu";
> >>>>>> +		reg = <0x480bd400 0x80>;
> >>>>>> +		interrupts = <24>;
> >>>>>> +		ti,hwmods = "mmu_isp";
> >>>>>> +		ti,#tlb-entries = <8>;
> >>>>>> +		dma-window = <0 0xfffff000>;
> >>>>>> +	};

-- 
Regards,

Laurent Pinchart

