From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: wakeupgen: AM43x adaptation
Date: Tue, 8 Oct 2013 14:24:36 -0700
Message-ID: <20131008212436.GR8313@atomide.com>
References: <1378378535-2967-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49660 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755311Ab3JHVYk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 17:24:40 -0400
Content-Disposition: inline
In-Reply-To: <1378378535-2967-1-git-send-email-afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

Few minor comments below.

* Afzal Mohammed <afzal@ti.com> [130905 04:03]:
> AM43x has 224 interrupts and 7 banks, make it as maximum values. Keep
> default values as earlier, if am43x is detected, update interrupts and
> banks to maximum.
> 
> Also AM43x has only one cpu, ensure that clearing bitmask at wakeupgen
> is done only for the single existing cpu, existing code assumes that
> there are two cpu's.
> 
> If bitmask is cleared in wakeupgen for the nonexistent second cpu,
> an imprecise abort happens as soon as Kernel switches to user space.
> It was rootcaused by Sekhar Nori <nsekhar@ti.com>.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/omap-wakeupgen.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
> index 813c615..899d4946 100644
> --- a/arch/arm/mach-omap2/omap-wakeupgen.c
> +++ b/arch/arm/mach-omap2/omap-wakeupgen.c
> @@ -33,8 +33,11 @@
>  #include "omap4-sar-layout.h"
>  #include "common.h"
>  
> -#define MAX_NR_REG_BANKS	5
> -#define MAX_IRQS		160
> +/* maximum value correspond to that of AM43x */
> +#define MAX_NR_REG_BANKS	7
> +#define MAX_IRQS		224
> +#define DEFAULT_NR_REG_BANKS	5
> +#define DEFAULT_IRQS		160
>  #define WKG_MASK_ALL		0x00000000
>  #define WKG_UNMASK_ALL		0xffffffff
>  #define CPU_ENA_OFFSET		0x400

How about define it like this to avoid updating things
in multiple places for new SoCs:

#define AM43X_NR_REG_BANKS	7
#define MAX_NR_REG_BANKS	AM43X_NR_REG_BANKS
...

> @@ -402,6 +405,7 @@ int __init omap_wakeupgen_init(void)
>  {
>  	int i;
>  	unsigned int boot_cpu = smp_processor_id();
> +	bool am43x = soc_is_am43xx() ? true : false;
>  
>  	/* Not supported on OMAP4 ES1.0 silicon */
>  	if (omap_rev() == OMAP4430_REV_ES1_0) {
> @@ -418,12 +422,16 @@ int __init omap_wakeupgen_init(void)
>  		irq_banks = OMAP4_NR_BANKS;
>  		max_irqs = OMAP4_NR_IRQS;
>  		omap_secure_apis = 1;
> +	} else if (am43x) {
> +		irq_banks = MAX_NR_REG_BANKS;
> +		max_irqs = MAX_IRQS;
>  	}

Then here you can have:

		irq_bankse = AM43X_NR_REG_BANKS
		...
  
>  	/* Clear all IRQ bitmasks at wakeupGen level */
>  	for (i = 0; i < irq_banks; i++) {
>  		wakeupgen_writel(0, i, CPU0_ID);
> -		wakeupgen_writel(0, i, CPU1_ID);
> +		if (!am43x)
> +			wakeupgen_writel(0, i, CPU1_ID);
>  	}

Why not use soc_is_am43xx() directly here?

Regards,

Tony
