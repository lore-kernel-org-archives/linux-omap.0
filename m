From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [GIT PULL] omap iommu: for-next for 2.6.35-rc1
Date: Fri, 02 Jul 2010 09:35:34 +0300 (EEST)
Message-ID: <20100702.093534.115912504.Hiroshi.DOYU@nokia.com>
References: <20100602.105054.59678037.Hiroshi.DOYU@nokia.com>
	<20100629.075744.104054771.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:16971 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab0GBGft (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 02:35:49 -0400
In-Reply-To: <20100629.075744.104054771.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [GIT PULL] omap iommu: for-next for 2.6.35-rc1
Date: Tue, 29 Jun 2010 07:57:44 +0300 (EEST)

> Hi Tony,
> 
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Subject: [GIT PULL] omap iommu: for-next for 2.6.35-rc1
> Date: Wed, 02 Jun 2010 10:50:54 +0300 (EEST)
> 
>> Hi Tony,
>> 
>> Patches for for-next for omap iommu module.
>> 
>> The following changes since commit 67a3e12b05e055c0415c556a315a3d3eb637e29e:
>> 
>>   Linux 2.6.35-rc1 (2010-05-30 13:21:02 -0700)
>> 
>> are available in the git repository at:
>>   git://gitorious.org/~doyu/lk/mainline.git v2.6.35-rc1-iommu
>> 
>> Hiroshi DOYU (3):
>>       omap iommu: Introduce iopgd_is_table MACRO
>>       omap iommu: Rename iopte_[p,v]addr -> iopte_page_[p,v]addr
>>       omap iommu: move iommu_disable at fault to the above layer
>> 
>> Kanigeri, Hari (2):
>>       omap iommu: update irq mask to be specific about twl and tlb
>>       omap iommu: add functionality to get TLB miss interrupt
>> 
>>  arch/arm/mach-omap2/iommu2.c            |   44 ++++++++++++++++++++++++------
>>  arch/arm/plat-omap/include/plat/iommu.h |    2 +
>>  arch/arm/plat-omap/iommu.c              |   27 ++++++++++++++++---
>>  arch/arm/plat-omap/iopgtable.h          |    8 +++--
>>  4 files changed, 65 insertions(+), 16 deletions(-)
> 
> Any chance to merge?
> 
> I have added 2 patches which were dropped from omap iommu fix as
> below. Please pull the following branch.

Hi Tony,

Do you have any plan for pulling for-next patches?

I have some "omap iommu" and "omap mailbox" patches for for-next. Now
the merge window seems so small and I don't want to miss it.

> The following changes since commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02:
> 
>   Linux 2.6.35-rc3 (2010-06-11 19:14:04 -0700)
> 
> are available in the git repository at:
>   git://gitorious.org/~doyu/lk/mainline.git v2.6.35-rc3-iommu-for-next
> 
> Hiroshi DOYU (4):
>       omap iommu: Introduce iopgd_is_table MACRO
>       omap iommu: Rename iopte_[p,v]addr -> iopte_page_[p,v]addr
>       omap iommu: move iommu_disable at fault to the above layer
>       omap iommu: Make omap-iommu.o built-in
> 
> Kanigeri, Hari (3):
>       omap iommu: update irq mask to be specific about twl and tlb
>       omap iommu: add functionality to get TLB miss interrupt
>       omap iommu: update ducati mmu irq define name
> 
>  arch/arm/mach-omap2/Makefile            |    5 +++-
>  arch/arm/mach-omap2/iommu2.c            |   44 ++++++++++++++++++++++++------
>  arch/arm/mach-omap2/omap-iommu.c        |    2 +-
>  arch/arm/plat-omap/include/plat/iommu.h |    2 +
>  arch/arm/plat-omap/iommu.c              |   27 ++++++++++++++++---
>  arch/arm/plat-omap/iopgtable.h          |    8 +++--
>  6 files changed, 70 insertions(+), 18 deletions(-)
