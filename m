From: Christoffer Dall <chris@cloudcar.com>
Subject: Re: [RFC PATCH] ARM: mm: Fix alloc_init_section bug on LPAE
Date: Sat, 26 Jan 2013 01:15:02 -0500
Message-ID: <CANOGCgPSPN9L=Ct2cgaVh+kt5uOx5bQdhV725BTy=hyaHuByhQ@mail.gmail.com>
References: <1359160318-27068-1-git-send-email-chris@cloudcar.com>
	<51036083.4040407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:52072 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab3AZGPF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Jan 2013 01:15:05 -0500
Received: by mail-lb0-f176.google.com with SMTP id s4so1804724lbc.7
        for <linux-omap@vger.kernel.org>; Fri, 25 Jan 2013 22:15:02 -0800 (PST)
In-Reply-To: <51036083.4040407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Jeremy C. Andrus" <jeremya@cs.columbia.edu>, Catalin Marinas <catalin.marinas@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Fri, Jan 25, 2013 at 11:50 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Hi Christoffer,
>
>
> On Saturday 26 January 2013 06:01 AM, Christoffer Dall wrote:
>>
>> When using LPAE the call to alloc_init_pte is passed then end address
>> for the entire 1st level page table region, and the code unluckily ends
>> up going over the bounds of the single allocated PTE, which is sad.
>>
>> This caused LPAE boot on omap5 to crash.
>>
>> There may be some hidden mystery in the boot code that I'm unaware of
>> or it may be assumed that all mappings are always mappable as sections
>> on LPAE and therefore omap5 just does something bad, in which case this
>> patch isn't the right fix, but I'd be happy to be told the reason.
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Jeremy C. Andrus <jeremya@cs.columbia.edu>
>> Signed-off-by: Christoffer Dall <chris@cloudcar.com>
>> ---
>
>
> I was about to reply on the LPAE boot issue you mentioned in other
> email. We have seen couple of issues with LPAE on OMAP5 and sent the
> fixes.
>
> [1] ARM: LPAE: Fix alloc_init_section to flush all the pmd entries
> [2] ARM: LPAE: Fix mapping in alloc_init_pte for unaligned addresses
>
> Both needs ack from Catalin and RMK's ok to get into the patch system.
>
> Can you please check if they work for you ?  I expect the [1] should
> make your board boot on OMAP5.
>

yeah, that patch had the same effect as my patch (with the extra waste
of memory for the ptes as Russell pointed out).

My googling of fixes for this completely failed somehow.

Thanks for pointing it out.
-Christoffer
