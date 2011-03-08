From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 2/4] OMAP4: hwmod data: add mmu hwmod for ipu and dsp
Date: Tue, 8 Mar 2011 22:29:47 +0100
Message-ID: <4D769FCB.4040907@ti.com>
References: <1299484388-16205-1-git-send-email-omar.ramirez@ti.com>	<1299484388-16205-3-git-send-email-omar.ramirez@ti.com>	<4D74D5B9.2070907@ti.com> <AANLkTimfSfCc3Pvf_=2MKnHTiC9gVw-_xohHczTUHroH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44406 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000Ab1CHVaC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 16:30:02 -0500
In-Reply-To: <AANLkTimfSfCc3Pvf_=2MKnHTiC9gVw-_xohHczTUHroH@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Hi Omar,

On 3/7/2011 8:01 PM, Ramirez Luna, Omar wrote:
> Hi Benoit,
>
> On Mon, Mar 7, 2011 at 6:55 AM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> Hi Omar,
>>
>> I have some concern about the introduction of a hwmod that does not match
>> the actual HW capability. MMU does exist, but there is no SW control for it.
>
> Maybe I'm missing something, but iommu (driver) is meant to control
> isp, iva, ipu and dsp MMUs; even with a simple driver interfaced with
> iommu, that had nothing to do with the modules mentioned, you could
> still deassert the reset, enable the clocks, create your tables and
> add entries, and so on... not that it would be useful for anybody
> other than the real HW containing the MMU subsystem.

Yes, you are missing something... But to be honest I was not really 
clear in my reply :-)

What I meant is that the mmu does not have any explicit PRCM module 
enable control. The PRCM does control only the DSP as a whole. Since 
hwmods are generated with a PRCM granularity, any sub module will not be 
exposed by default.
The DSP core or Cortex M3 cores were exposed just because there is a 
PRCM reset control line to control them.

Hence the current structures:
IPU for the main PRCM control (including MMU + UNICACHE)
IPU_C0 for Cortex M3 #1
IPU_C1 for Cortex M3 #2

>> In fact the only control available is for mmu + cache + logic, and that's
>> why the MMU is handle today under the main DSP/IPU hwmod.
>
> AFAIK, sysc configuration is missing from the old hwmods, I thought
> separate hwmods gave:

Yep, that one was missing because the hwmod was the ipu subsystem one. 
But in fact the only ipu part that is accessible from the MPU is the MMU.
That's why I now think that renaming ipu with mmu_ipu is probably the 
best thing to do.

> - flexibility: so the system wouldn't dump_stack trying to read mmu
> registers, because the user doesn't know ipu/dsp code should handle
> the reset first.
> - clarity: so iommu handles its own mmu hwmods instead of hard coding
> the names of the pseudo hwmods containing the mmu.
>
>> Here you are just duplicating dsp_hwmod and ipu_hwmod with dsp_mmu_hwmod /
>> ipu_mmu_hwmod and adding some memory space for the mmu part.
>>
>> In that case, you can still use the previous name and add the missing
>> entries in it.
>>
>> The only advantage I can see is the usage of a common class that will allow
>> you to handle both DSP and IPU using the same "MMU" driver.
>>
>> So, what are you going to do with the remaining entries for dsp_hwmod and
>> ipu_hwmod?
>
> I think these can be removed, and iommu code can handle its own
> hwmods; but if you want to update the old ones, that can be done too,
> the tradeoff would be that iommu needs to know the name of the hwmods
> with mmu data.

I've checked both IPU and DSP HW specs, and in the both cases, the mmu 
IP is the only module with OCP port from the MPU in the relevant subsystem.
In that case, it is easier for me to remove that DSP and IPU hwmods and 
move everything under the MMUs hwmods.
It will then highlight the re-use of the same IP in two different 
subsystems.

I have now to modify the OMAP4 generator in order to provide the correct 
data in the right format.

I'll try to do that before the end of this week. This will not have any 
real impact for you except for the name change (mmu_ipu and mmu_dsp).

Is that OK for you?

Regards,
Benoit
