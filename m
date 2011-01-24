From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] perf: add OMAP support for the new power events
Date: Mon, 24 Jan 2011 20:25:48 +0530
Message-ID: <8d92d0aaa1ed67af244e8b50f9de372e@mail.gmail.com>
References: <1295878857-8983-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48402 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751817Ab1AXOzw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 09:55:52 -0500
Received: by mail-fx0-f48.google.com with SMTP id 2so4716680fxm.7
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 06:55:51 -0800 (PST)
In-Reply-To: <1295878857-8983-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com, Thomas Renninger <trenn@suse.de>, linux-omap@vger.kernel.org
Cc: Jean Pihet-XID <j-pihet@ti.com>

Jean

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
> Sent: Monday, January 24, 2011 7:51 PM
> To: Thomas Renninger; linux-omap@vger.kernel.org
> Cc: Jean Pihet
> Subject: [PATCH] perf: add OMAP support for the new power events
>
> From: Jean Pihet <j-pihet@ti.com>
>
> The patch adds the new power management trace points for
> the OMAP architecture.
>
> The trace points are for:
> - default idle handler. Since the cpuidle framework is
>   instrumented in the generic way there is no need to
>   add trace points in the OMAP specific cpuidle handler;
> - cpufreq (DVFS),
> - SoC clocks changes (enable, disable, set_rate),
> - change of power domains next power states.
>
> Tested on OMAP3 with suspend/resume, cpuidle, basic DVFS
>
[....]

> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-
> omap2/powerdomain.c
> index eaed0df..e1feb50 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -19,12 +19,15 @@
>  #include <linux/list.h>
>  #include <linux/errno.h>
>  #include <linux/string.h>
> +#include <trace/events/power.h>
> +
>  #include "cm2xxx_3xxx.h"
>  #include "prcm44xx.h"
>  #include "cm44xx.h"
>  #include "prm2xxx_3xxx.h"
>  #include "prm44xx.h"
>
> +#include <asm/cpu.h>
>  #include <plat/cpu.h>
>  #include "powerdomain.h"
>  #include "clockdomain.h"
> @@ -406,8 +409,11 @@ int pwrdm_set_next_pwrst(struct powerdomain
> *pwrdm, u8 pwrst)
>  	pr_debug("powerdomain: setting next powerstate for %s to
> %0x\n",
>  		 pwrdm->name, pwrst);
>
> -	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst)
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
> +		trace_power_domain_target(pwrdm->name, pwrst,
> +					  smp_processor_id());
>  		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
> +	}
>
>  	return ret;
>  }
We need to track the actual power domain transitions as well
at hardware level.
Can you please look at "pwrdm_pre_transition()" and
"pwrdm_post_transition()"
This code keep track of it using the next power state
and prev-power state.

Regards,
Santosh
