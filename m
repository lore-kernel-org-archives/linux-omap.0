From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/4] ARM: Add __arm_ioremap_exec for mapping external
 memory as MT_MEMORY
Date: Fri, 07 Oct 2011 20:33:02 +0530
Message-ID: <4E8F14A6.5050402@ti.com>
References: <20111005004339.26980.31149.stgit@kaulin.local> <20111005004539.26980.52409.stgit@kaulin.local> <alpine.LFD.2.02.1110042059110.9106@xanadu.home> <20111005220619.GC6324@atomide.com> <4E8E9EE8.8010106@ti.com> <20111007144349.GE6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:42482 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752707Ab1JGPDK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 11:03:10 -0400
Received: by gyf1 with SMTP id 1so3735480gyf.9
        for <linux-omap@vger.kernel.org>; Fri, 07 Oct 2011 08:03:09 -0700 (PDT)
In-Reply-To: <20111007144349.GE6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Friday 07 October 2011 08:13 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [111006 23:06]:
>> On Thursday 06 October 2011 03:36 AM, Tony Lindgren wrote:
>>> * Nicolas Pitre <nico@fluxnic.net> [111004 17:26]:
>>>> On Tue, 4 Oct 2011, Tony Lindgren wrote:
>>> +void __iomem *
>>> +__arm_ioremap_exec(unsigned long phys_addr, size_t size, int cached)
>>> +{
>>> +	unsigned int mtype;
>>> +
>>> +	if (cached)
>>> +		mtype = MT_MEMORY;
>>> +	else
>>> +		mtype = MT_MEMORY_NONCACHED;
>>> +
>> Why don't we allow user to pass the mtype here ?
> 
> Well we want to keep the MT_MEMORY types out of asm/io.h.
> 
ok.

>> We do have a need also to map a page of DDR and SRAM as
>> strongly ordered for errata fix and this interface can be
>> used for that.
> 
> Yeah..
> 
>> Ofcourse, SO memory type is not executable memories, so the
>> API name might be miss-leading.
> 
> ..so I think we should just have a separate static mapping for
> the omap4 errata fix SO page, and just limit the memory available
> for SRAM code to ioremap.
> 
> How does that sounds to you?
> 
That's more or less what the patch is already doing.
Instead of static mapping, I was dynamically stealing one
page ( SZ_4K) and mapping it as MT_MEMORY_SO and rest
of the memory as MT_MEMORY for OMAP4.

It should be doable with your updates as well,
I guess with or without static mapping since the only
requisite is to keep one page of SRAM free on OMAP4 and
them map them using  iotable_init() with MT_MEMORY_SO.

Regards
Santosh



