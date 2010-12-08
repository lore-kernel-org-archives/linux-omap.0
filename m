From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2] OMAP4: Pandaboard: Add omap_reserve functionality
Date: Wed, 8 Dec 2010 12:07:13 +0100
Message-ID: <201012081207.14044.marek.vasut@gmail.com>
References: <1291792247-26634-1-git-send-email-raghuveer.murthy@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:62513 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab0LHLFZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 06:05:25 -0500
Received: by fxm18 with SMTP id 18so918826fxm.2
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 03:05:23 -0800 (PST)
In-Reply-To: <1291792247-26634-1-git-send-email-raghuveer.murthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raghuveer Murthy <raghuveer.murthy@ti.com>
Cc: linux-omap@vger.kernel.org, rmk+kernel@arm.linux.org.uk, linux-arm@lists.arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

On Wednesday 08 December 2010 08:10:47 Raghuveer Murthy wrote:
> This patch adds omap_reserve functionality to board-omap4panda.c.
> Helps in the reserving boot time memory in SDRAM, used here for
> framebuffer allocation.
> 
> This patch is in similar lines to commit id 71ee7dad9b6991, from
> Russell king

Russell King ... it's a surname, not a title :-D

btw. CCing linux-arm-kernel, as that's a proper mailing list.

Cheers
> 
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: linux-arm@lists.arm.linux.org.uk
> Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c
> b/arch/arm/mach-omap2/board-omap4panda.c index da24745..0ccc24f 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -393,6 +393,7 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
>  	/* Maintainer: David Anders - Texas Instruments Inc */
>  	.boot_params	= 0x80000100,
>  	.map_io		= omap4_panda_map_io,
> +	.reserve	= omap_reserve,
>  	.init_irq	= omap4_panda_init_irq,
>  	.init_machine	= omap4_panda_init,
>  	.timer		= &omap_timer,
