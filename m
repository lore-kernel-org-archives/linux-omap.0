From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC part1/2 merge][PATCH 06/10] omap3: serial: Fix uart4 handling for 3630
Date: Fri, 05 Mar 2010 14:37:52 -0800
Message-ID: <87sk8ez96n.fsf@deeprootsystems.com>
References: <1267625925-22616-1-git-send-email-saaguirre@ti.com>
	<1267625925-22616-7-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:54545 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755586Ab0CEWh5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 17:37:57 -0500
Received: by gxk9 with SMTP id 9so2128599gxk.8
        for <linux-omap@vger.kernel.org>; Fri, 05 Mar 2010 14:37:56 -0800 (PST)
In-Reply-To: <1267625925-22616-7-git-send-email-saaguirre@ti.com> (Sergio Aguirre's message of "Wed\,  3 Mar 2010 08\:18\:41 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-omap@vger.kernel.org

Sergio Aguirre <saaguirre@ti.com> writes:

> This patch makes the following:
>  - Adds missing wakeup padding register handling.
>  - Fixes a hardcode to use PER module ONLY on UART3.
>  - Corrects IRQ number to 80 for 3630 case.
>
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 351ba62..c3bad91 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -444,7 +444,7 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  	omap_uart_smart_idle_enable(uart, 0);
>  
>  	if (cpu_is_omap34xx()) {
> -		u32 mod = (uart->num == 2) ? OMAP3430_PER_MOD : CORE_MOD;
> +		u32 mod = (uart->num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
>  		u32 wk_mask = 0;
>  		u32 padconf = 0;
>  
> @@ -463,6 +463,10 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  			wk_mask = OMAP3430_ST_UART3_MASK;
>  			padconf = 0x19e;
>  			break;
> +		case 3:
> +			wk_mask = OMAP3630_ST_UART4_MASK;
> +			padconf = 0x0d2;
> +			break;
>  		}
>  		uart->wk_mask = wk_mask;
>  		uart->padconf = padconf;
> @@ -694,6 +698,10 @@ void __init omap_serial_early_init(void)
>  
>  		if (cpu_is_omap44xx())
>  			p->irq += 32;
> +
> +		/* IRQ for UART4 in omap3630 is 80 */
> +		if (cpu_is_omap3630() && (i == 3))
> +			p->irq = 80;

Should add a symbolic name to irqs.h and use it here, instead
of hard-coded constant.

Kevin

