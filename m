From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH RFC] OMAP2PLUS: Enable HIGHMEM
Date: Thu, 02 Jun 2011 19:24:44 +0530
Message-ID: <4DE79624.5080804@ti.com>
References: <1307016381-21878-1-git-send-email-santosh.shilimkar@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D2D2801@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:37041 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752401Ab1FBNyz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 09:54:55 -0400
Received: by mail-yw0-f44.google.com with SMTP id 31so483941ywp.17
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 06:54:52 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D2D2801@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 6/2/2011 6:51 PM, Premi, Sanjeev wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>> Shilimkar, Santosh
>> Sent: Thursday, June 02, 2011 5:36 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Shilimkar, Santosh
>> Subject: [PATCH RFC] OMAP2PLUS: Enable HIGHMEM
>>
>> HIGMEM support is kernel is quite mature now and we have boards
> [sp]             ^^ replace with "in"
yep. I sent that update in next email.

>
>> like ZOOM, PANDA, SDP where 1 GB memories are installed.
>>
>> Enable HIGMEM to make use of the additional memory.
>>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> ---
>> This won't boards which doesn't have excess memory. Tested
>> on OMAP4430 SDP
>
> [sp] Comment is unclear on what happens on the boards with
>       lesser memories esp. since the change will impact all
>       boards. You may want to explain.
>

On the boards which doesn't have more than 768 MB memory, all the memory
is directly mapped in "lowmem" and highmem isn't exercised.


>>
>>   arch/arm/mach-omap2/Kconfig |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>> index 19d5891..25e819e 100644
>> --- a/arch/arm/mach-omap2/Kconfig
>> +++ b/arch/arm/mach-omap2/Kconfig
>> @@ -19,6 +19,7 @@ config ARCH_OMAP2PLUS_TYPICAL
>>   	select MENELAUS if ARCH_OMAP2
>>   	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
>>   	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
>> +	select HIGHMEM
>>   	help
>>   	  Compile a kernel suitable for booting most boards
>>
>> --
>> 1.6.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

