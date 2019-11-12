From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 06/17] remoteproc/omap: Add the rproc ops .da_to_va()
 implementation
Date: Tue, 12 Nov 2019 10:22:39 +0200
Message-ID: <9670e8ad-4c36-2ad1-5967-931b0fc97343@ti.com>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-7-t-kristo@ti.com> <20191111232251.GH3108315@builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191111232251.GH3108315@builder>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, s-anna@ti.com
List-Id: linux-omap@vger.kernel.org

On 12/11/2019 01:22, Bjorn Andersson wrote:
> On Mon 28 Oct 05:42 PDT 2019, Tero Kristo wrote:
> 
>> From: Suman Anna <s-anna@ti.com>
>>
>> An implementation for the rproc ops .da_to_va() has been added
>> that provides the address translation between device addresses
>> to kernel virtual addresses for internal RAMs present on that
>> particular remote processor device. The implementation provides
>> the translations based on the addresses parsed and stored during
>> the probe.
>>
>> This ops gets invoked by the exported rproc_da_to_va() function
>> and allows the remoteproc core's ELF loader to be able to load
>> program data directly into the internal memories.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/remoteproc/omap_remoteproc.c | 35 ++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
>> index bbd6ff360e10..0524f7e0ffa4 100644
>> --- a/drivers/remoteproc/omap_remoteproc.c
>> +++ b/drivers/remoteproc/omap_remoteproc.c
>> @@ -230,10 +230,45 @@ static int omap_rproc_stop(struct rproc *rproc)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Internal Memory translation helper
> 
> Please format this as kerneldoc.
> 
>> + *
>> + * Custom function implementing the rproc .da_to_va ops to provide address
>> + * translation (device address to kernel virtual address) for internal RAMs
>> + * present in a DSP or IPU device). The translated addresses can be used
>> + * either by the remoteproc core for loading, or by any rpmsg bus drivers.
>> + */
>> +static void *omap_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
>> +{
>> +	struct omap_rproc *oproc = rproc->priv;
>> +	void *va = NULL;
>> +	int i;
>> +	u32 offset;
>> +
>> +	if (len <= 0)
>> +		return NULL;
>> +
>> +	if (!oproc->num_mems)
>> +		return NULL;
>> +
>> +	for (i = 0; i < oproc->num_mems; i++) {
>> +		if (da >= oproc->mem[i].dev_addr && da + len <=
>> +		    oproc->mem[i].dev_addr +  oproc->mem[i].size) {
>> +			offset = da -  oproc->mem[i].dev_addr;
>> +			/* __force to make sparse happy with type conversion */
>> +			va = (__force void *)(oproc->mem[i].cpu_addr + offset);
> 
> Replace va = and break; with just a return here.

Right, va seems to be completely redundant local variable.

> 
>> +			break;
>> +		}
>> +	}
>> +
>> +	return va;
> 
> return NULL here.

Yep will do.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
