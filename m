From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 06/10] OMAP: GPIO: Use USHRT_MAX for rev offset instead of -1
Date: Thu, 19 May 2011 17:59:36 +0200
Message-ID: <87ei3u8yvr.fsf@ti.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
	<1305546104-1511-7-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:33159 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754146Ab1ESP7o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 11:59:44 -0400
Received: by mail-ww0-f41.google.com with SMTP id 18so5777235wwi.4
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 08:59:40 -0700 (PDT)
In-Reply-To: <1305546104-1511-7-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Mon, 16 May 2011 17:11:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Charulatha V <charu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> Use USHRT_MAX for revision offset instead of -1 if revision register
> is not available for a given SoC since rev offset is a u16 value.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

Thanks, folded this into the original.

Kevin

> ---
>  arch/arm/mach-omap1/gpio15xx.c |    2 +-
>  arch/arm/mach-omap1/gpio16xx.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
> index 7a15f69..f18a4a9 100644
> --- a/arch/arm/mach-omap1/gpio15xx.c
> +++ b/arch/arm/mach-omap1/gpio15xx.c
> @@ -77,7 +77,7 @@ static struct __initdata resource omap15xx_gpio_resources[] = {
>  };
>  
>  static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
> -	.revision	= -1,
> +	.revision	= USHRT_MAX,
>  	.direction	= OMAP1510_GPIO_DIR_CONTROL,
>  	.datain		= OMAP1510_GPIO_DATA_INPUT,
>  	.dataout	= OMAP1510_GPIO_DATA_OUTPUT,
> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
> index 43718ec..d886b88 100644
> --- a/arch/arm/mach-omap1/gpio16xx.c
> +++ b/arch/arm/mach-omap1/gpio16xx.c
> @@ -38,7 +38,7 @@ static struct __initdata resource omap16xx_mpu_gpio_resources[] = {
>  };
>  
>  static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
> -	.revision       = -1,
> +	.revision       = USHRT_MAX,
>  	.direction	= OMAP_MPUIO_IO_CNTL,
>  	.datain		= OMAP_MPUIO_INPUT_LATCH,
>  	.dataout	= OMAP_MPUIO_OUTPUT,
