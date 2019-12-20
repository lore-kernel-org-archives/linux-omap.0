From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 09/15] remoteproc/omap: Remove the
 omap_rproc_reserve_cma declaration
Date: Fri, 20 Dec 2019 11:49:35 +0200
Message-ID: <c975de56-a6c6-a2d7-9eda-d075fad496d8@ti.com>
References: <20191213125537.11509-1-t-kristo@ti.com>
 <20191213125537.11509-10-t-kristo@ti.com>
 <75420692-ecbc-f7cd-f7bc-9df0849d91dc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <75420692-ecbc-f7cd-f7bc-9df0849d91dc@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 20/12/2019 04:47, Suman Anna wrote:
> Hi Tero,
> 
> On 12/13/19 6:55 AM, Tero Kristo wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> The omap_rproc_reserve_cma() function is not defined at the moment.
>> This prototype was to be used to define a function to declare a
>> remoteproc device-specific CMA pool.
>>
>> The remoteproc devices will be defined through DT going forward. A
>> device specific CMA pool will be defined under the reserved-memory
>> node, and will be associated with the appropriate remoteproc device
>> node. This function prototype will no longer be needed and has
>> therefore been cleaned up.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> With the structure removed, you can actually drop the file altogether.

Yeah, let me check that out.

-Tero

> 
> regards
> Suman
> 
>> ---
>>   include/linux/platform_data/remoteproc-omap.h | 12 ------------
>>   1 file changed, 12 deletions(-)
>>
>> diff --git a/include/linux/platform_data/remoteproc-omap.h b/include/linux/platform_data/remoteproc-omap.h
>> index 6bea01e199fe..49c78805916f 100644
>> --- a/include/linux/platform_data/remoteproc-omap.h
>> +++ b/include/linux/platform_data/remoteproc-omap.h
>> @@ -21,16 +21,4 @@ struct omap_rproc_pdata {
>>   	int (*device_shutdown)(struct platform_device *pdev);
>>   };
>>   
>> -#if defined(CONFIG_OMAP_REMOTEPROC) || defined(CONFIG_OMAP_REMOTEPROC_MODULE)
>> -
>> -void __init omap_rproc_reserve_cma(void);
>> -
>> -#else
>> -
>> -static inline void __init omap_rproc_reserve_cma(void)
>> -{
>> -}
>> -
>> -#endif
>> -
>>   #endif /* _PLAT_REMOTEPROC_H */
>>
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
