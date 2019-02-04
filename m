From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: give off mode enable a more prominent place
Date: Mon, 4 Feb 2019 07:56:04 -0800
Message-ID: <20190204155604.GH5720@atomide.com>
References: <20190202055827.12956-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190202055827.12956-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: linux@armlinux.org.uk, khilman@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190202 06:01]:
> Enabling off mode was only reachable deeply hidden
> in the debugfs. As powersaving is an important feature,
> move the option out of its shady place.

How about let's enable always if we have the twl4030
configured to allow it? You can just check if the dts has
"ti,twl4030-power-idle" or "ti,twl4030-power-idle-osc-off"
properties set.

In order to enable deeper idle states, the user space still
needs to idle the UARTs and possibly other hardware blocking
idle. So we should be safe there.

> The debugfs file can still be used to override the default.

Yes let's keep the debugfs switch around. But it should
be optional for CONFIG_DEBUGFS like I think it now is.

> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -416,7 +416,12 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
>  	if (!pwrst)
>  		return -ENOMEM;
>  	pwrst->pwrdm = pwrdm;
> -	pwrst->next_state = PWRDM_POWER_RET;
> +
> +	if (IS_ENABLED(CONFIG_OMAP3_PM_OFFMODE))
> +		pwrst->next_state = PWRDM_POWER_OFF;
> +	else
> +		pwrst->next_state = PWRDM_POWER_RET;
> +
>  	list_add(&pwrst->node, &pwrst_list);
>  
>  	if (pwrdm_has_hdwr_sar(pwrdm))

You can check for the PMIC properties by adding a function
for omap3_pm_check_pmic() or similar and call it
from omap3_pm_init(). And then you can set the needed flags
in omap3_pm_check_pmic() such as omap3_has_twl and off mode.
You might want to make it somewhat PMIC independent as in
theory somebody may still want to add support for other
PMICs such as cpacp for omap3 although that's unlikely.

Regards,

Tony
