From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: cpuidle: Fix the C-state reporting to cpuidle governor.
Date: Tue, 07 Feb 2012 14:38:43 -0800
Message-ID: <87haz2gtfw.fsf@ti.com>
References: <1328521095-24025-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:36658 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756493Ab2BGWiw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Feb 2012 17:38:52 -0500
Received: by mail-pz0-f45.google.com with SMTP id p14so8062794dad.4
        for <linux-omap@vger.kernel.org>; Tue, 07 Feb 2012 14:38:51 -0800 (PST)
In-Reply-To: <1328521095-24025-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Mon, 6 Feb 2012 15:08:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> OMAP4 cpuidle driver is reporting the state requested by governor rather than
> the actually attempted one.
>
> This is obviously misleading sysfs and powertop cpuidle statistics.
> Fix it so that stats are reported correctly.
>
> Reported-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index cfdbb86..f128489 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -85,6 +85,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
>  	cpu1_state = pwrdm_read_pwrst(cpu1_pd);
>  	if (cpu1_state != PWRDM_POWER_OFF) {
>  		new_state_idx = drv->safe_state_index;
> +		index = drv->safe_state_index;

How about just get rid of new_state_idx all together and just update
index and use it to index in to the states.

Kevin

>  		cx = cpuidle_get_statedata(&dev->states_usage[new_state_idx]);
>  	}
