From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: Please help with the OMAP static mapping mess
Date: Wed, 05 Oct 2011 11:46:24 +0530
Message-ID: <4E8BF638.1000507@ti.com>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home> <20111003205658.GJ6324@atomide.com> <alpine.LFD.2.02.1110031744100.9106@xanadu.home> <20111003223824.GK6324@atomide.com> <4E8AAFF9.3090600@ti.com> <alpine.LFD.2.02.1110041458500.9106@xanadu.home> <4E8BBC6B.7000500@gmail.com> <alpine.LFD.2.02.1110042232380.9106@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:53018 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752658Ab1JEGQb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 02:16:31 -0400
Received: by mail-gy0-f179.google.com with SMTP id 4so1227046gyg.10
        for <linux-omap@vger.kernel.org>; Tue, 04 Oct 2011 23:16:30 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1110042232380.9106@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Rob Herring <robherring2@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 05 October 2011 08:09 AM, Nicolas Pitre wrote:
> On Tue, 4 Oct 2011, Rob Herring wrote:
> 
>> On 10/04/2011 04:21 PM, Nicolas Pitre wrote:
>>> On Tue, 4 Oct 2011, Santosh Shilimkar wrote:
>>>
>>>> On Tuesday 04 October 2011 04:08 AM, Tony Lindgren wrote:
>>>>> * Nicolas Pitre <nico@fluxnic.net> [111003 14:36]:
>>>>>> On Mon, 3 Oct 2011, Tony Lindgren wrote:
>>>>>>
>>>>>>> Having the SRAM base address move around with different sizes also
>>>>>>> requires the SoC detection.. Otherwise we can end up mapping wrong
>>>>>>> size and end up trying to access secure SRAM that will hang the system.
>>>>>>>
>>>>>>> The way to fix it is to move SRAM init happen much later so we don't
>>>>>>> have to map it early. I guess now we could use ioremap for SRAM,
>>>>>>> although we may not want device attributes for the executable code?
>>>>>>> Got any suggestions here on how we should map SRAM later on?
>>>>>>
>>>>>> You can use a variant of ioremap() such as __arm_ioremap() which let you 
>>>>>> specify the memory attribute.
>>>>>
>>>>> OK, I'll take a look at that.
>>>>>
>>>> I have tried __arm_ioremap_pfn() for some DDR mapping and it didn't
>>>> work as expected. The mapping was not getting created.
>>>
>>> Did you investigate why it wasn't created?  Must have been a trivial 
>>> issue surely?  But you have to wait until memory management is fully 
>>> initialized to call the real ioremap() though, which happens later 
>>> during the boot.
>>>
I didn't investigate further on it but may be it was because of the
ordering as you pointed out. The new __arm_ioremap_exe() seems to me
a good idea and should solve the problem.

Regards
Santosh
