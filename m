From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [PATCH 1/1] MMC: OMAP: Fix HSMMC driver name at host driver.
Date: Wed, 26 Mar 2008 15:12:16 -0400
Message-ID: <47EAA010.7060101@indt.org.br>
References: <47E2C7FE.9020908@indt.org.br> <20080320225441.GA4373@kedavra.cpe.vivax.com.br> <005901c88d6d$08f932c0$ca8818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55685 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbYCZTQE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Mar 2008 15:16:04 -0400
In-Reply-To: <005901c88d6d$08f932c0$ca8818ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: me@felipebalbi.com, 'Tony Lindgren' <tony@atomide.com>, linux-omap@vger.kernel.org

ext Madhusudhan Chikkature Rajashekar wrote:
>  
>
>   
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi
>> Sent: Friday, March 21, 2008 4:25 AM
>> To: Carlos Aguiar
>> Cc: Tony Lindgren; linux-omap@vger.kernel.org
>> Subject: Re: [PATCH 1/1] MMC: OMAP: Fix HSMMC driver name at 
>> host driver.
>>
>> On Thu, Mar 20, 2008 at 04:24:30PM -0400, Carlos Aguiar wrote:
>>     
>>> From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
>>>
>>> This patch fixes the HSMMC driver name at host driver.
>>>
>>> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
>>> ---
>>>  drivers/mmc/host/omap_hsmmc.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c 
>>>       
>> b/drivers/mmc/host/omap_hsmmc.c
>>     
>>> index 047c64d..0e7ee20 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>> @@ -92,7 +92,7 @@
>>>  #define OMAP_MMC_DATADIR_WRITE	2
>>>  #define MMC_TIMEOUT_MS		20
>>>  #define OMAP_MMC_MASTER_CLOCK	96000000
>>> -#define DRIVER_NAME		"mmci-omap"
>>> +#define DRIVER_NAME		"hsmmc-omap"
>>>       
>> stupid question :-p
>> what does the 'i' means?
>>     
> I think it is a simple mistake. The change you have done makes sense for the HSMMC driver.
>
>   
>> -- 
>> Best Regards,
>>
>> Felipe Balbi
>> me@felipebalbi.com
>> http://blog.felipebalbi.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>     
>
>
>   
Hi Tony,

Please, don't apply this patch into the tree due some conflicts with
such driver host names for 2420 (mmci-omap) and 2430 and 3430
(hsmmc-omap) boards. Explaining: on arch/arm/plat-omap/devices.c, I sent
a patch [1] that proposes the following change:

...
#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
#define OMAP_MMC_NAME "hsmmc-omap"

#define OMAP_MMC1_BASE 0x4809c000
#define OMAP_MMC1_END OMAP_MMC1_BASE + 0x1fc
#define OMAP_MMC1_INT INT_24XX_MMC_IRQ

#define OMAP_MMC2_BASE 0x480b4000
#define OMAP_MMC2_END OMAP_MMC2_BASE + 0x1fc
#define OMAP_MMC2_INT INT_24XX_MMC_IRQ

#else

#define OMAP_MMC_NAME "mmci-omap"
...

But, the host driver name is mmci-omap for 2420 boards (like N800), so
that images compiled with this patch will not start the MMC slots :(

Anyway, I think for now let's keep all driver hosts with name
'mmci-omap' in order keep all working and I'm going to resend this patch
removing the defines OMAP_MMC_NAME and make some corrections into such
patch.

I hope I was clear and thanks for the comprehension.

BR,

Carlos.

[1] http://marc.info/?l=linux-omap&m=120602333813488&w=2

-- 
Carlos Eduardo Aguiar
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC - Manaus
Core Team
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br

