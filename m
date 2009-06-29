From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] OMAP2/3: DMA errata correction
Date: Mon, 29 Jun 2009 18:29:54 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F54DB0D5@dbde02.ent.ti.com>
References: <1245995252-16453-1-git-send-email-vikram.pandita@ti.com>
 <DFEF307E035C8647B119E6A60DB62D4A0199C96043@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47588 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbZF2NAD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 09:00:03 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5TD00rH007929
	for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 08:00:06 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n5TCxxW5000132
	for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 18:29:59 +0530 (IST)
In-Reply-To: <DFEF307E035C8647B119E6A60DB62D4A0199C96043@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kamat, Nishant" <nskamat@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>From: Kamat, Nishant
>
>Vikram,
>
>> From: linux-omap-owner@vger.kernel.org
>>
>> This errata is valid for:
>> OMAP2420 Errata 1.85 Impacts all 2420 ES rev
>> OMAP2430 Errata 1.10 Impacts only ES1.0
>> Description: DMA may hang when several channels are used in parallel
>>
>> OMAP3430: Not impacted, so remove the errata fix for omap3
>>
>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>> ---
>>  arch/arm/plat-omap/dma.c |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
>> index 7677a4a..feebaf3 100644
>> --- a/arch/arm/plat-omap/dma.c
>> +++ b/arch/arm/plat-omap/dma.c
>> @@ -946,7 +946,9 @@ void omap_start_dma(int lch)
>>
>>  			cur_lch = next_lch;
>>  		} while (next_lch != -1);
>> -	} else if (cpu_class_is_omap2()) {
>> +	} else if (cpu_is_omap24xx() ||
>
>
>This should be  cpu_is_omap242x() || ...

Good catch. Re-spinning v2 of patch.

>
>
>Regards,
>Nishant
>
>
>
>
>> +		(cpu_is_omap243x() &&  omap_type() <=
>> OMAP2430_REV_ES1_0)) {
>> +
>>  		/* Errata: Need to write lch even if not using
>> chaining */
>>  		dma_write(lch, CLNK_CTRL(lch));
>>  	}
>> --
>> 1.6.3.3.334.g916e1
