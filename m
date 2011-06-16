From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm-wip/voltdm_nm][PATCH 09/10] OMAP2+: PM: secure OPP access using rcu locks
Date: Thu, 16 Jun 2011 13:47:05 -0700
Message-ID: <87d3idh5bq.fsf@ti.com>
References: <1307412972-25854-1-git-send-email-nm@ti.com>
	<1307412972-25854-10-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:57273 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933015Ab1FPUrI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 16:47:08 -0400
Received: by mail-pw0-f48.google.com with SMTP id 16so903685pwi.7
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 13:47:07 -0700 (PDT)
In-Reply-To: <1307412972-25854-10-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Mon, 6 Jun 2011 21:16:12 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> OPP functions as described in Documentation/power/opp.txt
> should be accessed under rcu_locks.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

This looks like a fix needed in mainline.

Please send as a standalone patch against mainline and Cc
linux-arm-kernel.

Thanks,

Kevin

> ---
>  arch/arm/mach-omap2/pm.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index d085f29..7355347 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -198,14 +198,17 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
>  	freq = clk->rate;
>  	clk_put(clk);
>  
> +	rcu_read_lock();
>  	opp = opp_find_freq_ceil(dev, &freq);
>  	if (IS_ERR(opp)) {
> +		rcu_read_unlock();
>  		printk(KERN_ERR "%s: unable to find boot up OPP for vdd_%s\n",
>  			__func__, vdd_name);
>  		goto exit;
>  	}
>  
>  	bootup_volt = opp_get_voltage(opp);
> +	rcu_read_unlock();
>  	if (!bootup_volt) {
>  		printk(KERN_ERR "%s: unable to find voltage corresponding"
>  			"to the bootup OPP for vdd_%s\n", __func__, vdd_name);
