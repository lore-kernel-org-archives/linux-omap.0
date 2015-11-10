From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [4.4-rc][PATCH] genirq / PM: restore system wake up from chained
 interrupts
Date: Tue, 10 Nov 2015 13:13:14 +0200
Message-ID: <20151110111314.GC1509@lahna.fi.intel.com>
References: <1447149492-20699-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447149492-20699-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 10, 2015 at 11:58:12AM +0200, Grygorii Strashko wrote:
> Commit e509bd7da149 ("genirq: Allow migration of chained interrupts
> by installing default action") breaks PCS wake up IRQ behaviour on
> TI OMAP based platforms (dra7-evm).
> 
> TI OMAP IRQ wake up configuration:
> GIC-irqchip->PCM_IRQ
>   |- omap_prcm_register_chain_handler
>      |- PRCM-irqchip -> PRCM_IO_IRQ
>         |- pcs_irq_chain_handler
>            |- pinctrl-irqchip -> PCS_uart1_wakeup_irq
> 
> This happens because IRQ PM code (irq/pm.c) is expected to ignore
> chained interrupts by default:
>   static bool suspend_device_irq(struct irq_desc *desc)
>   {
> 	if (!desc->action || desc->no_suspend_depth)
> 		return false;
>  - it's expected !desc->action = true for chained interrupts;

Indeed it is. I missed that, sorry.

> but, after above change, all chained interrupt descriptors will
> have default action handler installed - chained_action.
> As result, chained interrupts will be silently disabled during system
> suspend.
> 
> Hence, fix it by introducing helper function irq_desc_is_chained() and
> use it in suspend_device_irq() for chained interrupts identification
> and skip them, once detected.
> 
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

FWIW,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
