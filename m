From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix imprecise external abort for off mode on
 36xx
Date: Wed, 13 Apr 2016 10:45:58 -0500
Message-ID: <570E69B6.8010508@ti.com>
References: <1455140107-3328-1-git-send-email-tony@atomide.com>
 <5706C062.4040803@ti.com> <20160407231604.GP16484@atomide.com>
 <570BEAFB.6000409@ti.com> <20160411211339.GI5995@atomide.com>
 <570C3040.3030001@ti.com> <20160412000151.GK5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160412000151.GK5995@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tero Kristo <t-kristo@ti.com>, Richard Woodruff <r-woodruff2@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 04/11/2016 07:01 PM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [160411 16:17]:
>> On 04/11/2016 04:13 PM, Tony Lindgren wrote:
>>>> We still need the call to omap3_intc_resume_idle because the intc restore
>>>> context only gets called on resume from off mode. Perhaps we only need to
>>>> call omap3_intc_resume_idle when coming back from non-off modes, otherwise
>>>> let the context restore handle the reconfig of the INTC idle/sysconfig
>>>> registers?
>>>
>>> OK. Did you actually test by commenting out omap3_intc_resume_idle()?
>>>
>>> Yeah sounds like we can optimize out the restore there for non-off
>>> modes.
>>
>> Yes I removed it entirely for testing, and I also tried something like this for
>> a possible workable solution (without your patch applied):
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index fcf975eb5e9d..8d39b44ba3a3 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -268,7 +268,6 @@ void omap_sram_idle(void)
>>          int per_next_state = PWRDM_POWER_ON;
>>          int core_next_state = PWRDM_POWER_ON;
>>          int per_going_off;
>> -       int core_prev_state;
>>          u32 sdrc_pwr = 0;
>>
>>          mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
>> @@ -348,17 +347,16 @@ void omap_sram_idle(void)
>>                  sdrc_write_reg(sdrc_pwr, SDRC_POWER);
>>
>>          /* CORE */
>> -       if (core_next_state < PWRDM_POWER_ON) {
>> -               core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
>> -               if (core_prev_state == PWRDM_POWER_OFF) {
>> +       if (core_next_state < PWRDM_POWER_ON &&
>> +           pwrdm_read_prev_pwrst(core_pwrdm) == PWRDM_POWER_OFF) {
>>                          omap3_core_restore_context();
>>                          omap3_cm_restore_context();
>>                          omap3_push_sram_idle();
>>                          omap3_push_sram_secure_idle();
>>                          omap2_sms_restore_context();
>> -               }
>> -       }
>> -       omap3_intc_resume_idle();
>> +       } else
>> +               omap3_intc_resume_idle();
>> +
>>
>>          pwrdm_post_transition(NULL);
>>
>>
>
> OK yeah that works for me.
>
> Can you post a proper patch with few minor changes:
>
> - Add a comment to the code somewhere saying that for off mode,
>    omap3_core_restore_context() also restores intc and we don't
>    need to omap3_intc_resume_idle().
>
> - Add the brackets to the one line else statement for checkpatch.

Thanks for your comments, I'm sure you've seen it but I sent a patch 
here with the fixes you recommended here: 
https://patchwork.kernel.org/patch/8811951/

Regards,
Dave

>
> Cheers,
>
> Tony
>
