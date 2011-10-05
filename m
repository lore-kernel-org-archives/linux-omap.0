From: Rob Herring <robherring2@gmail.com>
Subject: Re: Please help with the OMAP static mapping mess
Date: Tue, 04 Oct 2011 21:09:47 -0500
Message-ID: <4E8BBC6B.7000500@gmail.com>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home> <20111003205658.GJ6324@atomide.com> <alpine.LFD.2.02.1110031744100.9106@xanadu.home> <20111003223824.GK6324@atomide.com> <4E8AAFF9.3090600@ti.com> <alpine.LFD.2.02.1110041458500.9106@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54680 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab1JECJu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 22:09:50 -0400
Received: by gyg10 with SMTP id 10so1118824gyg.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Oct 2011 19:09:50 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1110041458500.9106@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10/04/2011 04:21 PM, Nicolas Pitre wrote:
> On Tue, 4 Oct 2011, Santosh Shilimkar wrote:
> 
>> On Tuesday 04 October 2011 04:08 AM, Tony Lindgren wrote:
>>> * Nicolas Pitre <nico@fluxnic.net> [111003 14:36]:
>>>> On Mon, 3 Oct 2011, Tony Lindgren wrote:
>>>>
>>>>> Having the SRAM base address move around with different sizes also
>>>>> requires the SoC detection.. Otherwise we can end up mapping wrong
>>>>> size and end up trying to access secure SRAM that will hang the system.
>>>>>
>>>>> The way to fix it is to move SRAM init happen much later so we don't
>>>>> have to map it early. I guess now we could use ioremap for SRAM,
>>>>> although we may not want device attributes for the executable code?
>>>>> Got any suggestions here on how we should map SRAM later on?
>>>>
>>>> You can use a variant of ioremap() such as __arm_ioremap() which let you 
>>>> specify the memory attribute.
>>>
>>> OK, I'll take a look at that.
>>>
>> I have tried __arm_ioremap_pfn() for some DDR mapping and it didn't
>> work as expected. The mapping was not getting created.
> 
> Did you investigate why it wasn't created?  Must have been a trivial 
> issue surely?  But you have to wait until memory management is fully 
> initialized to call the real ioremap() though, which happens later 
> during the boot.
> 

Isn't ioremap prevented from using main memory now?

Rob
