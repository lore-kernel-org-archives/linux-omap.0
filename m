From: Tero Kristo <t-kristo@ti.com>
Subject: RE: OMAP3EVM not booting on l-o master
Date: Mon, 23 Apr 2012 14:59:48 +0300
Message-ID: <1335182388.2149.70.camel@sokoban>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
	 <alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C4B44@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204051303000.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C5DB6@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204060111400.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C5EEF@DBDE01.ent.ti.com>
	 <1335173044.2149.64.camel@sokoban>
	 <C8443D0743D26F4388EA172BF4E2A7A93E96E75A@DBDE01.ent.ti.com>
	 <1335176002.2149.65.camel@sokoban>
	 <C8443D0743D26F4388EA172BF4E2A7A93E96E7A7@DBDE01.ent.ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57227 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab2DWL7w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 07:59:52 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E96E7A7@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2012-04-23 at 12:43 +0200, Mohammed, Afzal wrote:
> Hi Tero,
> 
> On Mon, Apr 23, 2012 at 15:43:22, Kristo, Tero wrote:
> > > > can you try the attached patch with this branch and omap3evm board? I
> > > > don't have the board myself so I can't test it myself (I tested this
> > > > with omap3beagle and it works with that one.)
> 
> 
> With your patch, OMAP3EVM boots normally.
> 
> Tested by creating same changes as in your patch as below (patch could not
> be applied, seems it was corrupted)

Okay thats good (although I wonder why the attachment got corrupted.)
Did you check if the device suspends / resumes properly also? Can you
check what do you have in the /proc/interrupts for the hwmod_io
interrupt just after boot / after one suspend?

-Tero

> 
> Regards
> Afzal
> 
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 65c3391..17349e3 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -41,6 +41,7 @@
>  #include "control.h"
>  #include "mux.h"
>  #include "prm.h"
> +#include "pm.h"
> 
>  #define OMAP_MUX_BASE_OFFSET           0x30    /* Offset from CTRL_BASE */
>  #define OMAP_MUX_BASE_SZ               0x5ca
> @@ -427,6 +428,13 @@ static irqreturn_t omap_hwmod_mux_handle_irq(int irq, void *unused)
>         return IRQ_HANDLED;
>  }
> 
> +static irqreturn_t omap34xx_hwmod_mux_handle_irq(int irq, void *unused)
> +{
> +       omap_hwmod_for_each(_omap_hwmod_mux_handle_irq, NULL);
> +       prcm_int_ack_io();
> +       return IRQ_HANDLED;
> +}
> +
>  /* Assumes the calling function takes care of locking */
>  void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>  {
> @@ -792,6 +800,7 @@ static int __init omap_mux_late_init(void)
>  {
>         struct omap_mux_partition *partition;
>         int ret;
> +       irq_handler_t irq_handler;
> 
>         list_for_each_entry(partition, &mux_partitions, node) {
>                 struct omap_mux_entry *e, *tmp;
> @@ -812,12 +821,19 @@ static int __init omap_mux_late_init(void)
>                 }
>         }
> 
> +#ifdef CONFIG_PM
> +       if (cpu_is_omap34xx())
> +               irq_handler = omap34xx_hwmod_mux_handle_irq;
> +       else
> +               irq_handler = omap_hwmod_mux_handle_irq;
> +
>         ret = request_irq(omap_prcm_event_to_irq("io"),
> -               omap_hwmod_mux_handle_irq, IRQF_SHARED | IRQF_NO_SUSPEND,
> +               irq_handler, IRQF_SHARED | IRQF_NO_SUSPEND,
>                         "hwmod_io", omap_mux_late_init);
> 
>         if (ret)
>                 pr_warning("mux: Failed to setup hwmod io irq %d\n", ret);
> +#endif
> 
>         omap_mux_dbg_init();
> 
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 36fa90b..09ba9e7 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -20,6 +20,7 @@ extern void omap3_pm_off_mode_enable(int);
>  extern void omap_sram_idle(void);
>  extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
>  extern int omap3_idle_init(void);
> +extern void prcm_int_ack_io(void);
>  extern int omap4_idle_init(void);
>  extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
>  extern int (*omap_pm_suspend)(void);
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index afe3dda..cea4408 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -182,14 +182,10 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
>         return c;
>  }
> 
> -static irqreturn_t _prcm_int_handle_io(int irq, void *unused)
> +void prcm_int_ack_io(void)
>  {
> -       int c;
> -
> -       c = prcm_clear_mod_irqs(WKUP_MOD, 1,
> +       prcm_clear_mod_irqs(WKUP_MOD, 1,
>                 ~(OMAP3430_ST_IO_MASK | OMAP3430_ST_IO_CHAIN_MASK));
> -
> -       return c ? IRQ_HANDLED : IRQ_NONE;
>  }
> 
>  static irqreturn_t _prcm_int_handle_wakeup(int irq, void *unused)
> @@ -683,16 +679,6 @@ static int __init omap3_pm_init(void)
>                 goto err1;
>         }
> 
> -       /* IO interrupt is shared with mux code */
> -       ret = request_irq(omap_prcm_event_to_irq("io"),
> -               _prcm_int_handle_io, IRQF_SHARED | IRQF_NO_SUSPEND, "pm_io",
> -               omap3_pm_init);
> -
> -       if (ret) {
> -               pr_err("pm: Failed to request pm_io irq\n");
> -               goto err1;
> -       }
> -
>         ret = pwrdm_for_each(pwrdms_setup, NULL);
>         if (ret) {
>                 printk(KERN_ERR "Failed to setup powerdomains\n");


