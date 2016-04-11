From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix imprecise external abort for off mode on
 36xx
Date: Mon, 11 Apr 2016 13:20:43 -0500
Message-ID: <570BEAFB.6000409@ti.com>
References: <1455140107-3328-1-git-send-email-tony@atomide.com>
 <5706C062.4040803@ti.com> <20160407231604.GP16484@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160407231604.GP16484@atomide.com>
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

Tony,
On 04/07/2016 06:16 PM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [160407 13:18]:
>>
>> I have a series to convert omap3 PM code to using generic SRAM driver but
>> when testing I see an external abort on BBXM off mode resume very similar to
>> this that seems to be timing related caused by using generic SRAM driver to
>> re-copy PM code rather than omap3_sram_restore_context.
>>
>> By tracing the resume path I believe the abort is caused by
>> omap3_intc_resume_idle in pm34xx.c, which writes to two registers in the
>> INTC. Removing this call makes the abort unreproducible in my experiments
>> and changing the writes to reads causes a bus lock, so I'm pretty confident
>> it's coming from this call attempting to write to an idled INTC.
>>
>> Advisory 1.106 in DM3730 Silicon Errata Document [1] describes an issue with
>> "MPU Leaves MSTANDBY State Before IDLEREQ of Interrupt Controller is
>> Released" which sounds like a very similar failure situation to what we are
>> seeing even though the timing of INTC access is a bit further from WFI exit
>> than it describes. Perhaps there are more conditions where it can occur.
>> Pushed my WIP branch for SRAM series that shows the same failure here [2].
>
> Interesting, I think you may have something with the errata 1.106.. And
> looks like we also need still errata 1.62 handled also on 36xx in the
> same pdf. And need to disable intc autoidle early at least for HS omaps
> as save_secure_ram context supposedly also can do WFI.
>
> Maybe something like the following would make sense? It seems to work
> here without external aborts with your test branch on dm3730, and boots
> fine on omap3430 hs (n900).
>
> Or do you have some better ideas for a fix?

I can also confirm that this fixes the external abort, I can not cause 
it with your attached patch.

I would be ok with the solution you have proposed and I was unable to 
come up with anything better while trying to debug the issue originally.

We still need the call to omap3_intc_resume_idle because the intc 
restore context only gets called on resume from off mode. Perhaps we 
only need to call omap3_intc_resume_idle when coming back from non-off 
modes, otherwise let the context restore handle the reconfig of the INTC 
idle/sysconfig registers?

Regards,
Dave


>
> Regards,
>
> Tony
>
> 8< ------------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Thu, 7 Apr 2016 16:06:35 -0700
> Subject: [PATCH] ARM: OMAP3: Fix external abort on 36xx waking from off mode
>   idle
>
> Depending on the timings affected by .config options, we may get
> external aborts with 36xx. These seem to be caused by the following:
>
> - omap3 errata 1.62 "MPU Cannot Exit from Standby" says we need to
>    disable disable intc autoidle before WFI
>
> - dm3730 errata 1.106 "MPU Leaves MSTANDBY State Before IDLEREQ of
>    Interrupt Controller is Released" says we need to wait before
>    accessing intc
>
> Looks like we're currently disabling intc autoidle after we save
> the intc context. And then we attempt to re-enable intc autoidle
> after we restore intc context.
>
> This means we're trying to restore intc autoidle twice, and it
> occasionally fails as the intc restore may take a while for
> things to get configured?
>
> So we should either completely leave out omap3_intc_resume_idle()
> assuming that the context restore really also enables the intc
> autoidle.
>
> Or we can disable intc autoidle before saving context, and then
> reenable intc autoidle only after the context restore. This pairs
> the calls, can we can call omap3_intc_resume_idle() later to
> allow some time for intc to settle down.
>
> Note that supposedly save_secure_ram() also can cause a WFI
> in the secure ram code, so we need to disable intc autoidle
> early. There's some information about that in the old thread
> "[PATCH 09/13] OMAP3: PM: Apply errata i540 before save
> secure ram".
>
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -303,6 +303,8 @@ void omap_sram_idle(void)
>   		omap2_gpio_prepare_for_idle(per_going_off);
>   	}
>
> +	omap3_intc_prepare_idle();
> +
>   	/* CORE */
>   	if (core_next_state < PWRDM_POWER_ON) {
>   		if (core_next_state == PWRDM_POWER_OFF) {
> @@ -314,8 +316,6 @@ void omap_sram_idle(void)
>   	/* Configure PMIC signaling for I2C4 or sys_off_mode */
>   	omap3_vc_set_pmic_signaling(core_next_state);
>
> -	omap3_intc_prepare_idle();
> -
>   	/*
>   	 * On EMU/HS devices ROM code restores a SRDC value
>   	 * from scratchpad which has automatic self refresh on timeout
> @@ -358,13 +358,14 @@ void omap_sram_idle(void)
>   			omap2_sms_restore_context();
>   		}
>   	}
> -	omap3_intc_resume_idle();
>
>   	pwrdm_post_transition(NULL);
>
>   	/* PER */
>   	if (per_next_state < PWRDM_POWER_ON)
>   		omap2_gpio_resume_after_idle();
> +
> +	omap3_intc_resume_idle();
>   }
>
>   static void omap3_pm_idle(void)
>
