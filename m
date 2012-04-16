From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: dmtimer: cleanup iclk usage
Date: Mon, 16 Apr 2012 10:50:08 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204161049250.29048@utopia.booyaka.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com> <1334579125-15566-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51477 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab2DPQuJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 12:50:09 -0400
In-Reply-To: <1334579125-15566-3-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com

Hi Tarun,

by the way,

On Mon, 16 Apr 2012, Tarun Kanti DebBarma wrote:

> We do not use iclk anywhere in the dmtimer driver and so removing it.
> Hence removing the timer iclk entries from OMAP4 clkdev table as well.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
>  arch/arm/mach-omap2/clock44xx_data.c      |   11 -----------
>  arch/arm/mach-omap2/timer.c               |    7 -------
>  arch/arm/plat-omap/include/plat/dmtimer.h |    2 +-
>  3 files changed, 1 insertions(+), 19 deletions(-)
> 

...

> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
> index 9418f00..be2b8c4 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -259,7 +259,7 @@ struct omap_dm_timer {
>  	unsigned long phys_base;
>  	int id;
>  	int irq;
> -	struct clk *iclk, *fclk;
> +	struct clk *fclk;
>  
>  	void __iomem	*io_base;
>  	void __iomem	*sys_stat;	/* TISTAT timer status */

Am dropping this stray change, it seems unrelated to the rest of the 
patch.


- Paul
