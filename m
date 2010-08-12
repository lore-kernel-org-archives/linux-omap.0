From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] OMAP3: PM: ensure IO wakeups are properly disabled
Date: Thu, 12 Aug 2010 06:58:01 -0700
Message-ID: <87d3tovspi.fsf@deeprootsystems.com>
References: <1281542626-4045-1-git-send-email-khilman@deeprootsystems.com>
	<1281609324.1861.6.camel@chotu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:62759 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab0HLN6E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 09:58:04 -0400
Received: by pxi10 with SMTP id 10so436098pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 06:58:03 -0700 (PDT)
In-Reply-To: <1281609324.1861.6.camel@chotu> (Ameya Palande's message of "Thu,
	12 Aug 2010 13:35:24 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Ameya Palande <ameya.palande@nokia.com> writes:

> Hi Kevin,
>
> On Wed, 2010-08-11 at 18:03 +0200, ext Kevin Hilman wrote:
>> From: Kevin Hilman <khilman@ti.com>
>> 
>> Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
>> mistakenly removed the check for PER when disabling the IO chain.
>> 
>> During idle, if the PER powerdomain transitions and CORE does not (as
>> is the case with the lower C-states when using CPUidle) the IO pad
>> wakeups are not being disabled in the idle path after they are
>> enabled.
>> 
>> This patch ensures that the check for disabling IO wakeups also checks
>> for PER transitions, matching the check done to enable IO wakeups.
>> 
>> Found when debugging PM/CPUidle related problems reported by Ameya
>> Palande <ameya.palande@nokia.com>.  Problems were triggered
>> particularily on boards with UART2 consoles (n900, Overo) since UART2
>> is in the PER powerdomain.
>> 
>> Tested on l-o master (omap3_defonfig + CONFIG_CPU_IDLE=y) as well
>> as with current PM branch.  Boards tested: n900, Overo, omap3evm.
>> 
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Ameya Palande <ameya.palande@nokia.com>
>> Tested-by: Jarkko Nikula <jhnikula@gmail.com>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>> Tony, this should go in with fixes for -rc2
>> 
>> Changes since v1
>> - added a bit of history about where the problem was created
>> - added 'Tested-by' for Jarkko
>> 
>>  arch/arm/mach-omap2/pm34xx.c |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index fb4994a..7b03426 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -480,7 +480,9 @@ void omap_sram_idle(void)
>>  	}
>>  
>>  	/* Disable IO-PAD and IO-CHAIN wakeup */
>> -	if (omap3_has_io_wakeup() && core_next_state < PWRDM_POWER_ON) {
>> +	if (omap3_has_io_wakeup() &&
>> +	    (per_next_state < PWRDM_POWER_ON ||
>> +	     core_next_state < PWRDM_POWER_ON)) {
>>  		prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
>>  		omap3_disable_io_chain();
>>  	}
>
> Thanks for your fix!
> I tried out following patch on n900 kernel (based on 2.6.35 mainline)
> hosted at: http://gitorious.org/nokia-n900-kernel
>
> Patch:
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index b88737f..887242d 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -479,7 +479,8 @@ void omap_sram_idle(void)
>         }
>  
>         /* Disable IO-PAD and IO-CHAIN wakeup */
> -       if (core_next_state < PWRDM_POWER_ON) {
> +       if (per_next_state < PWRDM_POWER_ON ||
> +                       core_next_state < PWRDM_POWER_ON) {
>                 prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
> PM_WKEN);
>                 omap3_disable_io_chain();
>         }
>
> And got following WARNING after sometime:
>
> [  109.394714] ------------[ cut here ]------------
> [  109.399414] WARNING: at arch/arm/mach-omap2/pm34xx.c:292
> prcm_interrupt_handler+0xb4/0x108()
> [  109.407897] prcm: WARNING: PRCM indicated MPU wakeup but no wakeup
> sources are marked

Since you're using a custom kernel (that I didn't look at), it's
difficult to guess what is happening here.  Can you reproduce this using
the PM branch or l-o master?  One thing is certain is that this is not
related to $SUBJECT patch.

There are lots of other events that can potentially trigger PRCM
interrupts: DPLL recalibration events, voltage processor events (usually
triggered by SR.)

But in this case, it looks like there may be a problem with interrupts
being enabled prematurely as well.  An interrupt fires in the
CPUidle path, is serviced and upon exit soft IRQs run.  During the
soft IRQ, the PRCM interrupt fires and triggers this warning.

