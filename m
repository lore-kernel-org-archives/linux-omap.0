From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/14] ARM: OMAP2: Add functions to save and restore
 powerdomain context
Date: Thu, 12 Apr 2018 07:37:17 -0700
Message-ID: <20180412143717.GZ5700@atomide.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-6-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523505239-16229-6-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linus.walleij@linaro.org, grygorii.strashko@ti.com, t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180412 03:56]:
> From: Russ Dill <Russ.Dill@ti.com>
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -1199,3 +1199,63 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm)
>  
>  	return 0;
>  }
> +
> +/**
> + * pwrdm_save_context - save powerdomain registers
> + *
> + * Register state is going to be lost due to a suspend or hibernate
> + * event. Save the powerdomain registers.
> + */
> +static int pwrdm_save_context(struct powerdomain *pwrdm, void *unused)
> +{
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_save_context)
> +		arch_pwrdm->pwrdm_save_context(pwrdm);
> +	return 0;
> +}
> +
> +/**
> + * pwrdm_save_context - restore powerdomain registers
> + *
> + * Restore powerdomain control registers after a suspend or resume
> + * event.
> + */
> +static int pwrdm_restore_context(struct powerdomain *pwrdm, void *unused)
> +{
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_restore_context)
> +		arch_pwrdm->pwrdm_restore_context(pwrdm);
> +	return 0;
> +}

Here too we should use notifiers with the idea being that it allows making
powerdomains into a regular device driver eventually.

Regards,

Tony
