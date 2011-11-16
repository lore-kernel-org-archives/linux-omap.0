From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] MTD: nand: Making  MTD_NAND_OMAP2 depend on ARCH_OMAP2PLUS
Date: Wed, 16 Nov 2011 10:49:31 +0530
Message-ID: <4EC347E3.9080806@ti.com>
References: <1321352556-7080-1-git-send-email-shubhrajyoti@ti.com> <20111115175220.GA11274@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na6sys009bog018.obsmtp.com ([74.125.150.76]:46410 "EHLO
	na6sys009bog018.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752471Ab1KPFZf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Nov 2011 00:25:35 -0500
Received: by mail-yx0-f181.google.com with SMTP id m12so8869291yen.12
        for <linux-omap@vger.kernel.org>; Tue, 15 Nov 2011 21:25:35 -0800 (PST)
In-Reply-To: <20111115175220.GA11274@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 15 November 2011 11:22 PM, Russell King - ARM Linux wrote:
> On Tue, Nov 15, 2011 at 03:52:36PM +0530, Shubhrajyoti D wrote:
>> Making  MTD_NAND_OMAP2 depend on ARCH_OMAP2PLUS instead of
>> oring with ARCH2/3/4.
>>
>> Reported-by: Russell King <linux@arm.linux.org.uk>
> Thanks, but please make this rmk+kernel@arm.linux.org.uk.
yes , will correct it.
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>>  drivers/mtd/nand/Kconfig |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
>> index cce7b70..b68dd5e 100644
>> --- a/drivers/mtd/nand/Kconfig
>> +++ b/drivers/mtd/nand/Kconfig
>> @@ -110,7 +110,7 @@ config MTD_NAND_AMS_DELTA
>>  
>>  config MTD_NAND_OMAP2
>>  	tristate "NAND Flash device on OMAP2, OMAP3 and OMAP4"
>> -	depends on ARM && (ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4)
>> +	depends on ARCH_OMAP2PLUS
>>  	help
>>            Support for NAND flash on Texas Instruments OMAP2, OMAP3 and OMAP4
>>  	  platforms.
>> -- 
>> 1.7.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

