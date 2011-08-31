From: Chen Peter-B29397 <B29397-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Wed, 31 Aug 2011 00:23:47 +0000
Message-ID: <5484D075-A7DA-41B7-B8FA-9B6D72A23723@freescale.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
 <1314722311.2344.64.camel@deneb.redhat.com>
 <20110830172642.GE3464@e102144-lin.cambridge.arm.com>
 <20110830174859.GA23098@kroah.com>
 <20110830175432.GG3464@e102144-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110830175432.GG3464-SGELLbQ0bobZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Content-Language: en-US
Content-ID: <9C16E5848DC547438DF7CCEAFD0B2079-KZfg59tc24wqcZcGjlUOXw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On Aug 31, 2011, at 1:54 AM, Will Deacon wrote:

> On Tue, Aug 30, 2011 at 06:48:59PM +0100, Greg KH wrote:
>> On Tue, Aug 30, 2011 at 06:26:42PM +0100, Will Deacon wrote:
>>> On Tue, Aug 30, 2011 at 05:38:30PM +0100, Mark Salter wrote:
>>>> On Wed, 2011-08-31 at 00:03 +0800, ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org wrote:
>>>>> +/*
>>>>> + * Writing to dma coherent memory on ARM may be delayed via L2
>>>>> + * writing buffer, so introduce the helper which can flush L2 writing
>>>>> + * buffer into memory immediately, especially used to flush ehci
>>>>> + * descriptor to memory.
>>>>> + * */
>>>>> +#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
>>>>> +static inline void ehci_sync_mem()
>>>>> +{
>>>>> +       mb();
>>>>> +}
>>>>> +#else
>>>>> +static inline void ehci_sync_mem()
>>>>> +{
>>>>> +}
>>>>> +#endif
>>>>> +
>>>> 
>>>> I'm wondering if this doesn't really belong in the DMA API for any
>>>> future architectures that can't avoid prolonged write buffering to DMA
>>>> coherent memory. IIUC, ARM mitigates this for most drivers by including
>>>> an implicit write buffer flush in the mmio write routines. This takes
>>>> care of the drivers which write to a mmio device register after writing
>>>> something to shared DMA memory. IIUC, this doesn't help ehci because the
>>>> host controller is polling to see what the cpu writes to the shared
>>>> memory. Other hardware which polls shared memory like that will likely
>>>> have the same problem and could use buffer drain helpers as well.
>>> 
>>> Right. In this case the buffering is happening at L2 which becomes
>>> noticeable when measuring performance. We also buffer stores at the
>>> CPU (regardless of memory type) but because these tend to become visible
>>> fairly quickly, there isn't a comparable performance problem.
>>> 
>>> Given that I would expect other architectures to buffer writes at the CPU,
>>> would it not be worth having an API for flushing to L3 (devices)? It seems
>>> like this would be a useful addition to the coherent DMA API on platforms
>>> that handle coherency with non-cacheable memory attributes.
>> 
>> I agree, this seems to be a "new" type of barrier that is needed, as the
>> code comment above seems to go against what the kernel memory barrier
>> documentation says about what a memory barrier really does on the
>> hardware.
> 
> Although this doesn't have anything to do with ordering; it's all to do with
> immediacy so I think we should try to avoiding using the term `barrier'. If
> this can be made part of the coherent DMA API, that might be the best place
> for it (I can't think of any other areas this is needed given that the
> streaming DMA API and I/O accessors already deal with it).
I am agree with you. I met the same issue at both usb device driver (adding next dTD pointer which
the current one is handling) and usb host driver (performance issue this thread have discussed) at
Freescale i.MX6Q platform (4 Cores, ARM SMP).
So, now I need to add two barriers at two different drivers.

One question: why this write buffer issue did not happen at UP ARM V7 platform, whose dma buffer
also uncache, but bufferable?

> 
> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Best Regard,
Peter Chen
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
