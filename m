From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH] OMAP3: PM: Fix freeze when scaling CORE dpll to < 83Mhz
Date: Fri, 10 Jul 2009 10:35:36 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0305CCD35D@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.0907091440480.8616@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36301 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996AbZGJFGA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jul 2009 01:06:00 -0400
In-Reply-To: <alpine.DEB.2.00.0907091440480.8616@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "E12499@motorola.com" <E12499@motorola.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul Walmsley
>Sent: Friday, July 10, 2009 2:14 AM
>To: Nayak, Rajendra
>Cc: E12499@motorola.com; khilman@deeprootsystems.com; 
>linux-omap@vger.kernel.org
>Subject: Re: [PATCH] OMAP3: PM: Fix freeze when scaling CORE 
>dpll to < 83Mhz
>
>Hi Rajendra,
>
>On Thu, 9 Jul 2009, Rajendra Nayak wrote:
>
>> This patch fixes a bug in the CORE dpll scaling sequence
>> which was errouneously clearing some bits in the
>> SDRC DLLA CTRL register and hence causing a freeze.
>> The issue was observed only on platforms which scale
>> CORE dpll to < 83Mhz and hence program the DLL in fixed 
>> delay mode.
>> 
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>
>Thanks, looks good, I'll queue this up for a fixes series to rmk.
>
>One question: I got an E-mail on this earlier today from Limei 
>Wang about 
>this same issue.  Looks like we should credit Limei also in this patch 
>with finding the bug.  Is this acceptable to you?

Yes, that's completely acceptable. Sorry that I missed to include him in the copy.
I just though that this was a better way to fix the issue than the patch Limei had
shared.

>
>- Paul
>
>> ---
>>  arch/arm/mach-omap2/sram34xx.S |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/sram34xx.S 
>b/arch/arm/mach-omap2/sram34xx.S
>> index 481f912..9be09a7 100644
>> --- a/arch/arm/mach-omap2/sram34xx.S
>> +++ b/arch/arm/mach-omap2/sram34xx.S
>> @@ -113,7 +113,7 @@ return_to_sdram:
>>  unlock_dll:
>>  	ldr	r11, omap3_sdrc_dlla_ctrl
>>  	ldr	r12, [r11]
>> -	and	r12, r12, #FIXEDDELAY_MASK
>> +	bic	r12, r12, #FIXEDDELAY_MASK
>>  	orr	r12, r12, #FIXEDDELAY_DEFAULT
>>  	orr	r12, r12, #DLLIDLE_MASK
>>  	str	r12, [r11]		@ (no OCP barrier needed)
>> -- 
>> 1.5.4.7
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>