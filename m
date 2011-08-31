From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Wed, 31 Aug 2011 13:19:33 -0500
Message-ID: <4E5E7B35.9080008@gmail.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>	<1314722311.2344.64.camel@deneb.redhat.com>	<20110830172642.GE3464@e102144-lin.cambridge.arm.com>	<20110830174859.GA23098@kroah.com>	<20110830175432.GG3464@e102144-lin.cambridge.arm.com>	<5484D075-A7DA-41B7-B8FA-9B6D72A23723@freescale.com>	<20110831084922.GA8777@e102144-lin.cambridge.arm.com>	<1314798215.2344.76.camel@deneb.redhat.com>	<20110831152137.GG8777@e102144-lin.cambridge.arm.com>	<alpine.LFD.2.00.1108311332410.20358@xanadu.home> <20110831175147.GI8777@e102144-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110831175147.GI8777-SGELLbQ0bobZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Chen Peter-B29397 <B29397-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 08/31/2011 12:51 PM, Will Deacon wrote:
> On Wed, Aug 31, 2011 at 06:46:50PM +0100, Nicolas Pitre wrote:
>> On Wed, 31 Aug 2011, Will Deacon wrote:
>>
>>> On Wed, Aug 31, 2011 at 02:43:33PM +0100, Mark Salter wrote:
>>>> On Wed, 2011-08-31 at 09:49 +0100, Will Deacon wrote:
>>>>> On Wed, Aug 31, 2011 at 01:23:47AM +0100, Chen Peter-B29397 wrote:
>>>>>> One question: why this write buffer issue did not happen at UP ARM V7 platform, whose dma buffer
>>>>>> also uncache, but bufferable?
>>>>>
>>>>> Which CPU was on this platform?
>>>>
>>>> Using a 3.1.0-rc4+ kernel on a Pandaboard, and running 'hdparm -t' on a
>>>> usb disk drive, I see ~5.8MB/s read speed. Same kernel, but passing
>>>> nosmp on the commandline, I see 20.3MB/s.
>>>>
>>>> Can someone explain why nosmp would make such a difference?
>>>
>>> Oh gawd, that's horrible. I have a feeling it's probably a separate issue
>>> though, caused by:
>>>
>>> omap_modify_auxcoreboot0(0x200, 0xfffffdff);
>>>
>>> in boot_secondary for OMAP. Unfortunately I have no idea what that line is
>>> doing because it ends up talking to the secure monitor.
>>
>> Well, this issue is apparently affecting other ARMv9 implementations 
>> too.  In which case this code in arch/arm/mm/mmu.c could be responsible:
>>
>>                 if (is_smp()) {
>>                         /*
>>                          * Mark memory with the "shared" attribute
>>                          * for SMP systems
>>                          */
>>                         user_pgprot |= L_PTE_SHARED;
>>                         kern_pgprot |= L_PTE_SHARED;
>>                         vecs_pgprot |= L_PTE_SHARED;
>>                         mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
>>                         mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
>>                         mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
>>                         mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
>>                         mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
>>                         mem_types[MT_MEMORY].prot_pte |= L_PTE_SHARED;
>>                         mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
>>                         mem_types[MT_MEMORY_NONCACHED].prot_pte |= L_PTE_SHARED;
>>                 }
>>
>> However I don't see the nosmp kernel argument having any effect on the 
>> result from is_smp().
> 
> Yes, the first thing that sprung to mind was the shared attribute, but like
> you say, that doesn't seem to be affected by the nosmp command line
> argument.
> 
> Another thing that Marc and I tried on OMAP4 was not bringing up the secondary
> CPU during boot (by commenting out most of smp_init). In this case, I/O
> performance was good until we tried to online the secondary CPU. The online
> failed but after that the I/O performance was certainly degraded.
> 

Was the SCU enabled at that point? One diff between nosmp boot and
offlining the 2nd core would be that the SCU remains enabled in the
latter case. I think the SCU does not get enabled for nosmp.

Do we really know which write buffer the data is sitting? Some
experiments to only flush the L1 write buffer would be interesting.
Perhaps something executed on the 2nd core has a mb which doesn't help
for SMP because the other core's L1 write buffer is not flushed, but it
helps for nosmp because everything runs on 1 core and any occurrence of
a mb will flush all data out. I wouldn't expect the behavior to be so
consistent though. Could it be something is not visible to the other
core rather than not visible to the EHCI controller?

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
