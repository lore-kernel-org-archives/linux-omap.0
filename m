From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: remove misuse of IRQF_NO_SUSPEND flag
Date: Thu, 4 Feb 2016 15:14:31 +0200
Message-ID: <56B34EB7.4080005@ti.com>
References: <1454351299-27440-1-git-send-email-sudeep.holla@arm.com>
 <1454351299-27440-4-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1454351299-27440-4-git-send-email-sudeep.holla@arm.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Sudeep,

On 02/01/2016 08:28 PM, Sudeep Holla wrote:
> The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
> be left enabled so as to allow them to work as expected during the
> suspend-resume cycle, but doesn't guarantee that it will wake the system
> from a suspended state, enable_irq_wake is recommended to be used for
> the wakeup.
> 
> This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
> enable_irq_wake instead.

And sorry for delayed reply - I've spent some time investigating it, but
It was during Christmas holidays and finally I lost track of it :)

So, what we have:
1) bad news: it will not work :(

The PRCM wake up is handled in the following way on OMAP3+
-- PRCM IRQ omap_prcm_irq_handler()
   |- (a) "wkup" event -> _prcm_int_handle_wakeup()
   |- "io" event (shared)
       |- (b) _prcm_int_handle_io()
       |- (c) pcs_irq_handler()
(mux is for legacy platform - can be ignored for now)

All "wkup"/"io" events must be handled in PRCM registers before
PRCM IRQ status bits can be acked and reset.

It means that all IRQs (a), (b) (c) have to be enabled at the
moment when PRCM IRQ is fired. Unfortunately this can't be 
guaranteed by IR PM core and omap_prcm_irq_handler() 
will stuck forever on Resume :(.

Resume example:
 omap_prcm_irq_handler()
[1] -> prcm_irq_setup->read_pending_irqs(pending);
    -> is there pending irqs?
	-> io event
	    -> (c) pcs_irq (enabled | wakeup src)
		-> irq_pm_check_wakeup() 
		   -> (disabled | suspended| pending)
			pcs_irq_handler() not run
   ->  goto [1] ----- OOps dead-loop
	  

2) Potential good news: It could be fixed the same way as it's done
omap34xx (and as it was before :

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 58920bc..a0f8265 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -221,8 +221,7 @@ static int omap_pm_enter(suspend_state_t suspend_state)
 static int omap_pm_begin(suspend_state_t state)
 {
        cpu_idle_poll_ctrl(true);
-       if (cpu_is_omap34xx())
-               omap_prcm_irq_prepare();
+       omap_prcm_irq_prepare();
        return 0;
 }
 
@@ -233,8 +232,7 @@ static void omap_pm_end(void)
 
 static void omap_pm_finish(void)
 {
-       if (cpu_is_omap34xx())
-               omap_prcm_irq_complete();
+       omap_prcm_irq_complete();
 }

Another option is to convert omap_prcm_irq_handler to the generic handler
(now chained) and, probably, make it threaded and all cascaded IRQs as
nested threaded (this is just a theory).

I'll be on business trip next two weeks and will not be able to help more with it
Sorry.



> 
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   arch/arm/mach-omap2/mux.c        | 4 ++--
>   arch/arm/mach-omap2/pm34xx.c     | 9 ++++-----
>   arch/arm/mach-omap2/prm_common.c | 1 +
>   3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 176eef6ef338..12012bef8e63 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -810,13 +810,13 @@ int __init omap_mux_late_init(void)
>   		return 0;
>   
>   	ret = request_irq(omap_prcm_event_to_irq("io"),
> -		omap_hwmod_mux_handle_irq, IRQF_SHARED | IRQF_NO_SUSPEND,
> +		omap_hwmod_mux_handle_irq, IRQF_SHARED,
>   			"hwmod_io", omap_mux_late_init);
>   
>   	if (ret)
>   		pr_warn("mux: Failed to setup hwmod io irq %d\n", ret);
>   
> -	return 0;
> +	return enable_irq_wake(omap_prcm_event_to_irq("io"));
>   }
>   
>   static void __init omap_mux_package_fixup(struct omap_mux *p,
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 2dbd3785ee6f..49604e0023c4 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -472,23 +472,22 @@ int __init omap3_pm_init(void)
>   	prcm_setup_regs();
>   
>   	ret = request_irq(omap_prcm_event_to_irq("wkup"),
> -		_prcm_int_handle_wakeup, IRQF_NO_SUSPEND, "pm_wkup", NULL);
> +		_prcm_int_handle_wakeup, 0, "pm_wkup", NULL);
>   
>   	if (ret) {
>   		pr_err("pm: Failed to request pm_wkup irq\n");
>   		goto err1;
>   	}
> +	enable_irq_wake(omap_prcm_event_to_irq("wkup"));
>   
>   	/* IO interrupt is shared with mux code */
>   	ret = request_irq(omap_prcm_event_to_irq("io"),
> -		_prcm_int_handle_io, IRQF_SHARED | IRQF_NO_SUSPEND, "pm_io",
> -		omap3_pm_init);
> -	enable_irq(omap_prcm_event_to_irq("io"));
> -
> +		_prcm_int_handle_io, IRQF_SHARED, "pm_io", omap3_pm_init);
>   	if (ret) {
>   		pr_err("pm: Failed to request pm_io irq\n");
>   		goto err2;
>   	}
> +	enable_irq_wake(omap_prcm_event_to_irq("io"));
>   
>   	ret = pwrdm_for_each(pwrdms_setup, NULL);
>   	if (ret) {
> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> index 5b2f5138d938..7af688273e0d 100644
> --- a/arch/arm/mach-omap2/prm_common.c
> +++ b/arch/arm/mach-omap2/prm_common.c
> @@ -338,6 +338,7 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
>   		ct->chip.irq_ack = irq_gc_ack_set_bit;
>   		ct->chip.irq_mask = irq_gc_mask_clr_bit;
>   		ct->chip.irq_unmask = irq_gc_mask_set_bit;
> +		ct->chip.flags = IRQCHIP_SKIP_SET_WAKE;
>   
>   		ct->regs.ack = irq_setup->ack + i * 4;
>   		ct->regs.mask = irq_setup->mask + i * 4;
> 


-- 
regards,
-grygorii
