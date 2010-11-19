From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 11/13] OMAP3630: PM: Errata i608: disable RTA
Date: Fri, 19 Nov 2010 06:09:47 -0600
Message-ID: <4CE6690B.8090009@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>	<1290131698-6194-12-git-send-email-nm@ti.com> <AANLkTin03HpggFOFtwrxYrFwrU6sARkM82KqgsCL9HpB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:58547 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754040Ab0KSMJ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 07:09:56 -0500
Received: by gye5 with SMTP id 5so492061gye.4
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 04:09:56 -0800 (PST)
In-Reply-To: <AANLkTin03HpggFOFtwrxYrFwrU6sARkM82KqgsCL9HpB@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@deeprootsystems.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Jean Pihet wrote, on 11/19/2010 03:57 AM:
[...]
>> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
>> index 5a4468f..7259541 100644
>> --- a/arch/arm/mach-omap2/sleep34xx.S
>> +++ b/arch/arm/mach-omap2/sleep34xx.S
> ...
>>   /* Function call to get the restore pointer for for ES3 to resume from OFF */
>> @@ -246,6 +256,19 @@ copy_to_sram:
> This code is from 'restore_es3' which ends with a pass-through to 'restore:'...
>
>>         bne     copy_to_sram
>>         ldr     r1, sram_base
>>         blx     r1
>> +
> .. and so adding restore_3630 here has the result that is also run by
> 34xx>= ES3.x.
> Is that a concern? Was it tested on 34xx>= ES3.x?
arrgh.. thanks for catching it
I did run it on a SDP3430 ES3.1 platform.. hmmm... I did not intend that 
behavior though - there should be a b restore here!

>
>> +restore_3630:
>> +       /*b restore_es3630*/            @ Enable to debug restore code
>> +       ldr     r1, pm_prepwstst_core_p
>> +       ldr     r2, [r1]
>> +       and     r2, r2, #0x3
>> +       cmp     r2, #0x0        @ Check if previous power state of CORE is OFF
>> +       bne     restore
>> +       /* Disable rta before giving control */
>> +       ldr     r1, control_mem_rta
>> +       mov     r2, #OMAP36XX_RTA_DISABLE
>> +       str     r2, [r1]
>> +       /* Fall thru for the remaining logic */
>>   restore:
>>         /* b restore*/  @ Enable to debug restore code
>>          /* Check what was the reason for mpu reset and store the reason in r9*/
>> @@ -650,6 +673,8 @@ cache_pred_disable_mask:
>>         .word   0xFFFFE7FB
>>   control_stat:
>>         .word   CONTROL_STAT
>> +control_mem_rta:
>> +       .word   CONTROL_MEM_RTA_CTRL
>>   kernel_flush:
>>         .word v7_flush_dcache_all
>>         /* these 2 words need to be at the end !!! */
>> --
>> 1.6.3.3
>>
>>
>
> A more general remark: since pm34xx.c and sleep34xx.S now contain 34xx
> and 36xx specific code, should those (and possibly other files) be
> renamed to e.g. pm3xxx.c and sleep3xxx.S?

During the initial days of 3630 code introduction we found that almost 
all of the code with 34xx could be reused for 3630 as well.. what ended 
up happening is 34xx now means 3630&3430, while 343x holds to the 3430 
family :(.. cpu_is_omap34xx() as an example - ideally should have been 
cpu_is_omap3xxx() ;) ..I guess it is becoming more of a convention to do 
3xxx for new code and leaving the old code as is :(

-- 
Regards,
Nishanth Menon
