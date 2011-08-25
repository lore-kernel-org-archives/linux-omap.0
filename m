From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: Question on virtual memory layout: lowmem with memory hole
Date: Fri, 26 Aug 2011 00:06:20 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B47E2949@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B03B47E23FC@dbde02.ent.ti.com>
 <20110825102245.GA10405@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39432 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab1HYSgj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Aug 2011 14:36:39 -0400
In-Reply-To: <20110825102245.GA10405@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Russell King - ARM Linux wrote on Thursday, August 25, 2011 3:53 PM:

> On Thu, Aug 25, 2011 at 09:35:07AM +0530, Pedanekar, Hemant wrote:
>> E.g., on OMAP3 with mem=32M@0x80000000 mem=8M@0x87800000
>> 
>> (CASE 1)
>>  Memory: 32MB 8MB = 40MB total
>>  Memory: 28408k/28408k available, 12552k reserved, 0K highmem
>>  Virtual kernel memory layout:
>>      vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>>      fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>>      DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
>>      vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
>>      lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
>>      modules : 0xbf000000 - 0xc0000000   (  16 MB)
>>        .text : 0xc0008000 - 0xc05ac2c8   (5777 kB)
>>        .init : 0xc05ad000 - 0xc05f8780   ( 302 kB)
>>        .data : 0xc05fa000 - 0xc06838d0   ( 551 kB)
>>         .bss : 0xc06838f4 - 0xc0bd8a14   (5461 kB)
>> 
>> Is this expected? 88MB space between two 'mem's seems to have lost.
> 
> Yes.  The memory layout lines gives an overview of the virtual memory
> address space _regions_. 
> 
> What it's saying is that the virtual addresses from 0xc0000000 - 0xc8000000
> are used for lowmem.  That may not be fully populated, but that's what
> the address range is reserved for.
>

So, larger the hole, more address space will be unusable - is that correct?
 
>> This also
>> means vmalloc space is lower compared to when a single mem=40M is passed.
> 
> Huh.  Either your maths is wrong or...
> 
> Here's case 1:
>>      vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB) And case 2:
>>      vmalloc : 0xc3000000 - 0xf8000000   ( 848 MB)
> 
> Looks to me like case 1, vmalloc space is _higher_ not _lower_.  That's
> expected because you told the kernel it had more memory in case 1.

Sorry, my mistake - I actually meant "vmalloc space is _smaller_ compared to
when a single mem=40M is passed" though the actual physical RAM available is
same in both the cases.

Thanks.

   Hemant