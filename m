From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 3/3] pci: dra7xx: use pdata callbacks to perform reset
Date: Fri, 12 Feb 2016 12:25:49 +0530
Message-ID: <56BD81F5.8090404@ti.com>
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
 <56BA958A.1020503@ti.com> <56BACCDB.2070507@ti.com> <56BCF256.8010903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <56BCF256.8010903@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, richardcochran@gmail.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Suman,

On Friday 12 February 2016 02:13 AM, Suman Anna wrote:
> On 02/09/2016 11:38 PM, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Wednesday 10 February 2016 07:12 AM, Suman Anna wrote:
>>> Hi Paul,
>>>
>>> On 02/09/2016 01:36 PM, Paul Walmsley wrote:
>>>> Hi Suman 
>>>>
>>>> On Tue, 9 Feb 2016, Suman Anna wrote:
>>>>
>>>>> On 02/09/2016 02:49 AM, Paul Walmsley wrote:
>>>>>> On Mon, 8 Feb 2016, Suman Anna wrote:
>>>>>>> On 02/07/2016 08:48 PM, Paul Walmsley wrote:
>>>>>>>> On Tue, 2 Feb 2016, Kishon Vijay Abraham I wrote:
>>>>>>>>
>>>>>>>>> Paul, what do you think is the best way forward to perform reset?
>>>>>>>>
>>>>>>>> Many of the IP blocks with PRM hardreset lines are processor IP blocks. 
>>>>>>>> Those often need special reset handling to ensure that WFI/HLT-like 
>>>>>>>> instructions are executed after reset.  This special handling ensures that 
>>>>>>>> the IP blocks' bus initiator interfaces indicate that they are in standby 
>>>>>>>> to the PRCM - thus allowing power management for the rest of the chip to 
>>>>>>>> work correctly.
>>>>>>>>
>>>>>>>> But that doesn't seem to be the case with PCIe - and maybe others - 
>>>>>>>> possibly some of the MMUs?  
>>>>>>>
>>>>>>> Yeah, the sequencing between clocks and resets would still be the same
>>>>>>> for MMUs, so, adding the custom flags for MMUs is fine.
>>>>>>
>>>>>> I'm curious as to whether HWMOD_CUSTOM_HARDRESET is needed for the MMUs.  
>>>>>> We've stated that the main point of the custom hardreset code is to handle 
>>>>>> processors that need to be placed into WFI/HLT, but it doesn't seem like 
>>>>>> there would be an equivalent for MMUs.  Thoughts?
>>>>>
>>>>> The current OMAP IOMMU code already leverages the pdata ops for
>>>>> performing the resets, so not adding the flags would also require
>>>>> additional changes in the driver.
>>>>>
>>>>> Also, the reset lines controlling the MMUs actually also manage the
>>>>> reset for all the other sub-modules other than the processor cores
>>>>> within the sub-systems. We have currently different issues (see [1] for
>>>>> eg. around the IPU sub-system entering RET in between), so from a PM
>>>>> point of view, we do prefer to place the MMUs also in reset when we are
>>>>> runtime suspended.
>>>>
>>>> Should we reassert hardreset in _idle() for IP blocks that don't have 
>>>> HWMOD_CUSTOM_HARDRESET set on them?  Would that allow us to use this 
>>>> mechanism for the uncore hardreset lines, or are there other quirks?
>>>>
>>>> Also - would that address the potential issue that you mentioned with the 
>>>> PCIe block, or is that a different issue?
>>>
>>> Yeah, I think that would address the PCIe block issue in terms of reset
>>> state balancing between pm_runtime_get_sync() and pm_runtime_put()
>>> calls. Right now, they are unbalanced. The PCIe block is using these
>>> only in probe and remove, so it should work for that IP.
>>
>> As I mentioned before this would result in undesired behavior during
>> suspend/resume cycle in PCIe. (This should be okay for the current mainline
>> code but would break once we add suspend/resume support for PCIe).
> 
> Yeah, I was wondering if some peripheral would want only the clock to be
> controlled during _idle() and not reset. Even then for the PCIe case
> that you are talking about, going through a pm_runtime_get_sync(),
> pm_runtime_put_sync()/pm_runtime_put() deasserts the resets everytime

right. But it'll deassert a line which is already deasserted. So it actually
doesn't do a reset again.
> _enable() is called. Right now, the code block has ignored the return
> value from the _hardreset_deassert(), but if you check it and bail out,
> then your get_sync() would start failing from the second invocation.

hmm.. yeah.
> 
> Can you elaborate more on what kind of issues you will see on
> suspend/resume cycle with PCIe? Do note that _idle() gets called through

At this point there are other issues w.r.t suspend/resume in PCI-dra7xx but as
such reset of the controller is not desired during suspend/resume cycle and
it'll result in the register contents being reset (haven't tested it though).

Thanks
Kishon
