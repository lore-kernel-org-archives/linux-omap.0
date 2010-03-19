From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap: fix clocksource_32k to start from zero
Date: Fri, 19 Mar 2010 10:41:02 -0700
Message-ID: <87iq8sxl8x.fsf@deeprootsystems.com>
References: <1269007534-9282-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62292 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab0CSRlG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 13:41:06 -0400
Received: by pva4 with SMTP id 4so1716719pva.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Mar 2010 10:41:05 -0700 (PDT)
In-Reply-To: <1269007534-9282-1-git-send-email-aaro.koskinen@nokia.com> (Aaro Koskinen's message of "Fri\, 19 Mar 2010 16\:05\:34 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Aaro Koskinen <aaro.koskinen@nokia.com> writes:

> When the 32k sync timer is used for sched_clock(), it should count
> time from the kernel boot (clocksource init) instead of the last HW
> reset. Otherwise printk.time values will jump suddenly during the boot:
>
> 	[    0.000000] calling  omap2_clk_arch_init+0x0/0x138 @ 1
> 	[    0.000000] initcall omap2_clk_arch_init+0x0/0x138 returned -22 after 0 usecs
> 	[    0.000000] initcall omap2_clk_arch_init+0x0/0x138 returned with error code -22
> 	[    0.000000] calling  omap_init_clocksource_32k+0x0/0x98 @ 1
> 	[  508.697937] initcall omap_init_clocksource_32k+0x0/0x98 returned 0 after 0 usecs
> 	[  508.697967] calling  omap_init_devices+0x0/0x38 @ 1
> 	[  508.698425] initcall omap_init_devices+0x0/0x38 returned 0 after 0 usecs
>
> This will confuse tools such as scripts/bootgraph.pl.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>
> See also the thread in linux-kernel:
> http://marc.info/?t=126893533300022&r=1&w=2
>
>  arch/arm/plat-omap/common.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> index 088c1a0..ce2ad10 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -100,10 +100,12 @@ EXPORT_SYMBOL(omap_get_var_config);
>  
>  #include <linux/clocksource.h>
>  
> +static u32 offset_32k __read_mostly;
> +

I think you need a comment in the code here as well, something like
the first sentence from the changelog, so readers of this code can
make easy sense of the '- offset_32k'.

Otherwise,

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
