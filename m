From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [Query][omap iommu] Consulting iommu if a physical region is
 "mappable" before actually mapping it
Date: Mon, 03 May 2010 09:03:17 +0300 (EEST)
Message-ID: <20100503.090317.115914512.Hiroshi.DOYU@nokia.com>
References: <A24693684029E5489D1D202277BE8944550BB017@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29651 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399Ab0ECGEO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:04:14 -0400
In-Reply-To: <A24693684029E5489D1D202277BE8944550BB017@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: saaguirre@ti.com
Cc: linux-omap@vger.kernel.org

Hi Sergio,

From: "ext Aguirre, Sergio" <saaguirre@ti.com>
Subject: [Query][omap iommu] Consulting iommu if a physical region is "mappable" before actually mapping it
Date: Sat, 1 May 2010 00:37:50 +0200

> Hi Hiroshi,
> 
> While still maintaining an old camera driver version, which
> uses your latest iommu driver, we have come up with the following
> question:
> 
> Can the iommu driver be "consulted" if a certain area (contiguous or not)
> can be mapped or not, before even trying to do it?

Presently "iommu-debug.ko" exposes some map info through debugfs at least.

    $ /debug/iommu/isp# ls
    mem             nr_tlb_entries  regs
    mmap            pagetable       tlb
    $ /debug/iommu/isp# head pagetable
    L:      da:      pa:
    -----------------------------------------
    2: 00001000 8ae4a002
    2: 00002000 8e7bb002
    2: 00003000 8ae49002
    2: 00004000 8ae65002
    .....

da) device address space
pa) physical address space

> The reason of this is that, in the camera driver case, we want to let
> the user know if certain capture buffer area (that will be either allocated
> in kernel or userspace) can be mapped later on without problems, which could
> help the user don't even try to allocate the buffers, and avoid a trial-and-error
> kind of cycle.

For 'da' address, it's possible easily as the above debugfs does. Also
"da_to_va()" API may be able to be used for this purpose.

For 'pa' and 'va', there's no _direct_ inquiry for the existance of
mapping by physical or kernel virtual address. You may have to go
through all entries, most likely same to user address.

> Is that possible with current driver? If not, how complex do you think it'll
> be to implement that?

It's not impossible at least. For example, with "/debug/iommu/isp",
you could know all the existance mapped areas. They are sorted in
order of 'da', though. With all 'pa's, eventually you could get the
list of 'va's. I'm not sure of the efficiency of this iteration when
there's number of maps.

I think that you could try this iteration of reverse mapping first
since not much implemetation is necessary, and then, measure the
performance of it to see if it's feasble or not. If it's too slow,
some other solution would be necessary.
