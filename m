From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM PATCH] OMAP3: PM: Fix INTC context save/restore
Date: Thu, 12 Mar 2009 09:33:59 -0700
Message-ID: <878wna8zuw.fsf@deeprootsystems.com>
References: <1236874349-31261-1-git-send-email-Aaro.Koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:34403 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067AbZCLQeF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 12:34:05 -0400
Received: by wf-out-1314.google.com with SMTP id 28so962793wfa.4
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 09:34:02 -0700 (PDT)
In-Reply-To: <1236874349-31261-1-git-send-email-Aaro.Koskinen@nokia.com> (Aaro Koskinen's message of "Thu\, 12 Mar 2009 18\:12\:29 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Cc: linux-omap@vger.kernel.org

Aaro Koskinen <Aaro.Koskinen@nokia.com> writes:

> Wrong index was used for ILR.
>
> Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>

Thanks, pushed to PM brach.

Kevin

> ---
>  arch/arm/mach-omap2/irq.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 6cc5757..f813916 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -244,7 +244,7 @@ void omap3_intc_save_context(void)
>  			intc_bank_read_reg(bank, INTC_THRESHOLD);
>  		for (i = 0; i < INTCPS_NR_IRQS; i++)
>  			intc_context[ind].ilr[i] =
> -				intc_bank_read_reg(bank, (0x100 + 0x4*ind));
> +				intc_bank_read_reg(bank, (0x100 + 0x4*i));
>  		for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
>  			intc_context[ind].mir[i] =
>  				intc_bank_read_reg(&irq_banks[0], INTC_MIR0 +
> @@ -270,7 +270,7 @@ void omap3_intc_restore_context(void)
>  					bank, INTC_THRESHOLD);
>  		for (i = 0; i < INTCPS_NR_IRQS; i++)
>  			intc_bank_write_reg(intc_context[ind].ilr[i],
> -				bank, (0x100 + 0x4*ind));
> +				bank, (0x100 + 0x4*i));
>  		for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
>  			intc_bank_write_reg(intc_context[ind].mir[i],
>  				 &irq_banks[0], INTC_MIR0 + (0x20 * i));
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
