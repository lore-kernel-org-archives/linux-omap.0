From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 02/19] OMAP3+: voltage: fix build warning
Date: Thu, 17 Mar 2011 07:49:22 -0700
Message-ID: <87k4fxby4t.fsf@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:57773 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754048Ab1CQOtq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 10:49:46 -0400
Received: by iyb26 with SMTP id 26so2956498iyb.6
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 07:49:25 -0700 (PDT)
In-Reply-To: <1299338962-5602-3-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 20:59:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>

Nishanth Menon <nm@ti.com> writes:

> Handle the case for a future SoC where sys_ck_name might be
> uninitialized. Fixes the build warning:
> arch/arm/mach-omap2/voltage.c: In function 'omap_voltage_late_init':
> arch/arm/mach-omap2/voltage.c:86:8: warning: 'sys_ck_name' may be used uninitialized in this function
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

This one seems to be already fixed in l-o commit:

commit c0718df4d666cc5fd8837ac93c82995a17bfdbf5
Author: Paul Walmsley <paul@pwsan.com>
Date:   Thu Mar 10 22:17:45 2011 -0700

    OMAP2+: voltage: reorganize, split code from data
    
Kevin

> ---
>  arch/arm/mach-omap2/voltage.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index e0cbd93..56961df 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -91,10 +91,14 @@ static int __init _config_common_vdd_data(struct omap_vdd_info *vdd)
>  	 * XXX Clockfw should handle this, or this should be in a
>  	 * struct record
>  	 */
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
>  		sys_ck_name = "sys_ck";
> -	else if (cpu_is_omap44xx())
> +	} else if (cpu_is_omap44xx()) {
>  		sys_ck_name = "sys_clkin_ck";
> +	} else {
> +		pr_err("%s: Unsupported OMAP\n", __func__);
> +		return -EINVAL;
> +	}
>  
>  	/*
>  	 * Sys clk rate is require to calculate vp timeout value and
