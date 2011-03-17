From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 03/19] OMAP3+: voltage: remove initial voltage
Date: Thu, 17 Mar 2011 07:53:46 -0700
Message-ID: <87bp19bxxh.fsf@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:54218 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754161Ab1CQOxu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 10:53:50 -0400
Received: by mail-gx0-f175.google.com with SMTP id 3so484755gxk.34
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 07:53:49 -0700 (PDT)
In-Reply-To: <1299338962-5602-4-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 20:59:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>

Nishanth Menon <nm@ti.com> writes:

> Blindly setting a 1.2V setting in the initial structure may not even
> match the default voltages stored in the voltage table which are
> supported for the domain. For example, OMAP3430 core domain does not
> use 1.2V and ends up generating a warning on the first transition.
>
> Further, since omap2_set_init_voltage is called as part of the pm
> framework's initialization sequence to configure the voltage required
> for the current OPP, the call does(and has to) setup the system
> voltage(curr_volt as a result) using the right mechanisms appropriate
> for the system at that point of time. This also overrides
> initialization we are currently doing in voltage.c making it
> redundant. So, remove the wrong and redundant initialization.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks queuing for 2.6.39 fixes (branch: for_2.6.39/pm-fixes)

Note: Nishanth, I queued the one with updated changelog from the tarball
you sent.)

Kevin

> ---
>  arch/arm/mach-omap2/voltage.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 56961df..1b40aa0 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -116,7 +116,6 @@ static int __init _config_common_vdd_data(struct omap_vdd_info *vdd)
>  	sys_clk_speed /= 1000;
>  
>  	/* Generic voltage parameters */
> -	vdd->curr_volt = 1200000;
>  	vdd->volt_scale = vp_forceupdate_scale_voltage;
>  	vdd->vp_enabled = false;
