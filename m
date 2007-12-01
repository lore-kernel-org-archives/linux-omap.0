From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Check the get_cover_state function pointer
	if not set
Date: Fri, 30 Nov 2007 16:06:06 -0800
Message-ID: <20071201000606.GL7498@atomide.com>
References: <20071129080111.GA879@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071129080111.GA879@party>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kyungmin Park <kyungmin.park@samsung.com> [071129 00:01]:
> If the get_cover_state is not set, it occurs the oops.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index cf9d31c..d7ecece 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -238,7 +238,9 @@ static void mmc_omap_release_slot(struct mmc_omap_slot *slot)
>  static inline
>  int mmc_omap_cover_is_open(struct mmc_omap_slot *slot)
>  {
> -	return slot->pdata->get_cover_state(mmc_dev(slot->mmc), slot->id);
> +	if (slot->pdata->get_cover_state)
> +		return slot->pdata->get_cover_state(mmc_dev(slot->mmc), slot->id);
> +	return 0;
>  }
>  
>  static ssize_t

Pushing today.

Tony
