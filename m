From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv4 7/14] OMAP: dmtimer: use list instead of static array
Date: Tue, 23 Nov 2010 16:22:21 +0100
Message-ID: <4CEBDC2D.90607@ti.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com> <1290220778-22244-2-git-send-email-tarun.kanti@ti.com> <1290220778-22244-3-git-send-email-tarun.kanti@ti.com> <1290220778-22244-4-git-send-email-tarun.kanti@ti.com> <1290220778-22244-5-git-send-email-tarun.kanti@ti.com> <1290220778-22244-6-git-send-email-tarun.kanti@ti.com> <1290220778-22244-7-git-send-email-tarun.kanti@ti.com> <1290220778-22244-8-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38757 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952Ab0KWPWY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Nov 2010 10:22:24 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id oANFMOXj023131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 09:22:24 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id oANFMNEQ028998
	for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 09:22:23 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id oANFMNXc017216
	for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 09:22:23 -0600 (CST)
In-Reply-To: <1290220778-22244-8-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 11/20/2010 3:39 AM, Tarun Kanti DebBarma wrote:
> Convert dmtimers static array in functions into list structure.
> Please note that the static arrays will be completely removed
> in subsequent patches when dmtimer is converted to platform driver.

Why do you still need to keep your own list of timers?
The driver already contains a list of devices.
You even have some iterator available in the kernel: 
driver_for_each_device or driver_find_device.

You could probably get rid of all that stuff for my point of view.

Benoit

