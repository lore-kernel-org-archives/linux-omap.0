From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 01/13] OMAP: hwmod: Add member 'name' to omap_hwmod_addr_space
 struct
Date: Fri, 4 Feb 2011 21:21:48 +0100
Message-ID: <4D4C5FDC.7050008@ti.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>	<1296485437-12806-2-git-send-email-kishon@ti.com> <8762szpor3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40489 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112Ab1BDUV4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Feb 2011 15:21:56 -0500
In-Reply-To: <8762szpor3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "paul@pwsan.com" <paul@pwsan.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Basak, Partha" <p-basak2@ti.com>

On 2/4/2011 8:45 PM, Hilman, Kevin wrote:
> Kishon Vijay Abraham I<kishon@ti.com>  writes:
>
>> Adds a structure member 'name' to 'omap_hwmod_addr_space' structure.
>> The drivers can use platform_get_resource_byname() to get resource of
>> type 'IORESOURCE_MEM' by name so that it need not rely on the order to get
>> the proper resource.
>>
>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod.c             |    1 +
>>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +++-
>>   2 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index 709543a..7bd4900 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -1898,6 +1898,7 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
>>   		os = oh->slaves[i];
>>
>>   		for (j = 0; j<  os->addr_cnt; j++) {
>> +			(res + r)->name = (os->addr + j)->name;
>>   			(res + r)->start = (os->addr + j)->pa_start;
>>   			(res + r)->end = (os->addr + j)->pa_end;
>>   			(res + r)->flags = IORESOURCE_MEM;
>> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> index 76f0274..85899a7 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> @@ -178,7 +178,8 @@ struct omap_hwmod_omap2_firewall {
>>   #define ADDR_TYPE_RT		(1<<  1)
>>
>>   /**
>> - * struct omap_hwmod_addr_space - MPU address space handled by the hwmod
>> + * struct omap_hwmod_addr_space - address space handled by the hwmod
>
> Any reason you modified the comment here?

The idea of that patch is to allow hwmod to provide address space 
accessible from SDMA (though L3). Hence the suppression of the MPU.
In the future, we might even be able to provide the address for the DSP 
or the IPU viewpoint

Regards,
Benoit

>
> Kevin
>
>> + * @name: name of the address space
>>    * @pa_start: starting physical address
>>    * @pa_end: ending physical address
>>    * @flags: (see omap_hwmod_addr_space.flags macros above)
>> @@ -187,6 +188,7 @@ struct omap_hwmod_omap2_firewall {
>>    * structure.  GPMC is one example.
>>    */
>>   struct omap_hwmod_addr_space {
>> +	const char *name;
>>   	u32 pa_start;
>>   	u32 pa_end;
>>   	u8 flags;

