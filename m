From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC v2][PATCH 5/5] omap3: serial: Add uart4 wakeup handling
Date: Fri, 26 Feb 2010 11:43:34 -0800
Message-ID: <87ocjbixzt.fsf@deeprootsystems.com>
References: <1267199592-2245-1-git-send-email-saaguirre@ti.com>
	<1267199592-2245-6-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:38083 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965843Ab0BZTnh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 14:43:37 -0500
Received: by iwn12 with SMTP id 12so465396iwn.21
        for <linux-omap@vger.kernel.org>; Fri, 26 Feb 2010 11:43:36 -0800 (PST)
In-Reply-To: <1267199592-2245-6-git-send-email-saaguirre@ti.com> (Sergio Aguirre's message of "Fri\, 26 Feb 2010 09\:53\:12 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-omap@vger.kernel.org

Sergio Aguirre <saaguirre@ti.com> writes:

This one needs a better changelog also.

Otherwise, change looks right.

Kevin

> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index da77930..6e1b17e 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -475,6 +475,10 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
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
> -- 
> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
