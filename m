From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix OMAP_CHIP_INIT usage
Date: Thu, 14 May 2009 10:09:09 -0700
Message-ID: <874ovnvcga.fsf@deeprootsystems.com>
References: <1240479787-16921-1-git-send-email-kalle.jokiniemi@digia.com>
	<1240479787-16921-2-git-send-email-kalle.jokiniemi@digia.com>
	<alpine.DEB.2.00.0904231720270.6673@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:38364 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbZENRJL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 13:09:11 -0400
Received: by pxi29 with SMTP id 29so672889pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 10:09:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0904231720270.6673@utopia.booyaka.com> (Paul Walmsley's message of "Thu\, 23 Apr 2009 17\:21\:22 -0600 \(MDT\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> On Thu, 23 Apr 2009, Kalle Jokiniemi wrote:
>
>> Some modules have been specified only to exist in ES2.0
>> devices while they should exist on >= ES2.0 devices.
>> Fixed OMAP_CHIP_INIT() calls to take this to account.
>> 
>> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
>
> At least the omapdev3xxx.h changes are:
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
>
> This patch is specific to the PM branch.
>

Pushing to PM branch today.

Kevin

>
>> ---
>>  arch/arm/mach-omap2/omapdev3xxx.h  |    8 ++++----
>>  arch/arm/mach-omap2/resource34xx.h |    4 ++--
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/omapdev3xxx.h b/arch/arm/mach-omap2/omapdev3xxx.h
>> index dce87df..d2772c4 100644
>> --- a/arch/arm/mach-omap2/omapdev3xxx.h
>> +++ b/arch/arm/mach-omap2/omapdev3xxx.h
>> @@ -374,7 +374,7 @@ static struct omapdev neon_3xxx_omapdev = {
>>  static struct omapdev sgx_3xxx_omapdev = {
>>  	.name		= "sgx_omapdev",
>>  	.pwrdm		= { .name = "sgx_pwrdm" },
>> -	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
>> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
>>  };
>>  
>>  /* CORE */
>> @@ -435,7 +435,7 @@ static struct omapdev hsmmc3_3xxx_omapdev = {
>>  	.pwrdm		= { .name = "core_pwrdm" },
>>  	.pdev_name	= "mmci-omap",
>>  	.pdev_id	= 2,
>> -	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
>> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
>>  };
>>  
>>  static struct omapdev mcspi4_3xxx_omapdev = {
>> @@ -658,7 +658,7 @@ static struct omapdev usbhost_3xxx_omapdev = {
>>  	.pwrdm		= { .name = "usbhost_pwrdm" },
>>  	.pdev_name	= "ehci-omap",
>>  	.pdev_id	= 0,
>> -	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
>> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
>>  };
>>  
>>  static struct omapdev usbotg_3xxx_omapdev = {
>> @@ -666,7 +666,7 @@ static struct omapdev usbotg_3xxx_omapdev = {
>>  	.pwrdm		= { .name = "usbhost_pwrdm" },
>>  	.pdev_name	= "musb_hdrc",
>>  	.pdev_id	= -1,
>> -	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
>> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
>>  };
>>  
>>  static struct omapdev usbtll_3xxx_omapdev = {
>> diff --git a/arch/arm/mach-omap2/resource34xx.h b/arch/arm/mach-omap2/resource34xx.h
>> index b847208..8d95a00 100644
>> --- a/arch/arm/mach-omap2/resource34xx.h
>> +++ b/arch/arm/mach-omap2/resource34xx.h
>> @@ -133,7 +133,7 @@ static struct shared_resource gfx_pwrdm_latency = {
>>  
>>  static struct shared_resource sgx_pwrdm_latency = {
>>  	.name 		= "sgx_pwrdm_latency",
>> -	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
>> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
>>  	.resource_data  = &sgx_pwrdm_lat_db,
>>  	.ops		= &pd_lat_res_ops,
>>  };
>> @@ -208,7 +208,7 @@ static struct pd_latency_db usbhost_pwrdm_lat_db = {
>>  
>>  static struct shared_resource usbhost_pwrdm_latency = {
>>  	.name		= "usbhost_pwrdm_latency",
>> -	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
>> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
>>  	.resource_data  = &usbhost_pwrdm_lat_db,
>>  	.ops		= &pd_lat_res_ops,
>>  };
>> -- 
>> 1.5.4.3
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>
>
> - Paul
