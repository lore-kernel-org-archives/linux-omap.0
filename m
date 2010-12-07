From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP4: Pandaboad: Add omap_reserve functionality
Date: Tue, 07 Dec 2010 07:50:24 -0600
Message-ID: <4CFE3BA0.2030204@ti.com>
References: <1291724734-25070-1-git-send-email-raghuveer.murthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:40103 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751549Ab0LGNu1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 08:50:27 -0500
Received: by mail-vw0-f52.google.com with SMTP id 13so5309466vws.11
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 05:50:27 -0800 (PST)
In-Reply-To: <1291724734-25070-1-git-send-email-raghuveer.murthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raghuveer Murthy <raghuveer.murthy@ti.com>
Cc: linux-omap@vger.kernel.org

Raghuveer Murthy had written, on 12/07/2010 06:25 AM, the following:
> This patch adds omap_reserve functionality to board-omap4panda.c.
> Helps in the reserving boot time memory in SDRAM, used here for
> framebuffer allocation.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Since Russell did not directly contribute to this patch, you should 
rather give the reference commit ID where Russell patched similar issues 
and CC Russell here.

Also please CC linux-arm ML as well for these fixes to help Tony.

> Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index 1ecd0a6..ad6b5cc 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -392,6 +392,7 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
>  	/* Maintainer: David Anders - Texas Instruments Inc */
>  	.boot_params	= 0x80000100,
>  	.map_io		= omap4_panda_map_io,
> +	.reserve	= omap_reserve,
>  	.init_irq	= omap4_panda_init_irq,
>  	.init_machine	= omap4_panda_init,
>  	.timer		= &omap_timer,

Regards,
Nishanth Menon
