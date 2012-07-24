From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCHv4 3/8] ARM: OMAP3+: voltage: add support for voltagedomain usecounts
Date: Tue, 24 Jul 2012 15:58:25 -0500
Message-ID: <6cfa1276727a03e26caea893ced86b92@mail.gmail.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com> <1342189185-5306-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:42209 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755637Ab2GXU63 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jul 2012 16:58:29 -0400
Received: by vbkv13 with SMTP id v13so8229vbk.14
        for <linux-omap@vger.kernel.org>; Tue, 24 Jul 2012 13:58:26 -0700 (PDT)
In-Reply-To: <1342189185-5306-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, Kevin Hilman <khilman@ti.com>
Cc: linux-arm-kernel@lists.infradead.org

Tero,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tero Kristo
> Sent: Friday, July 13, 2012 9:20 AM
> To: linux-omap@vger.kernel.org; paul@pwsan.com; khilman@ti.com
> Cc: linux-arm-kernel@lists.infradead.org
> Subject: [PATCHv4 3/8] ARM: OMAP3+: voltage: add support for
> voltagedomain usecounts
>
> These are updated based on powerdomain usecounts. Also added support
> for voltdm->sleep and voltdm->wakeup calls that will be invoked once
> voltagedomain enters sleep or wakes up based on usecount numbers.
> These
> will be used for controlling voltage scaling functionality.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c |    6 +++-
>  arch/arm/mach-omap2/voltage.c     |   56
> +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/voltage.h     |   11 +++++++
>  3 files changed, 72 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-
> omap2/powerdomain.c
> index 68bdf36..3b4b15d 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -994,7 +994,8 @@ void pwrdm_clkdm_enable(struct powerdomain
> *pwrdm)
>  	if (!pwrdm)
>  		return;
>
> -	atomic_inc(&pwrdm->usecount);
> +	if (atomic_inc_return(&pwrdm->usecount) == 1)
> +		voltdm_pwrdm_enable(pwrdm->voltdm.ptr);
>  }
>
>  /**
> @@ -1013,6 +1014,9 @@ void pwrdm_clkdm_disable(struct powerdomain
> *pwrdm)
>
>  	val = atomic_dec_return(&pwrdm->usecount);
>
> +	if (!val)
> +		voltdm_pwrdm_disable(pwrdm->voltdm.ptr);
> +
>  	BUG_ON(val < 0);
>  }
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-
> omap2/voltage.c
> index 4dc60e8..8c6439b 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -38,6 +38,7 @@
>
>  #include "voltage.h"
>  #include "powerdomain.h"
> +#include "smartreflex.h"
>
>  #include "vc.h"
>  #include "vp.h"
> @@ -340,6 +341,61 @@ int voltdm_add_pwrdm(struct voltagedomain
> *voltdm, struct powerdomain *pwrdm)
>  }
>
>  /**
> + * voltdm_pwrdm_enable - increase usecount for a voltagedomain
> + * @voltdm: struct voltagedomain * to increase count for
> + *
> + * Increases usecount for a given voltagedomain. If the usecount
> reaches
> + * 1, the domain is awakened from idle and the function will call
> the
> + * voltagedomain->wakeup callback for this domain.
> + */
> +void voltdm_pwrdm_enable(struct voltagedomain *voltdm)
> +{
> +	if (!voltdm)
> +		return;
> +
> +	if (atomic_inc_return(&voltdm->usecount) == 1) {
> +		if (voltdm->wakeup)
> +			voltdm->wakeup(voltdm);
> +	}
> +}
I think these usecounting functions are prone to race conditions and need
to be protected using spin_lock or something like that (not just the
usecounter). Otherwise right sequence will not be followed when multiple
modules try to idle and enable simultaneously. You can see this issue when
2 cpus enter idle independently.

Regards
Vishwa

> +
> +/**
> + * voltdm_pwrdm_disable - decrease usecount for a voltagedomain
> + * @voltdm: struct voltagedomain * to decrease count for
> + *
> + * Decreases the usecount for a given voltagedomain. If the
> usecount
> + * reaches zero, the domain can idle and the function will call the
> + * voltagedomain->sleep callback, and calculate the overall target
> + * state for the voltagedomain.
> + */
> +void voltdm_pwrdm_disable(struct voltagedomain *voltdm)
> +{
> +	u8 target_state = PWRDM_POWER_OFF;
> +	int state;
> +	struct powerdomain *pwrdm;
> +	int val;
> +
> +	if (!voltdm)
> +		return;
> +
> +	val = atomic_dec_return(&voltdm->usecount);
> +
> +	BUG_ON(val < 0);
> +
> +	if (val == 0) {
> +		/* Determine target state for voltdm */
> +		list_for_each_entry(pwrdm, &voltdm->pwrdm_list,
> voltdm_node) {
> +			state = pwrdm_read_next_pwrst(pwrdm);
> +			if (state > target_state)
> +				target_state = state;
> +		}
> +		voltdm->target_state = target_state;
> +		if (voltdm->sleep)
> +			voltdm->sleep(voltdm);
> +	}
> +}
> +
> +/**
>   * voltdm_for_each_pwrdm - call function for each pwrdm in a voltdm
>   * @voltdm: struct voltagedomain * to iterate over
>   * @fn: callback function *
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-
> omap2/voltage.h
> index 16a1b09..c1f4ae8 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -54,10 +54,14 @@ struct omap_vfsm_instance {
>   * @pwrdm_list: list_head linking all powerdomains in this
> voltagedomain
>   * @vc: pointer to VC channel associated with this voltagedomain
>   * @vp: pointer to VP associated with this voltagedomain
> + * @usecount: number of users for this voltagedomain
> + * @target_state: calculated target state for the children of this
> domain
>   * @read: read a VC/VP register
>   * @write: write a VC/VP register
>   * @read: read-modify-write a VC/VP register
>   * @sys_clk: system clock name/frequency, used for various timing
> calculations
> + * @sleep: function to call once the domain enters idle
> + * @wakeup: function to call once the domain wakes up from idle
>   * @scale: function used to scale the voltage of the voltagedomain
>   * @nominal_volt: current nominal voltage for this voltage domain
>   * @volt_data: voltage table having the distinct voltages supported
> @@ -73,6 +77,9 @@ struct voltagedomain {
>  	struct omap_vp_instance *vp;
>  	struct omap_voltdm_pmic *pmic;
>
> +	atomic_t usecount;
> +	u8 target_state;
> +
>  	/* VC/VP register access functions: SoC specific */
>  	u32 (*read) (u8 offset);
>  	void (*write) (u32 val, u8 offset);
> @@ -83,6 +90,8 @@ struct voltagedomain {
>  		u32 rate;
>  	} sys_clk;
>
> +	void (*sleep) (struct voltagedomain *voltdm);
> +	void (*wakeup) (struct voltagedomain *voltdm);
>  	int (*scale) (struct voltagedomain *voltdm,
>  		      unsigned long target_volt);
>
> @@ -161,6 +170,8 @@ extern void omap44xx_voltagedomains_init(void);
>  struct voltagedomain *voltdm_lookup(const char *name);
>  void voltdm_init(struct voltagedomain **voltdm_list);
>  int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct
> powerdomain *pwrdm);
> +void voltdm_pwrdm_enable(struct voltagedomain *voltdm);
> +void voltdm_pwrdm_disable(struct voltagedomain *voltdm);
>  int voltdm_for_each(int (*fn)(struct voltagedomain *voltdm, void
> *user),
>  		    void *user);
>  int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
