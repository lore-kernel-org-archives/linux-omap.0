From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCHv5 06/14] remoteproc/omap: Initialize and assign reserved
 memory node
Date: Thu, 30 Jan 2020 14:20:31 -0500
Message-ID: <a0e85451-7c05-884c-4997-b4e8c5684c3e@ti.com>
References: <20200116135332.7819-1-t-kristo@ti.com>
 <20200116135332.7819-7-t-kristo@ti.com>
 <249c293c-6a23-165f-1df5-4859ee47658a@ti.com>
 <37db5d57-b1cd-1cec-2c9b-31c49e3bdc10@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <37db5d57-b1cd-1cec-2c9b-31c49e3bdc10@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, s-anna@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 1/30/20 2:18 PM, Tero Kristo wrote:
> On 30/01/2020 20:11, Andrew F. Davis wrote:
>> On 1/16/20 8:53 AM, Tero Kristo wrote:
>>> From: Suman Anna <s-anna@ti.com>
>>>
>>> The reserved memory nodes are not assigned to platform devices by
>>> default in the driver core to avoid the lookup for every platform
>>> device and incur a penalty as the real users are expected to be
>>> only a few devices.
>>>
>>> OMAP remoteproc devices fall into the above category and the OMAP
>>> remoteproc driver _requires_ specific CMA pools to be assigned
>>> for each device at the moment to align on the location of the
>>> vrings and vring buffers in the RTOS-side firmware images. So,
>>
>>
>> Same comment as before, this is a firmware issue for only some firmwares
>> that do not handle being assigned vring locations correctly and instead
>> hard-code them.
> 
> I believe we discussed this topic in length in previous version but
> there was no conclusion on it.
> 
> The commit desc might be a bit misleading, we are not actually forced to
> use specific CMA buffers, as we use IOMMU to map these to device
> addresses. For example IPU1/IPU2 use internally exact same memory
> addresses, iommu is used to map these to specific CMA buffer.
> 
> CMA buffers are mostly used so that we get aligned large chunk of memory
> which can be mapped properly with the limited IOMMU OMAP family of chips
> have. Not sure if there is any sane way to get this done in any other
> manner.
> 


Why not use the default CMA area?

Andrew


> -Tero
> 
>>
>> This is not a requirement of the remote processor itself and so it
>> should not fail to probe if a specific memory carveout isn't given.
>>
>>
>>> use the of_reserved_mem_device_init/release() API appropriately
>>> to assign the corresponding reserved memory region to the OMAP
>>> remoteproc device. Note that only one region per device is
>>> allowed by the framework.
>>>
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> ---
>>> v5: no changes
>>>
>>>   drivers/remoteproc/omap_remoteproc.c | 12 +++++++++++-
>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/remoteproc/omap_remoteproc.c
>>> b/drivers/remoteproc/omap_remoteproc.c
>>> index 0846839b2c97..194303b860b2 100644
>>> --- a/drivers/remoteproc/omap_remoteproc.c
>>> +++ b/drivers/remoteproc/omap_remoteproc.c
>>> @@ -17,6 +17,7 @@
>>>   #include <linux/module.h>
>>>   #include <linux/err.h>
>>>   #include <linux/of_device.h>
>>> +#include <linux/of_reserved_mem.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/dma-mapping.h>
>>>   #include <linux/remoteproc.h>
>>> @@ -480,14 +481,22 @@ static int omap_rproc_probe(struct
>>> platform_device *pdev)
>>>       if (ret)
>>>           goto free_rproc;
>>>   +    ret = of_reserved_mem_device_init(&pdev->dev);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "device does not have specific CMA
>>> pool\n");
>>> +        goto free_rproc;
>>> +    }
>>> +
>>>       platform_set_drvdata(pdev, rproc);
>>>         ret = rproc_add(rproc);
>>>       if (ret)
>>> -        goto free_rproc;
>>> +        goto release_mem;
>>>         return 0;
>>>   +release_mem:
>>> +    of_reserved_mem_device_release(&pdev->dev);
>>>   free_rproc:
>>>       rproc_free(rproc);
>>>       return ret;
>>> @@ -499,6 +508,7 @@ static int omap_rproc_remove(struct
>>> platform_device *pdev)
>>>         rproc_del(rproc);
>>>       rproc_free(rproc);
>>> +    of_reserved_mem_device_release(&pdev->dev);
>>>         return 0;
>>>   }
>>>
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