>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
>   arch/arm/plat-omap/dmtimer.c |   67 +++++++++++++++++++++++-------------------
>   1 files changed, 37 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 10daa9d..124fd21 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -168,6 +168,7 @@ struct omap_dm_timer {
>   	unsigned enabled:1;
>   	unsigned posted:1;
>   	struct platform_device *pdev;
> +	struct list_head node;
>   };
>
>   static int dm_timer_count;
> @@ -290,7 +291,8 @@ static struct omap_dm_timer *dm_timers;
>   static const char **dm_source_names;
>   static struct clk **dm_source_clocks;
>
> -static spinlock_t dm_timer_lock;
> +static LIST_HEAD(omap_timer_list);
> +static DEFINE_SPINLOCK(dm_timer_lock);
>
>   /*
>    * Reads timer registers in posted and non-posted mode. The posted mode bit
> @@ -340,7 +342,7 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
>   {
>   	u32 l;
>
> -	if (!cpu_class_is_omap2() || timer !=&dm_timers[0]) {
> +	if (!cpu_class_is_omap2() || timer->id != 1) {
>   		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
>   		omap_dm_timer_wait_for_reset(timer);
>   	}
> @@ -371,23 +373,24 @@ static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
>
>   struct omap_dm_timer *omap_dm_timer_request(void)
>   {
> -	struct omap_dm_timer *timer = NULL;
> +	struct omap_dm_timer *timer = NULL, *t;
>   	unsigned long flags;
> -	int i;
>
>   	spin_lock_irqsave(&dm_timer_lock, flags);
> -	for (i = 0; i<  dm_timer_count; i++) {
> -		if (dm_timers[i].reserved)
> +	list_for_each_entry(t,&omap_timer_list, node) {
> +		if (t->reserved)
>   			continue;
>
> -		timer =&dm_timers[i];
> +		timer = t;
>   		timer->reserved = 1;
>   		break;
>   	}
>   	spin_unlock_irqrestore(&dm_timer_lock, flags);
>
> -	if (timer != NULL)
> +	if (timer)
>   		omap_dm_timer_prepare(timer);
> +	else
> +		pr_debug("%s: free timer not available.\n", __func__);
>
>   	return timer;
>   }
> @@ -395,23 +398,23 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request);
>
>   struct omap_dm_timer *omap_dm_timer_request_specific(int id)
>   {
> -	struct omap_dm_timer *timer;
> +	struct omap_dm_timer *timer = NULL, *t;
>   	unsigned long flags;
>
>   	spin_lock_irqsave(&dm_timer_lock, flags);
> -	if (id<= 0 || id>  dm_timer_count || dm_timers[id-1].reserved) {
> -		spin_unlock_irqrestore(&dm_timer_lock, flags);
> -		printk("BUG: warning at %s:%d/%s(): unable to get timer %d\n",
> -		       __FILE__, __LINE__, __func__, id);
> -		dump_stack();
> -		return NULL;
> +	list_for_each_entry(t,&omap_timer_list, node) {
> +		if (t->id == id&&  !t->reserved) {
> +			timer = t;
> +			timer->reserved = 1;
> +			break;
> +		}
>   	}
> -
> -	timer =&dm_timers[id-1];
> -	timer->reserved = 1;
>   	spin_unlock_irqrestore(&dm_timer_lock, flags);
>
> -	omap_dm_timer_prepare(timer);
> +	if (timer)
> +		omap_dm_timer_prepare(timer);
> +	else
> +		pr_debug("%s: timer%d not available.\n", __func__, id);
>
>   	return timer;
>   }
> @@ -474,24 +477,29 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
>    */
>   __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
>   {
> -	int i;
> +	int i = 0;
> +	struct omap_dm_timer *timer = NULL;
> +	unsigned long flags;
>
>   	/* If ARMXOR cannot be idled this function call is unnecessary */
>   	if (!(inputmask&  (1<<  1)))
>   		return inputmask;
>
>   	/* If any active timer is using ARMXOR return modified mask */
> -	for (i = 0; i<  dm_timer_count; i++) {
> +	spin_lock_irqsave(&dm_timer_lock, flags);
> +	list_for_each_entry(timer,&omap_timer_list, node) {
>   		u32 l;
>
> -		l = omap_dm_timer_read_reg(&dm_timers[i], OMAP_TIMER_CTRL_REG);
> +		l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
>   		if (l&  OMAP_TIMER_CTRL_ST) {
>   			if (((omap_readl(MOD_CONF_CTRL_1)>>  (i * 2))&  0x03) == 0)
>   				inputmask&= ~(1<<  1);
>   			else
>   				inputmask&= ~(1<<  2);
>   		}
> +		i++;
>   	}
> +	spin_unlock_irqrestore(&dm_timer_lock, flags);
>
>   	return inputmask;
>   }
> @@ -722,13 +730,9 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
>
>   int omap_dm_timers_active(void)
>   {
> -	int i;
> -
> -	for (i = 0; i<  dm_timer_count; i++) {
> -		struct omap_dm_timer *timer;
> -
> -		timer =&dm_timers[i];
> +	struct omap_dm_timer *timer;
>
> +	list_for_each_entry(timer,&omap_timer_list, node) {
>   		if (!timer->enabled)
>   			continue;
>
> @@ -743,14 +747,13 @@ EXPORT_SYMBOL_GPL(omap_dm_timers_active);
>
>   int __init omap_dm_timer_init(void)
>   {
> +	unsigned long flags;
>   	struct omap_dm_timer *timer;
>   	int i, map_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
>
>   	if (!(cpu_is_omap16xx() || cpu_class_is_omap2()))
>   		return -ENODEV;
>
> -	spin_lock_init(&dm_timer_lock);
> -
>   	if (cpu_class_is_omap1()) {
>   		dm_timers = omap1_dm_timers;
>   		dm_timer_count = omap1_dm_timer_count;
> @@ -795,6 +798,10 @@ int __init omap_dm_timer_init(void)
>   			timer->fclk = clk_get(NULL, clk_name);
>   		}
>   #endif
> +		timer->id = i + 1; /* id starts from 1*/
> +		spin_lock_irqsave(&dm_timer_lock, flags);
> +		list_add_tail(&timer->node,&omap_timer_list);
> +		spin_unlock_irqrestore(&dm_timer_lock, flags);
>   	}
>
>   	return 0;

