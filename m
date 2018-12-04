From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 01/16] remoteproc: Extend rproc_da_to_va() API with a
 flags parameter
Date: Tue, 4 Dec 2018 12:03:51 +0200
Message-ID: <5C065107.8080600@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-2-git-send-email-rogerq@ti.com>
 <d93c4c96-e0b9-59cd-6098-92684bc2360b@lechnology.com>
 <5BFFBFA0.9000104@ti.com>
 <ec83108c-1748-cec4-bebf-119d261fb229@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ec83108c-1748-cec4-bebf-119d261fb229@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com
Cc: tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 29/11/18 18:12, David Lechner wrote:
> On 11/29/18 4:29 AM, Roger Quadros wrote:
>> Bjorn, Suman,
>>
>> On 26/11/18 23:29, David Lechner wrote:
>>> On 11/26/18 1:52 AM, Roger Quadros wrote:
>>>> From: Suman Anna <s-anna@ti.com>
>>>>
>>>> The rproc_da_to_va() API is currently used to perform any device
>>>> to kernel address translations to meet the different needs of the
>>>> remoteproc core/platform drivers (eg: loading). The function also
>>>> invokes the da_to_va ops, if present, to allow the remoteproc
>>>> platform drivers to provide address translation. However, not all
>>>> platform implementations have linear address spaces, and may need
>>>> an additional parameter to be able to perform proper translations.
>>>>
>>>> The rproc_da_to_va() API and the rproc .da_to_va ops have therefore
>>>> been expanded to take in an additional flags field enabling some
>>>> remoteproc implementations (like the TI PRUSS remoteproc driver)
>>>> to use these flags. Also, define some semantics for this flags
>>>> argument as this can vary from one implementation to another. A
>>>> new flags type is encoded into the upper 16 bits along side the
>>>> actual value in the lower 16-bits for the flags argument, to
>>>> allow different individual implementations to have better
>>>> flexibility in interpreting the flags as per their needs.
>>>
>>> This seems like an overly complex solution for a rather simple
>>> problem. Instead of passing all sorts of flags, could we just add
>>> a parameter named "page" to da_to_va() that indicates the memory
>>> page of the address in the remote processor?
>>>
>>> Or perhaps there is some other use for all of these flags that I
>>> am not aware of?
>>
>> I'm not a big fan of this patch either.
>>
>> rproc_da_to_va() is used at the following places
>>
>> 2 qcom_q6v5_mss.c         qcom_q6v5_dump_segment           974 void *ptr = rproc_da_to_va(rproc, segment->da, segment->size,
>> 3 remoteproc_core.c       rproc_da_to_va                   197 void *rproc_da_to_va(struct rproc *rproc, u64 da, int len, u32 flags)
>> 4 remoteproc_core.c       rproc_handle_trace               582 ptr = rproc_da_to_va(rproc, rsc->da, rsc->len, RPROC_FLAGS_NONE);
>> 5 remoteproc_core.c       rproc_coredump                  1592 ptr = rproc_da_to_va(rproc, segment->da, segment->size,
>> 6 remoteproc_elf_loader.c rproc_elf_load_segments          185 ptr = rproc_da_to_va(rproc, da, memsz,
>> 7 remoteproc_elf_loader.c rproc_elf_find_loaded_rsc_table  337 return rproc_da_to_va(rproc, shdr->sh_addr, shdr->sh_size,
>>
>> At rproc_elf_load_segments() we need to pass enough information so that
>> the rproc driver can load the segment into proper area (IRAM vs DRAM).
>> So providing page should suffice.
> 
> FYI, the PRU series I sent a while back has some patches to do
> something like this so feel free to use them if they are helpful.
> 
> https://lore.kernel.org/lkml/20180623210810.21232-2-david@lechnology.com/
> https://lore.kernel.org/lkml/20180623210810.21232-3-david@lechnology.com/
> 

Thanks. I think we need to do something like that. Too bad you had to reverse engineer
the TI specific headers. I'll check if we have this available somewhere internally.

>>
>> I want to understand more about rproc_elf_find_loaded_rsc_table() myself.
>> rproc_elf_find_loaded_rsc_table() is called only in rproc_start() in remoteproc_core.c
>> with the comment
>>
>>          /*
>>           * The starting device has been given the rproc->cached_table as the
>>           * resource table. The address of the vring along with the other
>>           * allocated resources (carveouts etc) is stored in cached_table.
>>           * In order to pass this information to the remote device we must copy
>>           * this information to device memory. We also update the table_ptr so
>>           * that any subsequent changes will be applied to the loaded version.
>>           */
>>          loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
>>
>> Why isn't cached_table sufficient?
>> Why do we need to call rproc_find_loaded_rsc_table()?
>>
>> why do we need to load the resource table into remote processor memory at all.
>> As discussed earlier, some PRU systems have very little memory (512 bytes?)
>> and we want to avoid unnecessary loading.
>>

This question still holds.
Suman?

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
