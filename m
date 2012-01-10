From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V2 1/3] arm:omap:omap4: Remove hardcoded reg-offs for PWRSTCTRL & PWRSTST
Date: Tue, 10 Jan 2012 10:09:56 -0800
Message-ID: <87y5tfpgy3.fsf@ti.com>
References: <1326017894-7632-1-git-send-email-hvaibhav@ti.com>
	<1326017894-7632-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:47304 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754282Ab2AJSJ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 13:09:59 -0500
Received: by mail-yx0-f181.google.com with SMTP id m3so2581622yen.40
        for <linux-omap@vger.kernel.org>; Tue, 10 Jan 2012 10:09:58 -0800 (PST)
In-Reply-To: <1326017894-7632-2-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Sun, 8 Jan 2012 15:48:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> This patch removes the existing hard-coded way of providing
> offset to omap4_prminst_xxx API's and instead use offsets
> provided in powerdomainsxxxx_data.
>
> Very much required for the new device AM33XX, where,
>
> PRM module in AM33XX is closer to OMAP4 PRM module, so it makes
> complete sense to reuse all the code from existing OMAP4 implementation.
> Having said that, ther is a catch here with respect to AM33XX device,
>
> The register offset in PRM module is not consistent
> across (crazy IP integration), for example,
>
> PRM_XXX         PWRSTCTRL PWRSTST RSTCTRL RSTST
> ===============================================
> PRM_PER_MOD:    0x0C,     0x08,   0x00,   0x04
> PRM_WKUP_MOD:   0x04,     0x08,   0x00,   0x0C
> PRM_MPU_MOD:    0x00,     0x04,   0x08,   NA
> PRM_DEVICE_MOD: NA,       NA,     0x00,   0x08
>
> So in order to reuse the existing OMAP4 code, we have to add
> seperate entry for register offsets, especially
> PWRSTCTRL & PWRSTST.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Reviewed-by: Kevin Hilman <khilman@ti.com>

Minor nit below, but after that, looks OK to me, but this should be
reviewed/merged by Paul/Benoit also.

[...]

>  void __init omap44xx_powerdomains_init(void)
>  {
> +	int i;
> +
>  	pwrdm_register_platform_funcs(&omap4_pwrdm_operations);
> +	/* Initialise PRM reg offs to default value */
> +	for (i = 0; powerdomains_omap44xx[i] != NULL; i++) {
> +		struct powerdomain *pwrdm = powerdomains_omap44xx[i];

insert blank line here

> +		pwrdm->pwrstctrl_offs = OMAP4_PM_PWSTCTRL;
> +		pwrdm->pwrstst_offs = OMAP4_PM_PWSTST;
> +	}
>  	pwrdm_register_pwrdms(powerdomains_omap44xx);
>  	pwrdm_complete_init();
>  }

Kevin
