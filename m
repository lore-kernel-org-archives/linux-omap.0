From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v14 REPOST 11/12] OMAP: dmtimer: add context save/restore
 routines
Date: Fri, 26 Aug 2011 21:16:12 +0530
Message-ID: <4E57BFC4.3030502@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com> <1310731501-13078-12-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:38942 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754017Ab1HZPqU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 11:46:20 -0400
Received: by mail-yw0-f48.google.com with SMTP id 26so3917042ywb.35
        for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 08:46:18 -0700 (PDT)
In-Reply-To: <1310731501-13078-12-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Friday 15 July 2011 05:35 PM, Tarun Kanti DebBarma wrote:
> Define context register structure and make it member of struct omap_dm_timer.
> Also define two routines to save and restore dmtimer context to be used
> subsequently.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
>   arch/arm/plat-omap/dmtimer.c              |   48 +++++++++++++++++++++++++++++
>   arch/arm/plat-omap/include/plat/dmtimer.h |   24 ++++++++++++++
>   2 files changed, 72 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 8c8cb00..cdef48b 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -87,6 +87,54 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
>   				timer->func_offset);
>   }
>
> +static void omap_timer_save_context(struct omap_dm_timer *timer)
> +{
> +	timer->context.tiocp_cfg =
> +		omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
> +	timer->context.tistat =
> +		omap_dm_timer_read_reg(timer, OMAP_TIMER_SYS_STAT_REG);
> +	timer->context.tisr =
> +		omap_dm_timer_read_reg(timer, OMAP_TIMER_STAT_REG);
> +	timer->context.tier =
> +		omap_dm_timer_read_reg(timer, OMAP_TIMER_INT_EN_REG);
> +	timer->context.twer =
> +		omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG);
> +	timer->context.tclr =
> +		omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> +	timer->context.tcrr =
> +		omap_dm_timer_read_reg(timer, OMAP_TIMER_COUNTER_REG);
> +	timer->context.tldr =
> +		omap_dm_timer_read_reg(timer, OMAP_TIMER_LOAD_REG);
> +	timer->context.tmar =
> +		omap_dm_timer_read_reg(timer, OMAP_TIMER_MATCH_REG);
> +	timer->context.tsicr =
> +		omap_dm_timer_read_reg(timer, OMAP_TIMER_IF_CTRL_REG);
> +}
> +
> +static void omap_timer_restore_context(struct omap_dm_timer *timer)
> +{
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG,
> +				timer->context.tiocp_cfg);
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_SYS_STAT_REG,
> +				timer->context.tistat);
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
> +				timer->context.tisr);
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_INT_EN_REG,
> +				timer->context.tier);
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG,
> +				timer->context.twer);
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG,
> +				timer->context.tclr);
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG,
> +				timer->context.tcrr);
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG,
> +				timer->context.tldr);
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG,
> +				timer->context.tmar);
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
> +				timer->context.tsicr);
> +}
> +
Looks good.
Take care of ordering of the restore code similar to
GPIO code.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Regards
Santosh
