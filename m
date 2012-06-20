From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: Re: [PATCH v2 1/4] ARM: new cache maintenance api for iommu mem flush
Date: Wed, 20 Jun 2012 14:30:32 +0530
Message-ID: <CADysL2bzL_TCmeEcSJdv-_WeXFyU3zNnU8mxtc81JDG7bLYHoQ@mail.gmail.com>
References: <CADysL2aFufYzmxWOHp2xUt_TkqOQpX883za+7it5h2qd=PMwwA@mail.gmail.com>
	<20120620084330.GA13009@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:51691 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755617Ab2FTJAf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jun 2012 05:00:35 -0400
Received: by wgbdq11 with SMTP id dq11so4836249wgb.5
        for <linux-omap@vger.kernel.org>; Wed, 20 Jun 2012 02:00:32 -0700 (PDT)
In-Reply-To: <20120620084330.GA13009@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com

Hi Russell,


On Wed, Jun 20, 2012 at 2:13 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 19, 2012 at 04:51:07PM +0530, Gupta, Ramesh wrote:
>> >From 785a1f2854002ce7c1c8880bc5d8d92a7868bf1c Mon Sep 17 00:00:00 2=
001
>> From: Ramesh Gupta G <grgupta@ti.com>
>> Date: Fri, 15 Jun 2012 16:37:20 +0530
>> Subject: [PATCH v2 1/4] ARM: new cache maintenance api for iommu mem=
 flush
>>
>> non-coherent IOMMUs need to make sure that the
>> data held in the caches need to be visible for the
>> MMU hardware. A new L1 cache maintenance api has been
>> created to handle this. Thanks to RMK's suggestions on
>> creating a dedicated API for this purpose.
>>
>> ref:
>> http://marc.info/?l=3Dlinux-kernel&m=3D131316512713815&w=3D2
>>
>> Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
>> ---
>> =A0arch/arm/include/asm/cacheflush.h | =A0 17 +++++++++++++++++
>> =A0arch/arm/include/asm/glue-cache.h | =A0 =A01 +
>> =A0arch/arm/mm/proc-macros.S =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A03 files changed, 19 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/cacheflush.h
>> b/arch/arm/include/asm/cacheflush.h
>> index d5d8d5c..2b4f5aa 100644
>> --- a/arch/arm/include/asm/cacheflush.h
>> +++ b/arch/arm/include/asm/cacheflush.h
>> @@ -84,6 +84,11 @@
>> =A0 * =A0 =A0 =A0 =A0 =A0 - kaddr =A0- page address
>> =A0 * =A0 =A0 =A0 =A0 =A0 - size =A0 - region size
>> =A0 *
>> + * =A0 =A0 flush_mem(start, end)
>> + *
>> + * =A0 =A0 =A0 =A0 =A0 =A0 Clean and invalidate the specified virtu=
al address range.
>> + * =A0 =A0 =A0 =A0 =A0 =A0 - start =A0- virtual start address
>> + * =A0 =A0 =A0 =A0 =A0 =A0 - end =A0 =A0- virtual end address
>
> You're missing a blank line here.

I will fix it.

> Also, "flush_mem" is a very lame name - it tells us nothing about wha=
t the
> purpose of this new API is. =A0Should it be used for when the CPU MMU=
 TLB
> entries are changed? =A0What about if we're suspending, should it be =
used
> then? =A0What about if we're performing DMA - should it be used for t=
hat
> memory too?
>
> Please, give it a better name which describes what it is for.

I agree, will choose a better name to describe the api.

>> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
>> index 2d8ff3a..f48a5ab 100644
>> --- a/arch/arm/mm/proc-macros.S
>> +++ b/arch/arm/mm/proc-macros.S
>> @@ -307,6 +307,7 @@ ENTRY(\name\()_cache_fns)
>> =A0 =A0 =A0 .long =A0 \name\()_dma_map_area
>> =A0 =A0 =A0 .long =A0 \name\()_dma_unmap_area
>> =A0 =A0 =A0 .long =A0 \name\()_dma_flush_range
>> + =A0 =A0 .long =A0 \name\()_flush_mem
>> =A0 =A0 =A0 .size =A0 \name\()_cache_fns, . - \name\()_cache_fns
>> =A0.endm
>
> This will immediately break the kernel compilation. =A0Therefore, you=
r
> patch is incomplete and unsuitable for applying.

I was checking only with panda configuration, I will update the patch
set to take care of this.

Thank you for review comments.

--=20
regards
Ramesh Gupta G
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
