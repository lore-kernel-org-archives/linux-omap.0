From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v3 3/3] pci: dra7xx: use pdata callbacks to perform reset
Date: Tue, 9 Feb 2016 11:40:37 -0600
Message-ID: <56BA2495.9020407@ti.com>
References: <1452780672-14339-1-git-send-email-kishon@ti.com>
 <1452780672-14339-4-git-send-email-kishon@ti.com>
 <20160127173104.GQ19432@atomide.com> <56A90971.4020409@ti.com>
 <20160127185649.GV19432@atomide.com> <56A94FB7.6020903@ti.com>
 <20160128183156.GH19432@atomide.com> <56B087AD.4000505@ti.com>
 <alpine.DEB.2.02.1602080208070.2182@utopia.booyaka.com>
 <56B900E9.9040306@ti.com>
 <alpine.DEB.2.02.1602090846480.2906@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1602090846480.2906@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On 02/09/2016 02:49 AM, Paul Walmsley wrote:
> On Mon, 8 Feb 2016, Suman Anna wrote:
> 
>> On 02/07/2016 08:48 PM, Paul Walmsley wrote:
>>> On Tue, 2 Feb 2016, Kishon Vijay Abraham I wrote:
>>>
>>>> Paul, what do you think is the best way forward to perform reset?
>>>
>>> Many of the IP blocks with PRM hardreset lines are processor IP blocks. 
>>> Those often need special reset handling to ensure that WFI/HLT-like 
>>> instructions are executed after reset.  This special handling ensures that 
>>> the IP blocks' bus initiator interfaces indicate that they are in standby 
>>> to the PRCM - thus allowing power management for the rest of the chip to 
>>> work correctly.
>>>
>>> But that doesn't seem to be the case with PCIe - and maybe others - 
>>> possibly some of the MMUs?  
>>
>> Yeah, the sequencing between clocks and resets would still be the same
>> for MMUs, so, adding the custom flags for MMUs is fine.
> 
> I'm curious as to whether HWMOD_CUSTOM_HARDRESET is needed for the MMUs.  
> We've stated that the main point of the custom hardreset code is to handle 
> processors that need to be placed into WFI/HLT, but it doesn't seem like 
> there would be an equivalent for MMUs.  Thoughts?

The current OMAP IOMMU code already leverages the pdata ops for
performing the resets, so not adding the flags would also require
additional changes in the driver.

Also, the reset lines controlling the MMUs actually also manage the
reset for all the other sub-modules other than the processor cores
within the sub-systems. We have currently different issues (see [1] for
eg. around the IPU sub-system entering RET in between), so from a PM
point of view, we do prefer to place the MMUs also in reset when we are
runtime suspended.

regards
Suman

[1]
http://git.ti.com/gitweb/?p=rpmsg/rpmsg.git;a=commit;h=a7db749a8a0fdfe7baa185db9f5071789a889061
