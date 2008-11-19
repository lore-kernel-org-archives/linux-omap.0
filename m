From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH PM-20081106] OMAP: PM: Few fixes to uart clock handling
Date: Wed, 19 Nov 2008 11:41:46 -0800
Message-ID: <87abbvfqpx.fsf@deeprootsystems.com>
References: <1227088474-27452-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:12865 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbYKSTly (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 14:41:54 -0500
Received: by fk-out-0910.google.com with SMTP id 18so106061fkq.5
        for <linux-omap@vger.kernel.org>; Wed, 19 Nov 2008 11:41:52 -0800 (PST)
In-Reply-To: <1227088474-27452-1-git-send-email-jouni.hogander@nokia.com> (Jouni Hogander's message of "Wed\, 19 Nov 2008 11\:54\:34 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

Jouni Hogander <jouni.hogander@nokia.com> writes:

> Omap3_can_sleep is not inside part of idle loop which is protected
> with irg disable. If some irq handler is trying dump out something
> after omap3_can_sleep and before irqs are disabled. It causes oops
> because uart clocks are disabled.
>
> Remove also some unused extra code from omap_uart_can_sleep
>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/serial.c |   11 +----------
>  1 files changed, 1 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index ef30d8d..b06b797 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -314,21 +314,13 @@ void omap_uart_check_wakeup(void)
>  int omap_uart_can_sleep(void)
>  {
>  	struct omap_uart_state *uart;
> -	int can_sleep = 1;
>  
>  	list_for_each_entry(uart, &uart_list, node) {
> -		if (!uart->clocked)
> +		if (!uart->clocked || !uart->can_sleep)
>  			continue;
>  
> -		if (!uart->can_sleep) {
> -			can_sleep = 0;
> -			continue;
> -		}
> -
>  		/* This UART can now safely sleep. */
>  		omap_uart_allow_sleep(uart);
> -		if (clocks_off_while_idle)
> -			omap_uart_disable_clocks(uart);

If we remove this disable, then the fclks will have to be masked/ignored
in omap3_fclks_active() too.  This is what I was trying to avoid.

However, based on the potential race with ISRs you described, I think
this is the best option.

Kevin

>  	}
>  
>  	return 1;
> @@ -435,7 +427,6 @@ static void omap_uart_pm(struct uart_port *port,
>  		break;
>  	case 3: /* suspend */
>  		omap_uart_allow_sleep(uart);
> -		omap_uart_disable_clocks(uart);
>  		break;
>  	}
>  }
> -- 
> 1.6.0.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
