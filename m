From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v3 3/3] pci: dra7xx: use pdata callbacks to perform reset
Date: Fri, 12 Feb 2016 11:20:20 -0600
Message-ID: <56BE1454.3030002@ti.com>
References: <1452780672-14339-1-git-send-email-kishon@ti.com>
 <1452780672-14339-4-git-send-email-kishon@ti.com>
 <20160127173104.GQ19432@atomide.com> <56A90971.4020409@ti.com>
 <20160127185649.GV19432@atomide.com> <56A94FB7.6020903@ti.com>
 <20160128183156.GH19432@atomide.com> <56B087AD.4000505@ti.com>
 <alpine.DEB.2.02.1602080208070.2182@utopia.booyaka.com>
 <56B900E9.9040306@ti.com>
 <alpine.DEB.2.02.1602090846480.2906@utopia.booyaka.com>
 <56BA2495.9020407@ti.com>
 <alpine.DEB.2.02.1602091932160.2906@utopia.booyaka.com>
 <56BA958A.1020503@ti.com> <56BACCDB.2070507@ti.com>
 <alpine.DEB.2.02.1602111921090.20757@utopia.booyaka.com>
 <56BD8091.4090007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56BD8091.4090007@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Paul Walmsley <paul@pwsan.com>, d-gerlach@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Kishon,

