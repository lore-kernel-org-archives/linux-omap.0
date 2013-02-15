From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Fri, 15 Feb 2013 12:59:51 +0530
Message-ID: <511DE3EF.6070902@ti.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com> <1360840554-26901-2-git-send-email-balbi@ti.com> <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi> <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi> <20130214193911.GD11806@atomide.com> <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com> <alpine.DEB.2.00.1302142124370.11016@utopia.booyaka.com> <20130214224710.GF11362@atomide.com> <20130215064626.GB30038@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54153 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935388Ab3BOH2f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 02:28:35 -0500
In-Reply-To: <20130215064626.GB30038@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Rajendra Nayak <rnayak@ti.com>, "Kristo, Tero" <t-kristo@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

+ Tero, Rajendra, Kevin

On Friday 15 February 2013 12:16 PM, Felipe Balbi wrote:
> On Thu, Feb 14, 2013 at 02:47:10PM -0800, Tony Lindgren wrote:
>> * Paul Walmsley <paul@pwsan.com> [130214 13:44]:
>>> Hi,
>>>
>>> On Thu, 14 Feb 2013, Paul Walmsley wrote:
>>>
>>>> So instead of something bus-specific like that, a better way would be to
>>>> use something like:
>>>>
>>>> va = dev->bus->ioremap( ... );
>>>> va = dev->bus->iounmap( ... );
>>>
>>> Something like this is what I was thinking.  Obviously there would be more
>>> patches needed, for the various arches, etc.; and I'm not convinced that
>>> the function pointer init is done at the right time yet. Comments welcome.
>>>
>>>
>>> - Paul
>>>
>>>
>>> From: Paul Walmsley <paul@pwsan.com>
>>> Date: Thu, 14 Feb 2013 13:49:58 -0700
>>> Subject: [PATCH] EXPERIMENTAL: device/ARM: allow buses to override ioremap*()
>>>   and iounmap()
>>>
>>> On some hardware, such as OMAP, the bus abstraction code needs to call
>>> ioremap(), since some SoC-integration registers are located in the
>>> device address space.  But generic device drivers should be able to
>>> call ioremap() from driver code, for the majority of situations where
>>> this isn't necessary.  This experimental patch allows Linux bus abstraction
>>> code to override all of the ioremap*() and iounmap() functions.  In the OMAP
>>> case, this would be used to return the previously-mapped address range from
>>> the bus code, when called for the device's register area.  This would avoid
>>> a duplicate TLB mapping for that space.
>>>
>>> This might also be useful as a generic replacement for pci_ioremap_bar().
>>>
>>> Compile-tested only.
>>
>> The other option could be to allow custom ioremap function pointers
>> based on address range in __arm_ioremap_pfn_caller() the same way as
>> the SoC specific static mappings are allowed. That would require adding
>> a function pointer to struct map_desc.
>>
>> Maybe that would do the trick?
>
> I'm not sure we should even try that. I mean, eventually (maybe in 100
> years) we wouldn't mach-* at all and even struct map_desc would be
> dynamically initialized by data passed in via DTB, right ? Just consider
> Arnd's patch for the "machine_desc-less" DT boot. If we add a function
> pointer to struct map_desc, it will just become yet another function
> pointer to be removed later.
>
On the same thread, it was also mentioned that, "machine_desc-less" DT
boot is for simple machines. I have looked that aspect bit more.
Considering the amount of callbacks OMAP uses, it is not practical.
Ofcourse am also not in favor of adding another function pointer
stuff here.

We should get rid of dual ioremap() and the method suggested by Paul
seems to be reasonable.

Sysconfig handling is very tightly coupled with PRCM. I agree with Paul
that hardware should have mapped it in separate address space. So
whichever framework manages the PRCM, should also manage sysconfig.
Refer all the issues around sysconfig for IP's like USB, UART
and they are directly PRCM issues.

We should be able to work around the IP integration issues
around problematic IPs like UART, USB with some profile knowledge
which can be handled by runtime PM transparently. It should have
been done that way in first place instead of functions pointers
which today break the Device Tree builds directly.

As I mentioned in OMAP5 data series, we are now able to remove the
IO_resource information ( Address space, IRQ data, DMA lines) from
from hwmod data and extract it from device Tree. Thats a good
point.

Next one is getting rid off sysconfig function pointers which drivers
are using and handle those issues using runtime_pm APIs. Idea is, IP
gives profile like...
e.g
McSPI1 -> Smart Idle always
UART -> no_idle(runtime_get) and  smart_idle(runtime_put)
mUSB --> no_idle(runtime_get) and force_idle(runtime_put)

Then the last one is custom reset function for broken IPs. For this
one as well if we can add a hook in runtime framework, then it
can be handled without direct function calls.

Regards,
Santosh



Regards
Santosh











