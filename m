From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 08/11] OMAP3: PM: Disabled I2C4 repeated start operation
 mode
Date: Thu, 12 Nov 2009 10:40:43 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A2236D6F1F63@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-4-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-5-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-6-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-7-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-8-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-9-git-send-email-tero.kristo@nokia.com>
 <87skcky70m.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19758 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbZKLJk5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 04:40:57 -0500
In-Reply-To: <87skcky70m.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 12 November, 2009 01:30
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 08/11] OMAP3: PM: Disabled I2C4 repeated 
>start operation mode
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> Repeated start forces I2C4 pads low during idle, which 
>increases power
>> consumption through external pull-ups. On the other hand, this change
>> increases I2C4 command latencies a bit.
>
>Could you give an idea about how much the latencies increased?

There is an additional master code (= 10 bits with start + ack) transmitted in the beginning of each I2C4 transmission. It is transmitted in fast/standard mode instead of high-speed, thus the duration of each I2C command is approximately doubled, from 25us to 50us. I'll update the patch description a bit and re-send.

>
>I'll apply this one but would like to update the changelog with some
>more details if available.
>
>Kevin
>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> ---
>>  arch/arm/mach-omap2/pm34xx.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c 
>b/arch/arm/mach-omap2/pm34xx.c
>> index fec9c38..154cd31 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -1219,7 +1219,7 @@ static void __init configure_vc(void)
>>  	prm_write_mod_reg(OMAP3430_CMD1 | OMAP3430_RAV1, 
>OMAP3430_GR_MOD,
>>  			  OMAP3_PRM_VC_CH_CONF_OFFSET);
>>  
>> -	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN 
>| OMAP3430_SREN,
>> +	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN,
>>  			  OMAP3430_GR_MOD,
>>  			  OMAP3_PRM_VC_I2C_CFG_OFFSET);
>>  
>> -- 
>> 1.5.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>