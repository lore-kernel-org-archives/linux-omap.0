From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: omap4: rename gpmc clock to gpmc_ick
Date: Tue, 05 Jul 2011 09:49:46 -0700
Message-ID: <4E1340AA.2020007@ti.com>
References: <1309868377-22379-1-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:56071 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755896Ab1GEQtu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 12:49:50 -0400
Received: by mail-gx0-f174.google.com with SMTP id 21so2303828gxk.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Jul 2011 09:49:49 -0700 (PDT)
In-Reply-To: <1309868377-22379-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, tony@atomide.com, Benoit Cousson <b-cousson@ti.com>

+ Benoit

On 7/5/2011 5:19 AM, Jan Weitzel wrote:
> The gpmc clock on omap44xx is called gpmc_ick not gpmc_ck in
> clock44xx_data.c
>
> Signed-off-by: Jan Weitzel<j.weitzel@phytec.de>
This happened after renaming the clock-nodes some time back.
Looks good to me as a fix though in long run GPMC should be
moved to hwmod to avoid such naming issues

> ---
>   arch/arm/mach-omap2/gpmc.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 130034b..34bcd17 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -708,7 +708,7 @@ static int __init gpmc_init(void)
>   		l = OMAP34XX_GPMC_BASE;
>   		gpmc_irq = INT_34XX_GPMC_IRQ;
>   	} else if (cpu_is_omap44xx()) {
> -		ck = "gpmc_ck";
> +		ck = "gpmc_ick";
>   		l = OMAP44XX_GPMC_BASE;
>   		gpmc_irq = OMAP44XX_IRQ_GPMC;
>   	}

