From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/3] OMAP3: PM: Configure PRM setup times from board files
Date: Tue, 13 Oct 2009 12:35:21 -0700
Message-ID: <873a5njddy.fsf@deeprootsystems.com>
References: <1255354960-7873-1-git-send-email-rnayak@ti.com>
	<1255354960-7873-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:61655 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbZJMTf7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 15:35:59 -0400
Received: by pxi10 with SMTP id 10so177834pxi.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 12:35:22 -0700 (PDT)
In-Reply-To: <1255354960-7873-2-git-send-email-rnayak@ti.com> (Rajendra Nayak's message of "Mon\, 12 Oct 2009 19\:12\:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Rajendra Nayak <rnayak@ti.com> writes:

> The setup times to be programmed in the PRM module on OMAP
> (for clksetup, voltsetup etc) are board specific.
> They depend heavily on the PMIC used and even on different boards
> with the same PMIC, they vary based on the sleep/wake
> sequence used, system clock speed et al.
>
> This patch makes it possible for these setup values to be
> configured from different board files.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

[...]

> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 2242d23..6f2fb51 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -1084,6 +1084,9 @@ int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
>  
>  void omap3_set_prm_setup_vc(struct prm_setup_vc *setup_vc)
>  {
> +	if (!setup_vc)
> +		return;
> +
>  	prm_setup.clksetup = setup_vc->clksetup;
>  	prm_setup.voltsetup_time1 = setup_vc->voltsetup_time1;
>  	prm_setup.voltsetup_time2 = setup_vc->voltsetup_time2;
> @@ -1285,13 +1288,15 @@ static void __init configure_vc(void)
>  
>  void omap3_pm_early_init(struct omap_opp *mpu_opps,
>  			 struct omap_opp *dsp_opps,
> -			 struct omap_opp *l3_opps)
> +			 struct omap_opp *l3_opps,
> +			 struct prm_setup_vc *setup_times)
>  {
>  	prm_clear_mod_reg_bits(OMAP3430_OFFMODE_POL, OMAP3430_GR_MOD,
>  				OMAP3_PRM_POLCTRL_OFFSET);
>  
>  	configure_vc();
>  	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
> +	omap3_set_prm_setup_vc(setup_times);

I think there's an ordering problem here since the configure_vc()
which uses the values is called before the setup_vc().

Also, if setup_times is passed as NULL, configure_vc() will be writing
wrong values with undefined results to the VC.

Also, if my proposed omap3_pm_init_vc() approach is taken and it is
optional, some sort of defaults should probably be set.

Kevin


