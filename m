From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH PM-20081119] OMAP: PM: Check both, IOPAD and UART wakeup always
Date: Thu, 20 Nov 2008 09:41:40 -0800
Message-ID: <87prkqb8h7.fsf@deeprootsystems.com>
References: <1227170626-22021-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:50612 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbYKTRlo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 12:41:44 -0500
Received: by qyk4 with SMTP id 4so520459qyk.13
        for <linux-omap@vger.kernel.org>; Thu, 20 Nov 2008 09:41:43 -0800 (PST)
In-Reply-To: <1227170626-22021-1-git-send-email-jouni.hogander@nokia.com> (Jouni Hogander's message of "Thu\, 20 Nov 2008 10\:43\:46 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

Jouni Hogander <jouni.hogander@nokia.com> writes:

> Uart RX might not always generate IOPAD wake-up. E.g. IOPAD is not
> enabled or core was not in sleep state.
>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>

Thanks, applying to pm-20081119.

Kevin

>  arch/arm/mach-omap2/serial.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 745ae5c..8d2f0b1 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -281,7 +281,7 @@ void omap_uart_resume_idle(int num)
>  			}
>  
>  			/* Check for normal UART wakeup */
> -			else if (__raw_readl(uart->wk_st) & uart->wk_mask)
> +			if (__raw_readl(uart->wk_st) & uart->wk_mask)
>  				omap_uart_block_sleep(uart);
>  
>  			return;
> -- 
> 1.6.0.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
