From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: Bypass the clock check.
Date: Fri, 21 Aug 2009 17:59:09 +0200
Message-ID: <87eir5ma42.fsf@deeprootsystems.com>
References: <1250846095-6381-1-git-send-email-santosh.shilimkar@ti.com>
	<1250846095-6381-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:40807 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbZHUP7P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 11:59:15 -0400
Received: by qw-out-2122.google.com with SMTP id 8so475409qwh.37
        for <linux-omap@vger.kernel.org>; Fri, 21 Aug 2009 08:59:16 -0700 (PDT)
In-Reply-To: <1250846095-6381-2-git-send-email-santosh.shilimkar@ti.com> (Santosh Shilimkar's message of "Fri\, 21 Aug 2009 14\:44\:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: rmk@arm.linux.org.uk, tony@atomide.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Syed Rafiuddin <rafiuddin.syed@ti.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Second reason of OMAP4 boot failure on 2.6.31.rc6, the UART
> platform data is not getting registered to kernel.
> Registration was failing because of clock check failure in
> omap_serial_init().
> Below patch fix the same.
>
> OMAP4 clock framework patches are still getting discussed on mailing
> list so till then we need this.
>
> Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> ---
>  arch/arm/mach-omap2/serial.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index e1be77b..e8d55f4 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -620,8 +620,10 @@ void __init omap_serial_init(void)
>  			uart->fck = NULL;
>  		}
>  
> -		if (!uart->ick || !uart->fck)
> -			continue;

I'd like to see another FIXME here to the effect that this can be removed
when OMAP4 clock framework is in place.

> +		if (!cpu_is_omap44xx()) {
> +			if (!uart->ick || !uart->fck)
> +				continue;
> +		}
>  
>  		uart->num = i;
>  		p->private_data = uart;
> -- 
> 1.5.4.7

Other than that,

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
