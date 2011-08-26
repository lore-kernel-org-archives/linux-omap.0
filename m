From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: Question on virtual memory layout: lowmem with memory hole
Date: Fri, 26 Aug 2011 23:11:22 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B47E2EA7@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B03B47E23FC@dbde02.ent.ti.com>
 <20110825102245.GA10405@n2100.arm.linux.org.uk>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03B47E2949@dbde02.ent.ti.com>
 <20110825185228.GA5029@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55214 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403Ab1HZRlj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Aug 2011 13:41:39 -0400
In-Reply-To: <20110825185228.GA5029@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Russell King - ARM Linux wrote on Friday, August 26, 2011 12:22 AM:

> On Fri, Aug 26, 2011 at 12:06:20AM +0530, Pedanekar, Hemant wrote:
>> Russell King - ARM Linux wrote on Thursday, August 25, 2011 3:53 PM:
>> 
>>> On Thu, Aug 25, 2011 at 09:35:07AM +0530, Pedanekar, Hemant wrote:
>>>> E.g., on OMAP3 with mem=32M@0x80000000 mem=8M@0x87800000
>>>> 
[...]

>> 
>> So, larger the hole, more address space will be unusable - is that correct?
> 
> Correct.
> 
>>>> This also
>>>> means vmalloc space is lower compared to when a single mem=40M is passed.
>>> 
>>> Huh.  Either your maths is wrong or...
>>> 
>>> Here's case 1:
>>>>      vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB) And case 2:
>>>>      vmalloc : 0xc3000000 - 0xf8000000   ( 848 MB)
>>> 
>>> Looks to me like case 1, vmalloc space is _higher_ not _lower_.  That's
>>> expected because you told the kernel it had more memory in case 1.
>> 
>> Sorry, my mistake - I actually meant "vmalloc space is _smaller_ compared
>> to when a single mem=40M is passed" though the actual physical RAM
>> available is same in both the cases.
> 
> Again, that's expected.
> 
> We require a 1:1 relationship between virtual and physical addresses for
> efficiency - having non-linear translation means we'd need a lookup table,
> and as these translations are heavily used, that will impact
> performance.

Thanks for all the clarifications.

   Hemant