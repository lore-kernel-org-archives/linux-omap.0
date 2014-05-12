From: Suman Anna <s-anna@ti.com>
Subject: Re: [RFC] [v2 Patch 2/6] ARM: TI: Describe the ti reset DT entries
Date: Mon, 12 May 2014 13:46:15 -0500
Message-ID: <537116F7.5070403@ti.com>
References: <1399320567-3639-1-git-send-email-dmurphy@ti.com> <1399320567-3639-3-git-send-email-dmurphy@ti.com> <20140505220155.GI25949@atomide.com> <5368E12D.1060706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36889 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153AbaELSqk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 14:46:40 -0400
In-Reply-To: <5368E12D.1060706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Murphy, Dan" <dmurphy@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Dan,

On 05/06/2014 08:18 AM, Murphy, Dan wrote:
> Tony
> 
> Thanks for the comments
> 
> On 05/05/2014 05:01 PM, Tony Lindgren wrote:
>> * Dan Murphy <dmurphy@ti.com> [140505 13:10]:
>>> +
>>> +Required parent properties:
>>> +- compatible : Should be one of,
>>> +		"ti,omap4-prm" for OMAP4 PRM instances
>>> +		"ti,omap5-prm" for OMAP5 PRM instances
>>> +		"ti,dra7-prm" for DRA7xx PRM instances
>>> +		"ti,am4-prcm" for AM43xx PRCM instances
>>> +		"ti,am3-prcm" for AM33xx PRCM instances
>>> +
>>> +Required child reset property:
>>> +- compatible : Should be
>>> +		"resets" for All TI SoCs
>>> +
>>> +example:
>>> +		prm: prm@4ae06000 {
>>> +			compatible = "ti,omap5-prm";
>>> +			reg = <0x4ae06000 0x3000>;
>>> +
>>> +			prm_resets: resets {
>>> +				#address-cells = <1>;
>>> +				#size-cells = <1>;
>>> +				#reset-cells = <1>;
>>> +			};
>>> +		};
>> The reg entries you have in the example below has different format
>> compared to this?

Right, the #size-cells should have been 0, or each reg field updated
with an additional field value of 4 as the registers are all of constant
width - 4 bytes.

> 
> This is the parent to the resets.  The reg entries below are for
> the child reset signals.
> 
>>
>>> +Reset node declaration
>>> +==============================================
>>> +The reset node is declared in a parent child relationship.  The main parent
>>> +is the PRCM module which contains the base address.  The first child within
>>> +the reset parent declares the target modules reset name.  This is followed by
>>> +the control and status offsets.
>>> +
>>> +Within the first reset child node is a secondary child node which declares the
>>> +reset signal of interest.  Under this node the control and status bits
>>> +are declared.  These bits declare the bit mask for the target reset.
>>> +
>>> +
>>> +Required properties:
>>> +reg - This is the register offset from the PRCM parent.
>>> +	This must be declared as:
>>> +
>>> +	reg = <control register offset>,
>>> +		  <status register offset>;
>>> +
>>> +control-bit - This is the bit within the register which controls the reset
>>> +	of the target module.  This is declared as a bit mask for the register.
>>> +status-bit - This is the bit within the register which contains the status of
>>> +	the reset of the target module.
>>> +	This is declared as a bit mask for the register.
>>> +
>>> +example:
>>> +&prm_resets {
>>> +	dsp_rstctrl {
>>> +		reg = <0x1c00>,
>>> +			  <0x1c04>;
>> Shouldn't this be start and size instead of start and end here?

These are two registers - one for control and one for status.

> 
> I could do start and size.  But the size will be the same for each register.
> AM33xx really hurts the consistency model here as the other patches in the series
> it appears that the control and status are consistent but AM33xx the registers are all over
> the place.
> 
> I have not looked at OMAP2->4 yet for control and status register offsets.
> 
>>> +		dsp_reset: dsp_reset {
>>> +			control-bit = <0x01>;
>>> +			status-bit = <0x01>;
>>> +		};
>>> +	};
>>> +};
>> Are the control-bit and status-bit always the same? If so, you can
>> keep that knowlede private to the the driver.
> 
> No there is a case in the am33xx resets file where the status and control bits are not the same.

Do we really need two separate properties to represent this, as these
are essentially the relevant bits in the corresponding reg elements.
I guess this is somewhat same as Tony's suggestion about using the reg
field for these sub-nodes, in which case, you would have to add another
#address-cells as 1 for each of the child reset nodes.

regards
Suman

> 
>>
>> And maybe you can have the bit offset in a reg property here to
>> avoid adding any custom properties? Something like:
>>
>> 	dsp_reset: reset@1 {
>> 		reg = 1;
>> 	};
>>
>> If reg is not suitable for that, it seems that some generic property
>> to describe the bit offset is needed by quite a few drivers
>> anyways, for things like clocks and regulators.
> 
> I will have to look into this.  Maybe a generic entry called bit-offset
> that defines the bit or a mask for the registers.  It can mimic the reg
> entry.
> 
>>> +Client Node Declaration
>>> +==============================================
>>> +This is the consumer of the parent node to declare what resets this
>>> +particular module is interested in.
>>> +
>>> +example:
>>> +	src: src@55082000 {
>>> +		    resets = <&reset_src phandle>;
>>> +			reset-names = "<reset_name>";
>>> +	};
>>> +
>>> +Required Properties:
>>> +reset_src - This is the parent DT entry for the reset controller
>>> +phandle - This is the phandle of the specific reset to be used by the clien
>>> +	driver.
>>> +reset-names - This is the reset name of module that the device driver
>>> +	needs to be able to reset.  This value must correspond to a value within
>>> +	the reset controller array.
>>> +
>>> +example:
>>> +resets = <&prm_resets &dsp_mmu_reset>;
>>> +reset-names = "dsp_mmu_reset";
>> This part looks OK to me, not sure if we need the reset-names property
>> if we have one already why not.
> 
> reset-names are part of the reset.txt file.  I could probably drop the resets and reset-name information here
> and point to the reset.txt file for further explanation.
> 
>>
>> Regards,
>>
>> Tony
> 
> 

