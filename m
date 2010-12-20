From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v7 12/12] OMAP2: dmtimer: set wakeup enable explicitly
 in plat
Date: Tue, 21 Dec 2010 00:11:35 +0100
Message-ID: <4D0FE2A7.2000506@ti.com>
References: <1292882719-30255-1-git-send-email-tarun.kanti@ti.com> <1292882719-30255-13-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47037 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755555Ab0LTXLh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 18:11:37 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oBKNBbMh007600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 17:11:37 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id oBKNBbUi012642
	for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 17:11:37 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id oBKNBbik009133
	for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 17:11:37 -0600 (CST)
In-Reply-To: <1292882719-30255-13-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tarun,

On 12/20/2010 11:05 PM, DebBarma, Tarun Kanti wrote:
> For some reason the wakeup enable bit is not getting set on OMAP2430,
> OMAP2420. This is inspite of the fact that SYSC_HAS_ENAWAKEUP flag is
> present in the hwmod database.

This is indeed strange. Did you observe that on OMAP3 & 4?
Did you use the patch that Kevin did recently to fix an issue with the 
ENAWAKEUP bit?
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=d15ae13fc7428a95b02c1935ebf92324fcb80a5f

The point is that this fix is not really acceptable for my point of view:-(
You really have to check what is going on in the hwmod _enable_wakeup 
function.

Regards,
Benoit

>
> I am not sure if there is already a patch to fix this problem. Until the
> reason is found we need this patch to boot on the above platforms.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
>   arch/arm/plat-omap/dmtimer.c |   13 +++++++++++++
>   1 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index f4aa4a1..007b754 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -227,6 +227,7 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
>
>   static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
>   {
> +	u32 l;
>   	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
>
>   	if (!pdata->is_omap16xx) {
> @@ -243,6 +244,18 @@ static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
>   	if (pdata->dm_timer_reset)
>   		pdata->dm_timer_reset(timer);
>
> +	/*
> +	 * Enable wake-up on OMAP2420, OMAP2430 CPUs.
> +	 * FIXME: SYSC_HAS_ENAWAKEUP flag is already set in hwmod database.
> +	 * But the setting does not seem to work. Need to investigate why
> +	 * this is happening.
> +	 */
> +	if (cpu_is_omap2430() || cpu_is_omap2420()) {
> +		l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
> +		l |= 1<<  2;
> +		omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
> +	}
> +
>   	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
>
>   	/* Match hardware reset default of posted mode */

