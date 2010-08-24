From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 8/13] dmtimer: OMAP: multi-platform register access support
Date: Mon, 23 Aug 2010 17:19:12 -0700
Message-ID: <87iq30q2v3.fsf@deeprootsystems.com>
References: <1281800179-15085-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48335 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab0HXATO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 20:19:14 -0400
Received: by pvg2 with SMTP id 2so2471592pvg.19
        for <linux-omap@vger.kernel.org>; Mon, 23 Aug 2010 17:19:14 -0700 (PDT)
In-Reply-To: <1281800179-15085-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Sat, 14 Aug 2010 21:06:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Thara Gopinath <thara@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This patch uses the new register structures and mappings in functions
> in order to access register offsets thereby supporting multi-platform
> environment.
>
> Signed-off-by: Partha Basak <p-basak2@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/plat-omap/dmtimer.c |   51 ++++++++++++++++++++++++++++++++----------
>  1 files changed, 39 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 14a20e0..24ca283 100755
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -154,6 +154,7 @@ struct omap_dm_timer {
>  	unsigned long fclk_rate;
>  	int irq;
>  	void __iomem *io_base;
> +	u32	*regs;
>  	unsigned reserved:1;
>  	unsigned enabled:1;
>  	unsigned posted:1;
> @@ -174,13 +175,14 @@ static DEFINE_SPINLOCK(dm_timer_lock);
>   * pending bit must be checked. Otherwise a read of a non completed write
>   * will produce an error.
>   **/
> -static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
> +static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, int reg)

'reg' could stay unsigned, it's a non-zero index.  If anything, you
could change it to a u8.

>  {
>  	if (timer->posted)
> -		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
> -				& (reg >> WPSHIFT))
> +		while (readl(timer->io_base + \

'\' is not needed

[...]

Kevin
