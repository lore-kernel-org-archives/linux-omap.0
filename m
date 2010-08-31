From: kishon <a0393678@ti.com>
Subject: Re: [RFC: PATCH] OMAP: hwmod: New API to modify the autoidle bits
 of sysconfig register
Date: Tue, 31 Aug 2010 10:53:36 +0530
Message-ID: <4C7C91D8.5030809@ti.com>
References: <1282823155-18328-1-git-send-email-kishon@ti.com> <878w3o9l6f.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56069 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753740Ab0HaFXq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Aug 2010 01:23:46 -0400
In-Reply-To: <878w3o9l6f.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Basak, Partha" <p-basak2@ti.com>



On Monday 30 August 2010 08:56 PM, Kevin Hilman wrote:
> Kishon Vijay Abraham I<kishon@ti.com>  writes:
>
>    
>> Though the sysconfig register values shouldn't be modified directly by
>> the driver, MCBSP should be considered a special case where sysconfig
>> registers need to be modified dynamically by the driver.
>>
>> For e.g MCBSP 2 and 3 in OMAP3 has sidetone feature which requires
>> autoidle to be disabled before starting the sidetone.
>>
>> This patch creates a new API that forms a wrapper to
>> _set_module_autoidle() to modify the AUTOIDLE bit.
>>      
> Since driver should not be using hwmod directly, how is this API going
> to be used?  Will this only be called from arch/arm/mach-omap2/mcbsp.c?
>    
     Though driver shouldn't be using hwmod directly, there is no 
corresponding API in omap_device to do the same. So we are planning to
     store the omap_hwmod structure in platform_data during 
arch_initcall (in the callback to omap_hwmod_for_each_by_class). So 
whenever the
     AUTOIDLE bits need to be reset or set, we pass the stored 
omap_hwmod structure to this API. Currently, the functions that needs 
AUTOIDLE
     bit to be modified (omap_st_on, omap_st_off) resides in plat-omap.

     -Kishon
>    
>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>> Signed-off-by: Charulatha V<charu@ti.com>
>> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
>>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> Cc: Partha Basak<p-basak2@ti.com>
>>      
> Subject should contain prefix like 'OMAP: hwmod: ...'
>
> Kevin
>
>    
>> ---
>>   arch/arm/mach-omap2/omap_hwmod.c             |   29 ++++++++++++++++++++++++++
>>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
>>   2 files changed, 30 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index 9bd99ad..0d38404 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -969,6 +969,35 @@ int _omap_hwmod_idle(struct omap_hwmod *oh)
>>   }
>>
>>   /**
>> + * omap_hwmod_set_module_autoidle - set the hwmod's OCP slave autoidle
>> + * @oh: struct omap_hwmod *
>> + * @autoidle: desired AUTOIDLE bitfield value (0 or 1)
>> + *
>> + * Sets the IP block's OCP slave autoidle in hardware, and updates our
>> + * local copy. Intended to be used by drivers that have some erratum
>> + * that requires direct manipulation of the AUTOIDLE bits.  Returns
>> + * -EINVAL if @oh is null, or passes along the return value from
>> + * _set_module_autoidle().
>> + */
>> +int omap_hwmod_set_module_autoidle(struct omap_hwmod *oh, u8 autoidle)
>> +{
>> +	u32 v;
>> +	int retval = 0;
>> +
>> +	if (!oh)
>> +		return -EINVAL;
>> +
>> +	v = oh->_sysc_cache;
>> +
>> +	retval = _set_module_autoidle(oh, autoidle,&v);
>> +
>> +	if (!retval)
>> +		_write_sysconfig(v, oh);
>> +
>> +	return retval;
>> +}
>> +
>> +/**
>>    * _shutdown - shutdown an omap_hwmod
>>    * @oh: struct omap_hwmod *
>>    *
>> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> index 6adbb63..7042b86 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> @@ -526,6 +526,7 @@ int omap_hwmod_hardreset_deassert(struct omap_hwmod *oh, const char *name);
>>   int omap_hwmod_hardreset_state(struct omap_hwmod *oh, const char *name);
>>
>>   int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
>> +int omap_hwmod_set_module_autoidle(struct omap_hwmod *oh, u8 autoidle);
>>
>>   int omap_hwmod_reset(struct omap_hwmod *oh);
>>   void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
>>      
