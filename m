From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/6] ARM: OMAP4: hwmod data: add mmu hwmod for ipu and
 dsp
Date: Tue, 19 Jun 2012 19:48:07 +0200
Message-ID: <4FE0BB57.3080403@ti.com>
References: <1339811764-5337-1-git-send-email-omar.luna@linaro.org> <1339811764-5337-4-git-send-email-omar.luna@linaro.org> <4FE07268.7040606@ti.com> <CALLhW=67d7=4Jx1T4Kn5ddNz7vQ5YeN4AzuOuXrW1_UGYwpG2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43320 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715Ab2FSRs1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jun 2012 13:48:27 -0400
In-Reply-To: <CALLhW=67d7=4Jx1T4Kn5ddNz7vQ5YeN4AzuOuXrW1_UGYwpG2A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>, Joerg Roedel <joerg.roedel@amd.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org

On 6/19/2012 6:39 PM, Omar Ramirez Luna wrote:
> Hi Benoit,
>
> On 19 June 2012 07:36, Cousson, Benoit <b-cousson@ti.com> wrote:
>> On 6/16/2012 3:56 AM, Omar Ramirez Luna wrote:
> ...
>>> +static struct omap_hwmod omap44xx_ipu_mmu_hwmod = {
>>> +     .name           = "ipu_mmu",
>>> +     .class          = &omap44xx_mmu_hwmod_class,
>>> +     .clkdm_name     = "ducati_clkdm",
>>> +     .mpu_irqs       = omap44xx_ipu_mmu_irqs,
>>> +     .rst_lines      = omap44xx_ipu_mmu_resets,
>>> +     .rst_lines_cnt  = ARRAY_SIZE(omap44xx_ipu_mmu_resets),
>>> +     .main_clk       = "ipu_fck",
>>> +     .prcm = {
>>> +             .omap4 = {
>>> +                     .clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
>>> +                     .rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
>>> +                     .context_offs = OMAP4_RM_DUCATI_DUCATI_CONTEXT_OFFSET,
>>> +                     .modulemode   = MODULEMODE_HWCTRL,
>>> +             },
>>> +     },
>>> +     .dev_attr       = &ipu_mmu_dev_attr,
>>> +};
>>
>> In fact, the MMU_IPU hwmod is now almost the same one than the previous IPU one...
>> If we do that we should maybe just rename the IPU -> MMU_IPU and DSP -> MMU_DSP.
>>
>> But by doing that we will assume that the MMU does represent the subsystem, which is not necessarily super nice.
>>
>> I guess that a much better representation will be to keep the subsystem (IPU) to handle the PRCM part:
>>
>> +       .main_clk       = "ipu_fck",
>> +       .prcm = {
>> +               .clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
>> +               .rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
>> +               .context_offs = OMAP4_RM_DUCATI_DUCATI_CONTEXT_OFFSET,
>> +               .modulemode   = MODULEMODE_HWCTRL,
>>
>> And then the MMU_IPU will handle the configuration registers part and the reset + irq.
>>
>> But then, you will have to create a parent child dependency between your devices to ensure that the IPU subsystem device will be enabled before trying to access the MMU_IPU.
>>
>> This is what the DSS is about to do to handle the same kind of power dependency. The DSS device is the parent of all the DSS IPs (DISPC, HDMI...) and thus pm_runtime will ensure that the parent is enabled before trying to enable the children.
>>
>> In term of DT, just to illustrate the situation, it will be something like that:
>>
>> ipu {
>>         compatible = "simple-bus";
>>         ti,hwmods = "ipu";
>>
>>         ipu_mmu: mmu@4a066000 {
>>                 compatible = "omap-mmu";
>>                 ti,hwmods = "mmu_ipu";
>>                 reg...;
>>                 irqs...;
>>         }
>> }
>>
>> Is it something you can handle with your current framework?
>
> I agree it would be nice only IPU managed the prcm, however we can't
> do that right now because hwmod expects the IP block to be out of
> reset to continue the _enable sequence. On IPU both reset lines are
> asserted at that point and hence _are_any_hardreset_lines_asserted
> check will bail out, and ipu resets can't be lifted without a
> configured iommu otherwise it might execute random garbage.

That's a good point, but like Paul said, the hard reset was removed 
outside of the fmwk due to the lack of understanding about the real 
usage / need for it.

If we do have a better understanding, we might add some more support in 
the fmwk or at least improve it.

I'm now realizing that aborting the init if some reset lines are 
asserted is not what we want to do for the IPU SS hwmod that will 
contain the IPU (processor) reset control.
In fact the previous approach with a fake hwmod for the ipu_c0 processor 
would have been avoided that issue.

If we do not want to go back with that, we should clearly revise the 
_are_any_hardreset_lines_asserted approach and not prevent the init in 
such case since it will prevent all the subsystem to start properly.

> So, for IPU and DSP the mmu must be deasserted and configured before
> the processor reset line (which is more like a parking brake) is
> deasserted, and the latter should be made before _enable is called so
> it can fully execute the enable sequence.

Yep, so we have to change the way it is handled today.


Paul,

If we consider that the reset lines are stored in the subsystem hwmod 
(IPU, DSP or IVA), we cannot prevent the init phase because some line 
are asserted. Otherwise we will never allow the MMU or processor to be 
enabled later.
We might have to remove that check, maybe based on flag if we want to 
keep that functionality or do an explicit reset control like we use to do.

What do you think?

Regards,
Benoit