Before I do any more digging, I'd like to know if this is reproducable
on l-o master or the PM branch.

Kevin




> [  109.415771] Modules linked in: sco bnep l2cap bluetooth ipv6
> wl1251_spi wl1251 omaplfb pvrsrvkm cmt_speech mac80211 ssi_protocol hsi_
> char cmt omap_ssi crc7 g_ether tsl2563(C) industrialio(C) rtc_twl
> rtc_core twl4030_pwrbutton gpio_keys
> [  109.437042] [<c0039a54>] (unwind_backtrace+0x0/0x168) from
> [<c005ecdc>] (warn_slowpath_common+0x4c/0x64)
> [  109.446594] [<c005ecdc>] (warn_slowpath_common+0x4c/0x64) from
> [<c005ed74>] (warn_slowpath_fmt+0x2c/0x3c)
> [  109.456237] [<c005ed74>] (warn_slowpath_fmt+0x2c/0x3c) from
> [<c0043860>] (prcm_interrupt_handler+0xb4/0x108)
> [  109.466125] [<c0043860>] (prcm_interrupt_handler+0xb4/0x108) from
> [<c008dcc0>] (handle_IRQ_event+0x24/0xe0)
> [  109.475952] [<c008dcc0>] (handle_IRQ_event+0x24/0xe0) from
> [<c008fe00>] (handle_level_irq+0xd4/0x180)
> [  109.485260] [<c008fe00>] (handle_level_irq+0xd4/0x180) from
> [<c003406c>] (asm_do_IRQ+0x6c/0x8c)
> [  109.494018] [<c003406c>] (asm_do_IRQ+0x6c/0x8c) from [<c0034ac8>]
> (__irq_svc+0x48/0xa8)
> [  109.502075] Exception stack(0xc0481eb0 to 0xc0481ef8)
> [  109.507141] 1ea0:                                     00000020
> c04866f0 c0480000 c04db080
> [  109.515380] 1ec0: c0480000 00000202 00000000 00000002 0000000a
> c0480000 c04db080 00000000
> [  109.523620] 1ee0: 00000002 c0481ef8 c00642c8 c00641c8 20000113
> ffffffff
> [  109.530303] [<c0034ac8>] (__irq_svc+0x48/0xa8) from [<c00641c8>]
> (__do_softirq+0x3c/0xf8)
> [  109.538543] [<c00641c8>] (__do_softirq+0x3c/0xf8) from [<c00642c8>]
> (irq_exit+0x44/0xa8)
> [  109.546691] [<c00642c8>] (irq_exit+0x44/0xa8) from [<c0034070>]
> (asm_do_IRQ+0x70/0x8c)
> [  109.554656] [<c0034070>] (asm_do_IRQ+0x70/0x8c) from [<c0034ac8>]
> (__irq_svc+0x48/0xa8)
> [  109.562713] Exception stack(0xc0481f38 to 0xc0481f80)
> [  109.567810] 1f20:
> 0028f9f0 00000000
> [  109.576049] 1f40: 0028f9f0 00000000 c04ba290 c04ba274 00000003
> 00000003 8002b868 411fc083
> [  109.584259] 1f60: 0000001f 00000000 00000000 c0481f80 c00449a4
> c00449b0 60000013 ffffffff
> [  109.592498] [<c0034ac8>] (__irq_svc+0x48/0xa8) from [<c00449b0>]
> (omap3_enter_idle+0x104/0x134)
> [  109.601287] [<c00449b0>] (omap3_enter_idle+0x104/0x134) from
> [<c02acb24>] (cpuidle_idle_call+0xa0/0x108)
> [  109.610839] [<c02acb24>] (cpuidle_idle_call+0xa0/0x108) from
> [<c0035f20>] (cpu_idle+0x48/0xa0)
> [  109.619506] [<c0035f20>] (cpu_idle+0x48/0xa0) from [<c0008974>]
> (start_kernel+0x278/0x2d8)
> [  109.627838] [<c0008974>] (start_kernel+0x278/0x2d8) from [<80008034>]
> (0x80008034)
> [  109.635467] ---[ end trace 89613c3938486d08 ]---
>
> I got several such warnings multiple time once I keep N900 idle.
>
> Cheers,
> Ameya.
