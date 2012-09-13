From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: Re: [PATCH v5 2/2] OMAP:IOMMU:flush L1 and L2 caches
Date: Thu, 13 Sep 2012 10:04:09 +0530
Message-ID: <CADysL2YgZ4E8ZLDnA4zn-bvXiaF--TrgQvPsTgBpKm7VQnSwuw@mail.gmail.com>
References: <CADysL2bb+LC1ySgkp8Hd_VL8GaFJ_gsuMF=WkmWp+YTdJqKJ4A@mail.gmail.com>
	<20120912164121.GF28448@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120912164121.GF28448@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Hi Russell,


On Wed, Sep 12, 2012 at 10:11 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Sep 12, 2012 at 08:49:16PM +0530, Gupta, Ramesh wrote:
>> Thanks to the RMK's suggestions.
>
> I should've made clear the distinction between _range and _area.
> A _range function takes start and end.  An _area function takes a start
> and size.  So...
>
>> -static void flush_iopgd_range(u32 *first, u32 *last)
>> +static void flush_iopgd_range(u32 *first, size_t size)
>
> This should change to flush_iopgd_area().

Looks like I missed this, I will fix and send the updated patch.

>
>>  {
>> -     /* FIXME: L2 cache should be taken care of if it exists */
>> -     do {
>> -             asm("mcr        p15, 0, %0, c7, c10, 1 @ flush_pgd"
>> -                 : : "r" (first));
>> -             first += L1_CACHE_BYTES / sizeof(*first);
>> -     } while (first <= last);
>> +     phys_addr_t phys = virt_to_phys(first);
>> +
>> +     iommu_flush_area(first, size);
>> +     outer_flush_range(phys, phys + size);
>>  }
>>
>> -static void flush_iopte_range(u32 *first, u32 *last)
>> +static void flush_iopte_range(u32 *first, size_t size)
>> +
>
> flush_iopte_area().  (And there shouldn't be a blank line between this
> and the open curley.)

I will fix it.

> Otherwise, looks fine.

thank you.


Best regards
Ramesh Gupta G
