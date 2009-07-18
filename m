From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] OMAP3: USBHOST: Fix prcm interrupt handler
Date: Sat, 18 Jul 2009 05:58:57 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F56F1562@dbde02.ent.ti.com>
References: <1247869448-26114-1-git-send-email-vikram.pandita@ti.com>
 <87ljmmubrd.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43043 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbZGRA3N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jul 2009 20:29:13 -0400
In-Reply-To: <87ljmmubrd.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>Sent: Friday, July 17, 2009 6:32 PM
>To: Pandita, Vikram
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH] OMAP3: USBHOST: Fix prcm interrupt handler
>
>Vikram Pandita <vikram.pandita@ti.com> writes:
>
>> For clearing the PM_WKST of USBHOST domain, two fclocks need
>> to be enabled: HOST1 and HOST2
>>
>> Current code just enables HOST1 fclock and thus not clearing the
>> Wake status of usbhost domain correctly
>
>I think the changelog needs a little more detail.  Something like:
>
>USBHOST module has 2 fclocks (for HOST1 and HOST2), only one iclock
>and only a single bit in the WKST register to indicate a wakeup event.
>
>Because of the single WKST bit, we cannot know whether a wakeup event
>was on HOST1 or HOST2, so enable both fclocks before clearing the
>wakeup event to ensure both hosts can properly clear the event.
>
>And shortlog (subject) should be:
>
>OMAP3: PM: USBHOST: clear wakeup events on both hosts

Ok will send v2 patch with this short log and comments.

>
>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>> ---
>>  arch/arm/mach-omap2/pm34xx.c |    6 ++++--
>>  1 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index e80d59f..4cbeff1 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -264,8 +264,10 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>>  					       CM_FCLKEN);
>>  			cm_set_mod_reg_bits(wkst, OMAP3430ES2_USBHOST_MOD,
>>  					    CM_ICLKEN);
>> -			cm_set_mod_reg_bits(wkst, OMAP3430ES2_USBHOST_MOD,
>> -					    CM_FCLKEN);
>> +			cm_set_mod_reg_bits((1<<OMAP3430ES2_EN_USBHOST2_SHIFT)|
>> +					(1<<OMAP3430ES2_EN_USBHOST1_SHIFT),
>> +					OMAP3430ES2_USBHOST_MOD,
>> +					CM_FCLKEN);
>
>Instead how about keeping original code, but just add something like:
>
>        /* We don't know whether HOST1 or HOST2 woke us up, so
>         * enable both clocks. */
>        clken = wkst | (1 << OMAP3430ES2_EN_USBHOST2_SHIFT);

Ok looks cleaner. Will have this in v2 patch.

>
>Then write 'clken' to the FCLKEN reg and original 'wkst' to the WKST
>reg...
>
>>  			prm_write_mod_reg(wkst, OMAP3430ES2_USBHOST_MOD,
>>  					  PM_WKST);
>
>otherwise you're writing undefined bits here.

No. Original patch does not write any undefined bits. 
Wkst is 0x1 always.

>
>Kevin
>