On 02/12/2016 12:49 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Friday 12 February 2016 12:57 AM, Paul Walmsley wrote:
>> Hi Kishon, Suman,
>>
>> On Wed, 10 Feb 2016, Kishon Vijay Abraham I wrote:
>>
>>> On Wednesday 10 February 2016 07:12 AM, Suman Anna wrote:
>>>> On 02/09/2016 01:36 PM, Paul Walmsley wrote:
>>>>> On Tue, 9 Feb 2016, Suman Anna wrote:
>>>>>> On 02/09/2016 02:49 AM, Paul Walmsley wrote:
>>>>>>> On Mon, 8 Feb 2016, Suman Anna wrote:
>>>>>>>> On 02/07/2016 08:48 PM, Paul Walmsley wrote:
>>>>>>>>> On Tue, 2 Feb 2016, Kishon Vijay Abraham I wrote:
>>>>>>>>>
>>>>>>>>>> Paul, what do you think is the best way forward to perform reset?
>>>>>>>>>
>>>>>>>>> Many of the IP blocks with PRM hardreset lines are processor IP blocks. 
>>>>>>>>> Those often need special reset handling to ensure that WFI/HLT-like 
>>>>>>>>> instructions are executed after reset.  This special handling ensures that 
>>>>>>>>> the IP blocks' bus initiator interfaces indicate that they are in standby 
>>>>>>>>> to the PRCM - thus allowing power management for the rest of the chip to 
>>>>>>>>> work correctly.
>>>>>>>>>
>>>>>>>>> But that doesn't seem to be the case with PCIe - and maybe others - 
>>>>>>>>> possibly some of the MMUs?  
>>>>>>>>
>>>>>>>> Yeah, the sequencing between clocks and resets would still be the same
>>>>>>>> for MMUs, so, adding the custom flags for MMUs is fine.
>>>>>>>
>>>>>>> I'm curious as to whether HWMOD_CUSTOM_HARDRESET is needed for the MMUs.  
>>>>>>> We've stated that the main point of the custom hardreset code is to handle 
>>>>>>> processors that need to be placed into WFI/HLT, but it doesn't seem like 
>>>>>>> there would be an equivalent for MMUs.  Thoughts?
>>>>>>
>>>>>> The current OMAP IOMMU code already leverages the pdata ops for
>>>>>> performing the resets, so not adding the flags would also require
>>>>>> additional changes in the driver.
>>>>>>
>>>>>> Also, the reset lines controlling the MMUs actually also manage the
>>>>>> reset for all the other sub-modules other than the processor cores
>>>>>> within the sub-systems. We have currently different issues (see [1] for
>>>>>> eg. around the IPU sub-system entering RET in between), so from a PM
>>>>>> point of view, we do prefer to place the MMUs also in reset when we are
>>>>>> runtime suspended.
>>>>>
>>>>> Should we reassert hardreset in _idle() for IP blocks that don't have 
>>>>> HWMOD_CUSTOM_HARDRESET set on them?  Would that allow us to use this 
>>>>> mechanism for the uncore hardreset lines, or are there other quirks?
>>>>>
>>>>> Also - would that address the potential issue that you mentioned with the 
>>>>> PCIe block, or is that a different issue?
>>>>
>>>> Yeah, I think that would address the PCIe block issue in terms of reset
>>>> state balancing between pm_runtime_get_sync() and pm_runtime_put()
>>>> calls. Right now, they are unbalanced. The PCIe block is using these
>>>> only in probe and remove, so it should work for that IP.
>>>
>>> As I mentioned before this would result in undesired behavior during
>>> suspend/resume cycle in PCIe. (This should be okay for the current mainline
>>> code but would break once we add suspend/resume support for PCIe).
>>
>> I'd like to understand where we're currently at here.  It looks like we're 
>> waiting for testing from Suman, and we're waiting for Kishon to try using 
>> the bind/unbind driver model hook to see if that wedges PCIe?  Does this 
>> match your collective understanding of the status here?
> 
> I got to try this and looks like even without this series there are other PM
> issues possible introduced by Commit 5de85b9d57ab ("PM / runtime: Re-init
> runtime PM states at probe error and driver unbind").
> 
> Now I get this error if I tried to modprobe after rmmod pci-dra7xx.
> [   54.352860] dra7-pcie 51000000.pcie: omap_device: omap_device_enable()
> called from invalid state 1
> [   54.362318] dra7-pcie 51000000.pcie: pm_runtime_get_sync failed
> [   54.368624] dra7-pcie: probe of 51000000.pcie failed with error -22
> 
> From the thread that fixes this issue [1], looks like drivers that use
> *_autosuspend() get this issue. However I don't use *_autosuspend() in
> pci-dra7xx. Maybe pci core has this? This has to be debugged further. But I
> feel this is not related to the problem that we are trying to solve right now
> (dra7 hangs if PCI driver is enabled) and given the fact that pci-dra7xx driver
> is now modeled as built-in driver, this can be deferred.
> 
> [1] -> http://www.spinics.net/lists/arm-kernel/msg481845.html
> 
>>
>> Thinking about the question of what to do about hardreset assertion in 
>> idle, if we need it, we could add a hwmod flag to control that mode.  I 
>> would consider it a temporary workaround until we have the hwmod code 
>> moved into a bus driver and the bus driver/hwmod code can hook into the 
>> LDM .remove operation (and connect it to .shutdown, etc.)  Suman/Kishon: 
>> is it your understanding that we could remove the existing hardreset 
>> control in the IOMMU drivers and the PCIe driver if we had these options 
>> in the hwmod code? 
> 
> Yeah, that's my understanding. And since this series solves the PCIe problem,
> it's proven that hardreset control can be moved to hwmod code.
> 
> For PCIe, it's even okay to do deassert in _reset, but I'm not sure if it'll
> have side effects with other modules.
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index e9f65fe..24cafd9 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1966,8 +1966,11 @@ static int _reset(struct omap_hwmod *oh)
>  		r = oh->class->reset(oh);
>  	} else {
>  		if (oh->rst_lines_cnt > 0) {
> -			for (i = 0; i < oh->rst_lines_cnt; i++)
> +			for (i = 0; i < oh->rst_lines_cnt; i++) {
>  				_assert_hardreset(oh, oh->rst_lines[i].name);
> +				if (!(oh->flags & HWMOD_CUSTOM_HARDRESET))
> +					_deassert_hardreset(oh, oh->rst_lines[i].name);
> +			}

Better yet, just add this specific  _deassert_hardreset logic to a DRA7
PCIe-specific class->reset function. You won't need adding the
HWMOD_CUSTOM_HARDRESET flags either and will satisfy your suspend/resume
dilemma, and it won't affect other paths. If that can work for you, that
would be simplest patch for this -rc cycle.

>  			return 0;
>  		} else {
>  			r = _ocp_softreset(oh);
> 
> Thanks
> Kishon
> 
> P.S. I'll be on vacation till end of next week with no email access till then.
> So email response will be delayed. Sorry about that.

Sekhar,
Will you be following up with above suggestion since Kishon is gonna be out?

regards
Suman

>>
>> Dave, any further comments here?
>>
>>
>> - Paul
>>
