From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v14 REPOST 12/12] OMAP: dmtimer: Off mode support
Date: Fri, 26 Aug 2011 21:34:33 +0530
Message-ID: <4E57C411.3050906@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com> <1310731501-13078-13-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:32893 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754352Ab1HZQEl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 12:04:41 -0400
Received: by mail-yw0-f48.google.com with SMTP id 26so3936115ywb.35
        for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 09:04:40 -0700 (PDT)
In-Reply-To: <1310731501-13078-13-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Friday 15 July 2011 05:35 PM, Tarun Kanti DebBarma wrote:
> Clock is enabled only when timer is started and disabled when the the timer
> is stopped. Therefore before accessing registers in functions clock is enabled
> and then disabled back at the end of access.
> Context save and restore functions are called as needed based upon whether the
> context is lost or not.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
>   arch/arm/mach-omap2/timer.c               |   17 +++++
>   arch/arm/plat-omap/dmtimer.c              |   97 +++++++++++++++++++++++++++--
>   arch/arm/plat-omap/include/plat/dmtimer.h |    9 +++
>   3 files changed, 118 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 9d47300..d1c6219 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -44,6 +44,9 @@
>   #include<plat/common.h>
>   #include<plat/omap_hwmod.h>
>   #include<plat/omap_device.h>
> +#include<plat/omap-pm.h>
> +
> +#include "powerdomain.h"
>
>   /* Parent clocks, eventually these will come from the clock framework */
>
> @@ -409,6 +412,16 @@ static int omap2_dm_timer_set_src(struct platform_device *pdev, int source)
>   	return ret;
>   }
>
> +#ifdef CONFIG_PM
> +static int omap_timer_get_context_loss(struct device *dev)
> +{
> +	return omap_pm_get_dev_context_loss_count(dev);
> +}
> +
> +#else
> +#define omap_gpio_get_context_loss NULL
> +#endif
> +
>   struct omap_device_pm_latency omap2_dmtimer_latency[] = {
>   	{
>   		.deactivate_func = omap_device_idle_hwmods,
> @@ -437,6 +450,7 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
>   	struct dmtimer_platform_data *pdata;
>   	struct omap_device *od;
>   	struct omap_timer_capability_dev_attr *timer_dev_attr;
> +	struct powerdomain *pwrdm;
>
>   	pr_debug("%s: %s\n", __func__, oh->name);
>
> @@ -466,6 +480,9 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
>
>   	pdata->set_timer_src = omap2_dm_timer_set_src;
>   	pdata->timer_ip_type = oh->class->rev;
> +	pwrdm = omap_hwmod_get_pwrdm(oh);
> +	pdata->loses_context = pwrdm_can_ever_lose_context(pwrdm);
> +	pdata->get_context_loss_count = omap_timer_get_context_loss;
>
>   	od = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
>   			omap2_dmtimer_latency,
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index cdef48b..db14d7f 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -151,12 +151,14 @@ static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
>
>   static void omap_dm_timer_reset(struct omap_dm_timer *timer)
>   {
> +	omap_dm_timer_enable(timer);
>   	if (timer->pdev->id != 1) {
>   		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
>   		omap_dm_timer_wait_for_reset(timer);
>   	}
>
>   	__omap_dm_timer_reset(timer->io_base, 0, 0, timer->func_offset);
> +	omap_dm_timer_disable(timer);
>   	timer->posted = 1;
>   }
>
> @@ -171,14 +173,13 @@ void omap_dm_timer_prepare(struct omap_dm_timer *timer)
>   		return;
>   	}
>
> -	omap_dm_timer_enable(timer);
> -
>   	if (pdata->needs_manual_reset)
>   		omap_dm_timer_reset(timer);
>
>   	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
>
>   	timer->posted = 1;
> +	timer->context_changed = true;
You should protect these variables from races.

>   }
>
>   struct omap_dm_timer *omap_dm_timer_request(void)
> @@ -230,7 +231,6 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
>
>   void omap_dm_timer_free(struct omap_dm_timer *timer)
>   {
> -	omap_dm_timer_disable(timer);
>   	clk_put(timer->fclk);
>
>   	WARN_ON(!timer->reserved);
> @@ -311,6 +311,11 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
>
>   void omap_dm_timer_trigger(struct omap_dm_timer *timer)
>   {
> +	if (unlikely(!timer->reserved)) {
> +		pr_err("%s: timer%d not enabled.\n", __func__, timer->id);
> +		return;
> +	}
> +
>   	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
>   }
>   EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
> @@ -319,6 +324,20 @@ void omap_dm_timer_start(struct omap_dm_timer *timer)
>   {
>   	u32 l;
>
> +	omap_dm_timer_enable(timer);
> +
> +	if (timer->loses_context) {
> +		u32 ctx_loss_cnt_after;
> +
> +		ctx_loss_cnt_after =
> +			timer->get_context_loss_count(&timer->pdev->dev);
> +		if ((ctx_loss_cnt_after != timer->ctx_loss_count)&&
> +					timer->context_saved) {
> +			omap_timer_restore_context(timer);
> +			timer->context_saved = false;
Ditto. It applies to rest of the patch.

Rest look ok.

Regards
Santosh

