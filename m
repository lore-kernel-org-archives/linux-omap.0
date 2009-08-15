From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: Exception while handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Sat, 15 Aug 2009 20:53:15 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003790C65EB@dbde02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com>
 <20090807220016.GG31543@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C5B3A@dbde02.ent.ti.com>
 <20090808170300.GA23481@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com>
 <20090813173327.GA14872@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com>
 <366f00c80908150603m2b6f3235y7e47256adc11234a@mail.gmail.com>
 <20090815131027.GE29616@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48486 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962AbZHOPXt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 11:23:49 -0400
In-Reply-To: <20090815131027.GE29616@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep K N <sudeepholla.maillist@gmail.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> 
> On Sat, Aug 15, 2009 at 06:33:20PM +0530, Sudeep K N wrote:
> > I had intially tried memmap=xxM$yyM to reserve xxM at yyM
> > This has some issue with 2.6.27 and fixed in later versions(not sure
> > of exact version) and I have not tried it.
> 
> memmap= is not supported on ARM - there is no code to parse or use the
> option except on x86 and blackfin, so it gets passed to the init program
> when userspace starts.

I am just wondering if there is something extra that needs to be done in my kernel or app, below are the lines that I feel will matter,

In driver module:
- request_mem_region(start_addr, length, "name");
- ioremap_nocache (start_addr,length);
(in mmap function)
- vma->vm_flags |= VM_RESERVED | VM_IO;
- remap_pfn_range(vma,vma->vm_start,vma->vm_pgoff,vma->vm_end-vma->vm_start, vma->vm_page_prot);

In my app:
- userp = mmap((void *)0x0, size, PROT_WRITE|PROT_READ,MAP_SHARED,fd,0x85800000);
- memset((void *)userp,0,0x1000000);

Few Observations:
- When my bootargs doesn't is just mem=88M@0x80000000, I don't see any issues it works great
- When my bootargs is mem=88M@0x80000000 mem=60M@0x8C400000 it crashes at user space. Where as when I do same memset in driver (kernel space) it passes, the issue is only with user space (over mmap)
- With hole, when I use mmap with MAP_PRIVATE it passes fine.

I can give both driver and app that I have, but it has nothing but the above lines.

Thanks for the comments.

Regards,
Khasim

