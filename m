From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2] Revert "ARM: OMAP3: PM: call pre/post transition per powerdomain"
Date: Wed, 08 Aug 2012 10:06:54 -0700
Message-ID: <87sjbxwbwx.fsf@ti.com>
References: <1344379659-26152-1-git-send-email-khilman@ti.com>
	<CANOLnONQhqYcqW8ZAfn+5ceZQ_h2W_yKZVZrnrP5cUJDooTrQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:37837 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758934Ab2HHRGy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 13:06:54 -0400
Received: by pbbro2 with SMTP id ro2so2139815pbb.26
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 10:06:53 -0700 (PDT)
In-Reply-To: <CANOLnONQhqYcqW8ZAfn+5ceZQ_h2W_yKZVZrnrP5cUJDooTrQg@mail.gmail.com>
	(Grazvydas Ignotas's message of "Wed, 8 Aug 2012 13:56:33 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <jean.pihet@newoldbits.com>, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>

Grazvydas Ignotas <notasas@gmail.com> writes:

> On Wed, Aug 8, 2012 at 1:47 AM, Kevin Hilman <khilman@ti.com> wrote:
>> This reverts commit 58f0829b7186150318c79515f0e0850c5e7a9c89.
>>
>> Converstion to per-pwrdm per/post transition calls was a bit
>> premature.  Only tracking MPU, PER & CORE in the idle path means we
>> lose the accounting for all the other powerdomains which may also
>> transition in idle.  On OMAP3, due to autodeps, several powerdomains
>> transition along with MPU (e.g. DSS, USBHOST), and the accounting for
>> these was lost with this patch.  Since the accounting includes the
>> context loss counters, drivers for devices in those power domains
>> would never notice context lost, so would likely hang after any
>> off-mode transitions.
>
> That's a shame, pwrdm_pre_transition/pwrdm_post_transition are the
> main contributors to idle latency and cause large performance loss on
> small and frequent loads, like short DMAs. Could we perhaps only do it
> when PM_DEBUG is on or when off transitions happen instead?

Unfortunately, that's also where we're currently doing the accounting 
for when power domains lose context.  Drivers rely on this to determine
whether or not to restore context, so it's not a debug only feature.

>> This patch should be revisited when the upcoming clkdm/pwrmdm/voltdm
>> use-counting seires is merged since then we can properly do accounting
>> without relying on a call in the idle path.
>
> So all hope of getting rid of those pre/post transition calls goes here then?
> Small typo with 'seires'..

Yes.  The goal of the use-counting series is so that proper accounting
can be done when the usecount changes so that not all of them have to be
done in the idle path.

Kevin

>> In addition, the original patch had another bug because the PER
>> powerdomain accounting was not updated until after the GPIO resume
>> hook is called.  Since gpio_resume_after_idle() checks the context
>> loss count (which is not yet updated) it would not properly restore
>> context, leaving the GPIO banks in an undefined state.
>>
>> Cc: Jean Pihet <jean.pihet@newoldbits.com>
>> Cc: Tero Kristo <t-kristo@ti.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Reported-by: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>>  arch/arm/mach-omap2/pm34xx.c |   19 ++++---------------
>>  1 file changed, 4 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index e4fc88c..05bd8f0 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -272,21 +272,16 @@ void omap_sram_idle(void)
>>         per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
>>         core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>>
>> -       if (mpu_next_state < PWRDM_POWER_ON) {
>> -               pwrdm_pre_transition(mpu_pwrdm);
>> -               pwrdm_pre_transition(neon_pwrdm);
>> -       }
>> +       pwrdm_pre_transition(NULL);
>>
>>         /* PER */
>>         if (per_next_state < PWRDM_POWER_ON) {
>> -               pwrdm_pre_transition(per_pwrdm);
>>                 per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
>>                 omap2_gpio_prepare_for_idle(per_going_off);
>>         }
>>
>>         /* CORE */
>>         if (core_next_state < PWRDM_POWER_ON) {
>> -               pwrdm_pre_transition(core_pwrdm);
>>                 if (core_next_state == PWRDM_POWER_OFF) {
>>                         omap3_core_save_context();
>>                         omap3_cm_save_context();
>> @@ -339,20 +334,14 @@ void omap_sram_idle(void)
>>                         omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
>>                                                OMAP3430_GR_MOD,
>>                                                OMAP3_PRM_VOLTCTRL_OFFSET);
>> -               pwrdm_post_transition(core_pwrdm);
>>         }
>>         omap3_intc_resume_idle();
>>
>> +       pwrdm_post_transition(NULL);
>> +
>>         /* PER */
>> -       if (per_next_state < PWRDM_POWER_ON) {
>> +       if (per_next_state < PWRDM_POWER_ON)
>>                 omap2_gpio_resume_after_idle();
>> -               pwrdm_post_transition(per_pwrdm);
>> -       }
>> -
>> -       if (mpu_next_state < PWRDM_POWER_ON) {
>> -               pwrdm_post_transition(mpu_pwrdm);
>> -               pwrdm_post_transition(neon_pwrdm);
>> -       }
>>  }
>>
>>  static void omap3_pm_idle(void)
>> --
>> 1.7.9.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
