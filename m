From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 01/13] OMAP2/3: DMTIMER: Clear pending interrupts when
 stopping a timer
Date: Sun, 10 Jan 2010 13:12:22 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C0508DA2@dbde02.ent.ti.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57407 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874Ab0AJHmf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jan 2010 02:42:35 -0500
In-Reply-To: <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tero Kristo <tero.kristo@nokia.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
> Hilman
> Sent: Friday, January 08, 2010 11:29 PM
> To: linux-omap@vger.kernel.org
> Cc: Tero Kristo
> Subject: [PATCH 01/13] OMAP2/3: DMTIMER: Clear pending interrupts when stopping a timer
> 
> From: Tero Kristo <tero.kristo@nokia.com>
> 
> OMAP GP timers keep running for a few cycles after they are stopped,
> which can cause the timer to expire and generate an interrupt. The pending
> interrupt will prevent e.g. OMAP from entering suspend, thus we ack it
> manually.
> 
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/plat-omap/dmtimer.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 64f407e..5502ce8 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -551,6 +551,16 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
>  	if (l & OMAP_TIMER_CTRL_ST) {
>  		l &= ~0x1;
>  		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
> +		/* Readback to make sure write has completed */
> +		omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
Hopefully compiler don't optimize your readback.
> +		 /*
> +		  * Wait for functional clock period x 3.5 to make sure that
> +		  * timer is stopped
> +		  */
> +		udelay(3500000 / clk_get_rate(timer->fclk) + 1);
> +		/* Ack possibly pending interrupt */
> +		omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
> +				OMAP_TIMER_INT_OVERFLOW);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
> --
> 1.6.6.rc2.1.g42108
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
