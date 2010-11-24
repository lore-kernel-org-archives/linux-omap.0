From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 02/13] OMAP3: PM: Errata i581 suppport: dll kick strategy
Date: Wed, 24 Nov 2010 11:24:26 -0600
Message-ID: <4CED4A4A.3050108@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>	<1290131698-6194-3-git-send-email-nm@ti.com> <AANLkTi=cb1LDS0nJr+gS47qc2qpw_kRz8+ZxV_x2gSJ0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:40479 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755988Ab0KXRY7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 12:24:59 -0500
Received: by mail-gy0-f180.google.com with SMTP id 5so2548315gyd.39
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 09:24:29 -0800 (PST)
In-Reply-To: <AANLkTi=cb1LDS0nJr+gS47qc2qpw_kRz8+ZxV_x2gSJ0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, Tony <tony@atomide.com>

Sripathy, Vishwanath had written, on 11/24/2010 10:51 AM, the following:
> On Fri, Nov 19, 2010 at 7:24 AM, Nishanth Menon <nm@ti.com> wrote:
>> From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>>
>> Errata i581 impacts OMAP3 platforms.
>> PRCM DPLL control FSM removes SDRC_IDLEREQ before DPLL3 locks causing
>> the DPLL not to be locked at times.
>>
>> IMPORTANT: this is not a complete workaround implementation as recommended
>> by the silicon errata. this is a support logic for detecting lockups and
>> attempting to recover where possible and is known to provide stability
>> in multiple platforms.
> 
> How does this WA work when Core enters off mode? SRAM contents are
> lost when Core enters off. So how this code is copied to SRAM upon
> wakeup? Where is this code placed when Core entered off mode?

It depends on the location of wait_sdram_ok - ideally speaking yep, you 
are right the current wait_sdram_ok for OFF makes no sense at all as it 
wakes off the ddr. For retention though, it makes sense. after the 
discussion we had on Jean's series 
http://marc.info/?t=128532555200004&r=1&w=2, I am pretty sure that 
refactor that Jean is doing will help us clean this mess up.

Maybe we can refactor this as part of Jean's cleanups.

> 
> Vishwa
>> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>> ---
>>  arch/arm/mach-omap2/sleep34xx.S |   52 +++++++++++++++++++++++++++++++++++---
>>  1 files changed, 47 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
>> index 8f207b2..5a4468f 100644
>> --- a/arch/arm/mach-omap2/sleep34xx.S
>> +++ b/arch/arm/mach-omap2/sleep34xx.S
>> @@ -42,6 +42,7 @@
>>                                OMAP3430_PM_PREPWSTST)
>>  #define PM_PWSTCTRL_MPU_P      OMAP3430_PRM_BASE + MPU_MOD + OMAP2_PM_PWSTCTRL
>>  #define CM_IDLEST1_CORE_V      OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
>> +#define CM_IDLEST_CKGEN_V      OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
>>  #define SRAM_BASE_P            0x40200000
>>  #define CONTROL_STAT           0x480022F0
>>  #define SCRATCHPAD_MEM_OFFS    0x310 /* Move this as correct place is
>> @@ -554,31 +555,67 @@ skip_l2_inval:
>>
>>  /* Make sure SDRC accesses are ok */
>>  wait_sdrc_ok:
>> +
>> +/* DPLL3 must be locked before accessing the SDRC. Maybe the HW ensures this. */
>> +       ldr     r4, cm_idlest_ckgen
>> +wait_dpll3_lock:
>> +       ldr     r5, [r4]
>> +       tst     r5, #1
>> +       beq     wait_dpll3_lock
>> +
>>         ldr     r4, cm_idlest1_core
>> +wait_sdrc_ready:
>>         ldr     r5, [r4]
>> -        and     r5, r5, #0x2
>> -        cmp     r5, #0
>> -        bne     wait_sdrc_ok
>> +        tst     r5, #0x2
>> +        bne     wait_sdrc_ready
>> +       /* allow DLL powerdown upon hw idle req */
>>         ldr     r4, sdrc_power
>>         ldr     r5, [r4]
>>         bic     r5, r5, #0x40
>>         str     r5, [r4]
>> -wait_dll_lock:
>> +is_dll_in_lock_mode:
>> +
>>         /* Is dll in lock mode? */
>>         ldr     r4, sdrc_dlla_ctrl
>>         ldr     r5, [r4]
>>         tst     r5, #0x4
>>         bxne    lr
>>         /* wait till dll locks */
>> -        ldr     r4, sdrc_dlla_status
>> +wait_dll_lock_timed:
>> +       ldr     r4, wait_dll_lock_counter
>> +       add     r4, r4, #1
>> +       str     r4, wait_dll_lock_counter
>> +       ldr     r4, sdrc_dlla_status
>> +        mov    r6, #8          /* Wait 20uS for lock */
>> +wait_dll_lock:
>> +       subs    r6, r6, #0x1
>> +       beq     kick_dll
>>         ldr     r5, [r4]
>>         and     r5, r5, #0x4
>>         cmp     r5, #0x4
>>         bne     wait_dll_lock
>>         bx      lr
>>
>> +       /* disable/reenable DLL if not locked */
>> +kick_dll:
>> +       ldr     r4, sdrc_dlla_ctrl
>> +       ldr     r5, [r4]
>> +       mov     r6, r5
>> +       bic     r6, #(1<<3)     /* disable dll */
>> +       str     r6, [r4]
>> +       dsb
>> +       orr     r6, r6, #(1<<3) /* enable dll */
>> +       str     r6, [r4]
>> +       dsb
>> +       ldr     r4, kick_counter
>> +       add     r4, r4, #1
>> +       str     r4, kick_counter
>> +       b       wait_dll_lock_timed
>> +
>>  cm_idlest1_core:
>>        .word   CM_IDLEST1_CORE_V
>> +cm_idlest_ckgen:
>> +       .word   CM_IDLEST_CKGEN_V
>>  sdrc_dlla_status:
>>        .word   SDRC_DLLA_STATUS_V
>>  sdrc_dlla_ctrl:
>> @@ -615,5 +652,10 @@ control_stat:
>>        .word   CONTROL_STAT
>>  kernel_flush:
>>        .word v7_flush_dcache_all
>> +       /* these 2 words need to be at the end !!! */
>> +kick_counter:
>> +       .word   0
>> +wait_dll_lock_counter:
>> +       .word   0
>>  ENTRY(omap34xx_cpu_suspend_sz)
>>        .word   . - omap34xx_cpu_suspend
>> --
>> 1.6.3.3
>>
>>


-- 
Regards,
Nishanth Menon
