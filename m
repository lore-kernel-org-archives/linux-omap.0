From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v3 2/2] remoteproc: add support to handle internal memories
Date: Wed, 11 Feb 2015 18:01:45 -0600
Message-ID: <54DBED69.6070206@ti.com>
References: <1420838519-15669-1-git-send-email-s-anna@ti.com> <1420838519-15669-3-git-send-email-s-anna@ti.com> <CAK=WgbaFoUpV315Tg1q=PGc-FkCvKBz2BmO8Fkj_FHa5UuWviw@mail.gmail.com> <20150211205757.GI2531@atomide.com> <54DBD7A3.9020604@ti.com> <20150211224841.GK2531@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150211224841.GK2531@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Kevin Hilman <khilman@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, Robert Tivy <rtivy@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 02/11/2015 04:48 PM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [150211 14:32]:
>> On 02/11/2015 02:57 PM, Tony Lindgren wrote:
>>> * Ohad Ben-Cohen <ohad@wizery.com> [150210 02:14]:
>>>> Hi Suman,
>>>>
>>>> On Fri, Jan 9, 2015 at 11:21 PM, Suman Anna <s-anna@ti.com> wrote:
>>>>> A remote processor may need to load certain firmware sections into
>>>>> internal memories (eg: RAM at L1 or L2 levels) for performance or
>>>>> other reasons. Introduce a new resource type (RSC_INTMEM) and add
>>>>> an associated handler function to handle such memories. The handler
>>>>> creates a kernel mapping for the resource's 'pa' (physical address).
>>>> ...
>>>>> + * rproc_handle_intmem() - handle internal memory resource entry
>>>>> + * @rproc: rproc handle
>>>>> + * @rsc: the intmem resource entry
>>>>> + * @offset: offset of the resource data in resource table
>>>>> + * @avail: size of available data (for image validation)
>>>>> + *
>>>>> + * This function will handle firmware requests for mapping a memory region
>>>>> + * internal to a remote processor into kernel. It neither allocates any
>>>>> + * physical pages, nor performs any iommu mapping, as this resource entry
>>>>> + * is primarily used for representing physical internal memories. If the
>>>>> + * internal memory region can only be accessed through an iommu, please
>>>>> + * use a devmem resource entry.
>>>>> + *
>>>>> + * These resource entries should be grouped near the carveout entries in
>>>>> + * the firmware's resource table, as other firmware entries might request
>>>>> + * placing other data objects inside these memory regions (e.g. data/code
>>>>> + * segments, trace resource entries, ...).
>>>>> + */
>>>>> +static int rproc_handle_intmem(struct rproc *rproc, struct fw_rsc_intmem *rsc,
>>>>> +                              int offset, int avail)
>>>>> +{
>>>> ...
>>>>> +       va = (__force void *)ioremap_nocache(rsc->pa, rsc->len);
>>>>
>>>> Back in the days when we developed remoteproc there was a tremendous
>>>> effort to move away from ioremap when not strictly needed.
>>>
>>> The use of ioremap in general is just fine for drivers as long
>>> as they access a dedicated area to the specific device. Accessing
>>> random registers and memory in the SoC is what I'm worried about.
>>>  
>>>> I'd be happy if someone intimate with the related hardware could ack
>>>> that in this specific case ioremap is indeed needed. No need to review
>>>> the entire patch, or anything remoteproc, just make sure that
>>>> generally ioremap is how we want to access this internal memory.
>>>>
>>>> Tony or Kevin any chance you could take a look and ack?
>>>>
>>>> If ioremap is indeed the way to go, I'd also expect that we wouldn't
>>>> have to use __force here, but that's probably a minor patch cleanup.
>>>
>>> Hmm sounds like this memory should be dedicated to the accelerator?
>>>
>>> In that case it should use memblock to reserve that area early so
>>> the kernel won't be accessing it at all.
>>
>> The usage here is not really on regular memory, but on internal device
>> memory (eg: L2RAM within DSP which is accessible by MPU through L3 bus).
>> For the regular shared memory for vrings and vring buffers, the
>> remoteproc core does rely on CMA pools.
> 
> OK sounds like Linux needs to access it initially to load the DSP boot
> code to L2RAM to get the DSP booted.
> 
> Maybe it can be done with the API provided by drivers/misc/sram.c?
> 
> You could set up the L2RAM as compatible = "mmio-sram" and then
> parse the optional phandle for that in the remoteproc code, then
> allocate some memory from it to load the DSP boot code and free
> it.

Not quite the same usage, there are no implicit assumptions on managing
this memory. Isn't the SRAM driver better suited for allocating memory
using the gen_pool API. It is just regular code that is being placed
into RAM, and the linker file on the remoteproc side dictates which
portion we are using. So, the section can be anywhere based on the ELF
parsing. Further, the same RAM space can be partitioned into Cache
and/or RAM, which is usually controlled from internal processor
subsystem register programming.

regards
Suman
