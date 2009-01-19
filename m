From: "Matt Gerassimoff" <mgeras@gmail.com>
Subject: Re: ioremap()/iounmap() problem
Date: Mon, 19 Jan 2009 08:39:39 -0700
Message-ID: <op.un0ggdb6l1df02@matts.therealanswer.com>
References: <1232360583.6481.92.camel@tubuntu>
 <13B9B4C6EF24D648824FF11BE8967162036D6A19F2@dlee02.ent.ti.com>
 <20090119134329.GA18301@n2100.arm.linux.org.uk>
 <13B9B4C6EF24D648824FF11BE8967162036D6A1A0F@dlee02.ent.ti.com>
 <20090119135654.GB18301@n2100.arm.linux.org.uk>
 <op.un0ew10nl1df02@matts.therealanswer.com>
 <20090119152237.GC18301@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:46135 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbZASPjp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 10:39:45 -0500
Received: by qyk4 with SMTP id 4so3037763qyk.13
        for <linux-omap@vger.kernel.org>; Mon, 19 Jan 2009 07:39:44 -0800 (PST)
In-Reply-To: <20090119152237.GC18301@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 19 Jan 2009 08:22:37 -0700, Russell King - ARM Linux  
<linux@arm.linux.org.uk> wrote:

> On Mon, Jan 19, 2009 at 08:06:27AM -0700, Matt Gerassimoff wrote:
>> This issue is the reason I have subscribed to the mailing list.  I have
>> discovered the problem and had a quick patch to solve it.
>
> It's not a solution, it's a work-around.  You're not seeing the problem
> anymore because you've changed the code to avoid using section mappings.

That's what I said at the end of the first message.

> The solution is to fix iounmap() to use proper interfaces into  
> mm/vmalloc.c
> when removing the section and supersection mappings.

After looking at how the the vmap_area's are managed, that's going to
be a tough one.
>
>> The statement:
>>
>> 	} else if (!((__pfn_to_phys(pfn) | size | addr) & ~PMD_MASK)) {
>>
>> is the strange one.  I'm not what is being checked here except the
>> PMD_MASK.
>
> 	(a | b | c) & mask
>
> 	(a & mask) | (b & mask) | (c & mask)
>
> 	(a & mask) || (b & mask) || (c & mask)
>
> and PMD_MASK is used to mask off the offset into a 2MB section.  So,
> (a & ~PMD_MASK) gives the offset into the 2MB section.
>
> So, the test is:
>
> 	- is the physical address aligned to 2MB
> and
> 	- is the size aligned to 2MB
> and
> 	- is the virtual address aligned to 2MB
> then
> 	map using section mappings.

Ok, that makes sense.

>> But without that code, everything works 100%.  I'm not sure what all the
>> remap_area_sections()
>> code does, but the cleanup definitely does not work,  as the kernel OOPS
>> will testify.
>> There may be a better solution, but as far as I can tell, it's not  
>> really
>> needed.  Maybe
>> someone else will disagree.
>
> We might as well rip this code out then.  I'm all for simpler code, but  
> I'm
> sure the folk who want to squeeze the best performance out of their  
> machines
> will quickly squeel if I did that.
>
> And what cleanup are you referring to?

I meant freeing, not cleanup.  Sorry.

As I said it's a start.  I'm all for performance but not at the expense
of integrity.  Right now the code doesn't work and needs to be fixed.

-- 
Matt
