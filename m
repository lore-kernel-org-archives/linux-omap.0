From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/26] ARM: OMAP: dmtimer: Add function to check if timer
 is running
Date: Wed, 7 May 2014 08:25:22 -0700
Message-ID: <20140507152521.GE9502@atomide.com>
References: <1398375849-6017-1-git-send-email-joelf@ti.com>
 <1398375849-6017-5-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398375849-6017-5-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Joel Fernandes <joelf@ti.com> [140424 14:44]:
> Inorder to move non-DM timer specific code that modifies the "idlect"
> mask on OMAP1, from dmtimer code, to OMAP1 specific timer initialization code,
> we introduce a new function that can possibly be reused for other purposes in
> the future. The function just checks if a timer is running based on the timer ID
> which should be same as pdev->id. This allows us to cleanly separate the timer vs
> non-timer bits and keep the timer bits in the dmtimer code.
> 
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>  arch/arm/plat-omap/dmtimer.c              |   29 +++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/dmtimer.h |    2 ++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 4debb3d..86b2641 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -187,6 +187,35 @@ int omap_dm_timer_reserve_systimer(int id)
>  	return 0;
>  }
>  
> +/*
> + * Check if a timer is running based on timer_id, used for OMAP1 currently.
> + */
> +int omap_dm_timer_is_running(int timer_id)
> +{
> +	int i = 1, ret = 0;
> +	struct omap_dm_timer *timer = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dm_timer_lock, flags);
> +	list_for_each_entry(timer, &omap_timer_list, node) {
> +		if (i == timer_id) {
> +			u32 l;
> +			l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> +			if (l & OMAP_TIMER_CTRL_ST) {
> +				ret = 1;
> +				goto done;
> +			} else {
> +				goto done;
> +			}
> +		}
> +		i++;
> +	}
> +done:
> +	spin_unlock_irqrestore(&dm_timer_lock, flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(omap_dm_timer_is_running);

Let's not add new exported custom functions, let's instead try to get
rid of them. What needs to use this one?

Regards,


Tony
