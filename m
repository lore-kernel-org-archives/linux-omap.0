From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 3/3] OMAP4: clockdomain: Add wkup/sleep dependency support
Date: Mon, 14 Feb 2011 17:42:01 +0530
Message-ID: <5cabb72b90513c61bc32035e3888577f@mail.gmail.com>
References: <1297084631-27474-1-git-send-email-rnayak@ti.com>
 <1297084631-27474-2-git-send-email-rnayak@ti.com> <1297084631-27474-3-git-send-email-rnayak@ti.com>
 <1297084631-27474-4-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1102101905160.21991@utopia.booyaka.com>
 <3754d10e94217aa81846aa1d41fe0a9d@mail.gmail.com> <alpine.DEB.2.00.1102102135220.21991@utopia.booyaka.com>
 <74b7dfbe67e19da4358f7df0bc4dd8f1@mail.gmail.com> <alpine.DEB.2.00.1102102209080.21991@utopia.booyaka.com>
 <478620b0abf7ff99cb41192dd4ee9e6d@mail.gmail.com> <alpine.DEB.2.00.1102121529100.21991@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:59853 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753799Ab1BNMMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 07:12:06 -0500
Received: by mail-fx0-f51.google.com with SMTP id 5so5368799fxm.24
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 04:12:03 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102121529100.21991@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Sunday, February 13, 2011 4:27 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; Benoit Cousson;
linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH 3/3] OMAP4: clockdomain: Add wkup/sleep dependency
support
>
> On Fri, 11 Feb 2011, Rajendra Nayak wrote:
>
> > > Does that sound okay to you?
> >
> > Yep, that sounds better.
>
> Here's an updated patch for the main code and the OMAP2/3
implementation.
> Comments, testing welcome.
>
> The stable integration tag with this change is
> 'integration-2.6.39-20110212-001' of
git://git.pwsan.com/linux-integration

Thanks for the changes. I used the 'integration-2.6.39-20110212-002'
tag (with the OMAP4 changes as well) and tested OFF mode in suspend
on my 3430sdp.
Also boot tested (making sure all static deps are cleared at boot)
on my 4430sdp.
There were however, still some prints stating wkup dependencies not yet
being supported on OMAP4, which I removed as part of the patch which I
posted here..
http://marc.info/?l=linux-omap&m=129768517726431&w=2

regards,
Rajendra

>
>
> - Paul
>
>
> From: Rajendra Nayak <rnayak@ti.com>
> Date: Tue, 8 Feb 2011 14:25:34 -0700
> Subject: [PATCH] OMAP: clockdomain: Arch specific funcs to handle deps
>
> Define the following architecture specific funtions for omap2/3
> .clkdm_add_wkdep
> .clkdm_del_wkdep
> .clkdm_read_wkdep
> .clkdm_clear_all_wkdeps
> .clkdm_add_sleepdep
> .clkdm_del_sleepdep
> .clkdm_read_sleepdep
> .clkdm_clear_all_sleepdeps
>
> Convert the platform-independent framework to call these functions.
> With this also move the clkdm lookups for all wkdep_srcs and
> sleepdep_srcs at clkdm_init.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> [paul@pwsan.com: fixed loop termination conditions in
omap*_clkdm_clear_all_*();
>  thanks to Kevin Hilman for finding and helping fix those bugs; also
>  avoid re-resolving clockdomains during init; abstracted out clkdm_dep
walk]
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/Makefile                     |    2 +
>  arch/arm/mach-omap2/clockdomain.c                |  177
++++++++++++----------
>  arch/arm/mach-omap2/clockdomain.h                |    6 +-
>  arch/arm/mach-omap2/clockdomain2xxx_3xxx.c       |  130
++++++++++++++++
>  arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    9 +-
>  arch/arm/mach-omap2/io.c                         |    6 +-
>  6 files changed, 246 insertions(+), 84 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 1c0c2b0..6b2824d 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -102,8 +102,10 @@ obj-$(CONFIG_ARCH_OMAP4)		+=
$(powerdomain-common) \
>
>  # PRCM clockdomain control
>  obj-$(CONFIG_ARCH_OMAP2)		+= clockdomain.o \
> +					   clockdomain2xxx_3xxx.o \
>  					   clockdomains2xxx_3xxx_data.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain.o \
> +					   clockdomain2xxx_3xxx.o \
>  					   clockdomains2xxx_3xxx_data.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain.o \
>  					   clockdomains44xx_data.o
> diff --git a/arch/arm/mach-omap2/clockdomain.c
b/arch/arm/mach-omap2/clockdomain.c
> index f70b06a..895c153 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -287,6 +287,32 @@ static void _disable_hwsup(struct clockdomain
*clkdm)
>  		BUG();
>  }
>
> +/**
> + * _resolve_clkdm_deps() - resolve clkdm_names in @clkdm_deps to clkdms
> + * @clkdm: clockdomain that we are resolving dependencies for
> + * @clkdm_deps: ptr to array of struct clkdm_deps to resolve
> + *
> + * Iterates through @clkdm_deps, looking up the struct clockdomain
named by
> + * clkdm_name and storing the clockdomain pointer in the struct
clkdm_dep.
> + * No return value.
> + */
> +static void _resolve_clkdm_deps(struct clockdomain *clkdm,
> +				struct clkdm_dep *clkdm_deps)
> +{
> +	struct clkdm_dep *cd;
> +
> +	for (cd = clkdm_deps; cd && cd->clkdm_name; cd++) {
> +		if (!omap_chip_is(cd->omap_chip))
> +			continue;
> +		if (cd->clkdm)
> +			continue;
> +		cd->clkdm = _clkdm_lookup(cd->clkdm_name);
> +
> +		WARN(!cd->clkdm, "clockdomain: %s: could not find clkdm %s
while resolving dependencies - should
> never happen",
> +		     clkdm->name, cd->clkdm_name);
> +	}
> +}
> +
>  /* Public functions */
>
>  /**
> @@ -333,7 +359,10 @@ void clkdm_init(struct clockdomain **clkdms,
>  		else if (clkdm->flags & CLKDM_CAN_DISABLE_AUTO)
>  			omap2_clkdm_deny_idle(clkdm);
>
> +		_resolve_clkdm_deps(clkdm, clkdm->wkdep_srcs);
>  		clkdm_clear_all_wkdeps(clkdm);
> +
> +		_resolve_clkdm_deps(clkdm, clkdm->sleepdep_srcs);
>  		clkdm_clear_all_sleepdeps(clkdm);
>  	}
>  }
> @@ -430,6 +459,7 @@ struct powerdomain *clkdm_get_pwrdm(struct
clockdomain *clkdm)
>  int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain
*clkdm2)
>  {
>  	struct clkdm_dep *cd;
> +	int ret = 0;
>
>  	if (!cpu_is_omap24xx() && !cpu_is_omap34xx()) {
>  		pr_err("clockdomain: %s/%s: %s: not yet implemented\n",
> @@ -441,21 +471,26 @@ int clkdm_add_wkdep(struct clockdomain *clkdm1,
struct clockdomain *clkdm2)
>  		return -EINVAL;
>
>  	cd = _clkdm_deps_lookup(clkdm2, clkdm1->wkdep_srcs);
> -	if (IS_ERR(cd)) {
> +	if (IS_ERR(cd))
> +		ret = PTR_ERR(cd);
> +
> +	if (!arch_clkdm || !arch_clkdm->clkdm_add_wkdep)
> +		ret = -EINVAL;
> +
> +	if (ret) {
>  		pr_debug("clockdomain: hardware cannot set/clear wake up
of "
>  			 "%s when %s wakes up\n", clkdm1->name,
clkdm2->name);
> -		return PTR_ERR(cd);
> +		return ret;
>  	}
>
>  	if (atomic_inc_return(&cd->wkdep_usecount) == 1) {
>  		pr_debug("clockdomain: hardware will wake up %s when %s
wakes "
>  			 "up\n", clkdm1->name, clkdm2->name);
>
> -		omap2_prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
> -				     clkdm1->pwrdm.ptr->prcm_offs,
PM_WKDEP);
> +		ret = arch_clkdm->clkdm_add_wkdep(clkdm1, clkdm2);
>  	}
>
> -	return 0;
> +	return ret;
>  }
>
>  /**
> @@ -471,6 +506,7 @@ int clkdm_add_wkdep(struct clockdomain *clkdm1,
struct clockdomain *clkdm2)
>  int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain
*clkdm2)
>  {
>  	struct clkdm_dep *cd;
> +	int ret = 0;
>
>  	if (!cpu_is_omap24xx() && !cpu_is_omap34xx()) {
>  		pr_err("clockdomain: %s/%s: %s: not yet implemented\n",
> @@ -482,21 +518,26 @@ int clkdm_del_wkdep(struct clockdomain *clkdm1,
struct clockdomain *clkdm2)
>  		return -EINVAL;
>
>  	cd = _clkdm_deps_lookup(clkdm2, clkdm1->wkdep_srcs);
> -	if (IS_ERR(cd)) {
> +	if (IS_ERR(cd))
> +		ret = PTR_ERR(cd);
> +
> +	if (!arch_clkdm || !arch_clkdm->clkdm_del_wkdep)
> +		ret = -EINVAL;
> +
> +	if (ret) {
>  		pr_debug("clockdomain: hardware cannot set/clear wake up
of "
>  			 "%s when %s wakes up\n", clkdm1->name,
clkdm2->name);
> -		return PTR_ERR(cd);
> +		return ret;
>  	}
>
>  	if (atomic_dec_return(&cd->wkdep_usecount) == 0) {
>  		pr_debug("clockdomain: hardware will no longer wake up %s
"
>  			 "after %s wakes up\n", clkdm1->name,
clkdm2->name);
>
> -		omap2_prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
> -				       clkdm1->pwrdm.ptr->prcm_offs,
PM_WKDEP);
> +		ret = arch_clkdm->clkdm_del_wkdep(clkdm1, clkdm2);
>  	}
>
> -	return 0;
> +	return ret;
>  }
>
>  /**
> @@ -516,6 +557,7 @@ int clkdm_del_wkdep(struct clockdomain *clkdm1,
struct clockdomain *clkdm2)
>  int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain
*clkdm2)
>  {
>  	struct clkdm_dep *cd;
> +	int ret = 0;
>
>  	if (!clkdm1 || !clkdm2)
>  		return -EINVAL;
> @@ -527,15 +569,20 @@ int clkdm_read_wkdep(struct clockdomain *clkdm1,
struct clockdomain *clkdm2)
>  	}
>
>  	cd = _clkdm_deps_lookup(clkdm2, clkdm1->wkdep_srcs);
> -	if (IS_ERR(cd)) {
> +	if (IS_ERR(cd))
> +		ret = PTR_ERR(cd);
> +
> +	if (!arch_clkdm || !arch_clkdm->clkdm_read_wkdep)
> +		ret = -EINVAL;
> +
> +	if (ret) {
>  		pr_debug("clockdomain: hardware cannot set/clear wake up
of "
>  			 "%s when %s wakes up\n", clkdm1->name,
clkdm2->name);
> -		return PTR_ERR(cd);
> +		return ret;
>  	}
>
>  	/* XXX It's faster to return the atomic wkdep_usecount */
> -	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
PM_WKDEP,
> -				       (1 << clkdm2->dep_bit));
> +	return arch_clkdm->clkdm_read_wkdep(clkdm1, clkdm2);
>  }
>
>  /**
> @@ -550,9 +597,6 @@ int clkdm_read_wkdep(struct clockdomain *clkdm1,
struct clockdomain *clkdm2)
>   */
>  int clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
>  {
> -	struct clkdm_dep *cd;
> -	u32 mask = 0;
> -
>  	if (!cpu_is_omap24xx() && !cpu_is_omap34xx()) {
>  		pr_err("clockdomain: %s: %s: not yet implemented\n",
>  		       clkdm->name, __func__);
> @@ -562,21 +606,10 @@ int clkdm_clear_all_wkdeps(struct clockdomain
*clkdm)
>  	if (!clkdm)
>  		return -EINVAL;
>
> -	for (cd = clkdm->wkdep_srcs; cd && cd->clkdm_name; cd++) {
> -		if (!omap_chip_is(cd->omap_chip))
> -			continue;
> -
> -		if (!cd->clkdm && cd->clkdm_name)
> -			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
> -
> -		/* PRM accesses are slow, so minimize them */
> -		mask |= 1 << cd->clkdm->dep_bit;
> -		atomic_set(&cd->wkdep_usecount, 0);
> -	}
> -
> -	omap2_prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs,
PM_WKDEP);
> +	if (!arch_clkdm || !arch_clkdm->clkdm_clear_all_wkdeps)
> +		return -EINVAL;
>
> -	return 0;
> +	return arch_clkdm->clkdm_clear_all_wkdeps(clkdm);
>  }
>
>  /**
> @@ -594,31 +627,33 @@ int clkdm_clear_all_wkdeps(struct clockdomain
*clkdm)
>  int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain
*clkdm2)
>  {
>  	struct clkdm_dep *cd;
> -
> -	if (!cpu_is_omap34xx())
> -		return -EINVAL;
> +	int ret = 0;
>
>  	if (!clkdm1 || !clkdm2)
>  		return -EINVAL;
>
>  	cd = _clkdm_deps_lookup(clkdm2, clkdm1->sleepdep_srcs);
> -	if (IS_ERR(cd)) {
> +	if (IS_ERR(cd))
> +		ret = PTR_ERR(cd);
> +
> +	if (!arch_clkdm || !arch_clkdm->clkdm_add_sleepdep)
> +		ret = -EINVAL;
> +
> +	if (ret) {
>  		pr_debug("clockdomain: hardware cannot set/clear sleep "
>  			 "dependency affecting %s from %s\n",
clkdm1->name,
>  			 clkdm2->name);
> -		return PTR_ERR(cd);
> +		return ret;
>  	}
>
>  	if (atomic_inc_return(&cd->sleepdep_usecount) == 1) {
>  		pr_debug("clockdomain: will prevent %s from sleeping if %s
"
>  			 "is active\n", clkdm1->name, clkdm2->name);
>
> -		omap2_cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
> -				    clkdm1->pwrdm.ptr->prcm_offs,
> -				    OMAP3430_CM_SLEEPDEP);
> +		ret = arch_clkdm->clkdm_add_sleepdep(clkdm1, clkdm2);
>  	}
>
> -	return 0;
> +	return ret;
>  }
>
>  /**
> @@ -636,19 +671,23 @@ int clkdm_add_sleepdep(struct clockdomain *clkdm1,
struct clockdomain *clkdm2)
>  int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain
*clkdm2)
>  {
>  	struct clkdm_dep *cd;
> -
> -	if (!cpu_is_omap34xx())
> -		return -EINVAL;
> +	int ret = 0;
>
>  	if (!clkdm1 || !clkdm2)
>  		return -EINVAL;
>
>  	cd = _clkdm_deps_lookup(clkdm2, clkdm1->sleepdep_srcs);
> -	if (IS_ERR(cd)) {
> +	if (IS_ERR(cd))
> +		ret = PTR_ERR(cd);
> +
> +	if (!arch_clkdm || !arch_clkdm->clkdm_del_sleepdep)
> +		ret = -EINVAL;
> +
> +	if (ret) {
>  		pr_debug("clockdomain: hardware cannot set/clear sleep "
>  			 "dependency affecting %s from %s\n",
clkdm1->name,
>  			 clkdm2->name);
> -		return PTR_ERR(cd);
> +		return ret;
>  	}
>
>  	if (atomic_dec_return(&cd->sleepdep_usecount) == 0) {
> @@ -656,12 +695,10 @@ int clkdm_del_sleepdep(struct clockdomain *clkdm1,
struct clockdomain *clkdm2)
>  			 "sleeping if %s is active\n", clkdm1->name,
>  			 clkdm2->name);
>
> -		omap2_cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
> -				      clkdm1->pwrdm.ptr->prcm_offs,
> -				      OMAP3430_CM_SLEEPDEP);
> +		ret = arch_clkdm->clkdm_del_sleepdep(clkdm1, clkdm2);
>  	}
>
> -	return 0;
> +	return ret;
>  }
>
>  /**
> @@ -683,25 +720,27 @@ int clkdm_del_sleepdep(struct clockdomain *clkdm1,
struct clockdomain *clkdm2)
>  int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain
*clkdm2)
>  {
>  	struct clkdm_dep *cd;
> -
> -	if (!cpu_is_omap34xx())
> -		return -EINVAL;
> +	int ret = 0;
>
>  	if (!clkdm1 || !clkdm2)
>  		return -EINVAL;
>
>  	cd = _clkdm_deps_lookup(clkdm2, clkdm1->sleepdep_srcs);
> -	if (IS_ERR(cd)) {
> +	if (IS_ERR(cd))
> +		ret = PTR_ERR(cd);
> +
> +	if (!arch_clkdm || !arch_clkdm->clkdm_read_sleepdep)
> +		ret = -EINVAL;
> +
> +	if (ret) {
>  		pr_debug("clockdomain: hardware cannot set/clear sleep "
>  			 "dependency affecting %s from %s\n",
clkdm1->name,
>  			 clkdm2->name);
> -		return PTR_ERR(cd);
> +		return ret;
>  	}
>
>  	/* XXX It's faster to return the atomic sleepdep_usecount */
> -	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
> -				       OMAP3430_CM_SLEEPDEP,
> -				       (1 << clkdm2->dep_bit));
> +	return arch_clkdm->clkdm_read_sleepdep(clkdm1, clkdm2);
>  }
>
>  /**
> @@ -716,31 +755,13 @@ int clkdm_read_sleepdep(struct clockdomain
*clkdm1, struct clockdomain *clkdm2)
>   */
>  int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
>  {
> -	struct clkdm_dep *cd;
> -	u32 mask = 0;
> -
> -	if (!cpu_is_omap34xx())
> -		return -EINVAL;
> -
>  	if (!clkdm)
>  		return -EINVAL;
>
> -	for (cd = clkdm->sleepdep_srcs; cd && cd->clkdm_name; cd++) {
> -		if (!omap_chip_is(cd->omap_chip))
> -			continue;
> -
> -		if (!cd->clkdm && cd->clkdm_name)
> -			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
> -
> -		/* PRM accesses are slow, so minimize them */
> -		mask |= 1 << cd->clkdm->dep_bit;
> -		atomic_set(&cd->sleepdep_usecount, 0);
> -	}
> -
> -	omap2_prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs,
> -			       OMAP3430_CM_SLEEPDEP);
> +	if (!arch_clkdm || !arch_clkdm->clkdm_clear_all_sleepdeps)
> +		return -EINVAL;
>
> -	return 0;
> +	return arch_clkdm->clkdm_clear_all_sleepdeps(clkdm);
>  }
>
>  /**
> diff --git a/arch/arm/mach-omap2/clockdomain.h
b/arch/arm/mach-omap2/clockdomain.h
> index 71ad265..90b6d6a 100644
> --- a/arch/arm/mach-omap2/clockdomain.h
> +++ b/arch/arm/mach-omap2/clockdomain.h
> @@ -176,7 +176,11 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm);
>  int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
>  int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk
*clk);
>
> -extern void __init omap2_clockdomains_init(void);
> +extern void __init omap2xxx_clockdomains_init(void);
> +extern void __init omap3xxx_clockdomains_init(void);
>  extern void __init omap44xx_clockdomains_init(void);
>
> +extern struct clkdm_ops omap2_clkdm_operations;
> +extern struct clkdm_ops omap3_clkdm_operations;
> +
>  #endif
> diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
> new file mode 100644
> index 0000000..a1fd6fd
> --- /dev/null
> +++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
> @@ -0,0 +1,130 @@
> +/*
> + * OMAP2 and OMAP3 clockdomain control
> + *
> + * Copyright (C) 2008-2010 Texas Instruments, Inc.
> + * Copyright (C) 2008-2010 Nokia Corporation
> + *
> + * Derived from mach-omap2/clockdomain.c written by Paul Walmsley
> + * Rajendra Nayak <rnayak@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/types.h>
> +#include <plat/prcm.h>
> +#include "prm.h"
> +#include "prm2xxx_3xxx.h"
> +#include "cm.h"
> +#include "cm2xxx_3xxx.h"
> +#include "cm-regbits-24xx.h"
> +#include "cm-regbits-34xx.h"
> +#include "clockdomain.h"
> +
> +static int omap2_clkdm_add_wkdep(struct clockdomain *clkdm1,
> +						struct clockdomain
*clkdm2)
> +{
> +	omap2_prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
> +				clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
> +	return 0;
> +}
> +
> +static int omap2_clkdm_del_wkdep(struct clockdomain *clkdm1,
> +						 struct clockdomain
*clkdm2)
> +{
> +	omap2_prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
> +				clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
> +	return 0;
> +}
> +
> +static int omap2_clkdm_read_wkdep(struct clockdomain *clkdm1,
> +						 struct clockdomain
*clkdm2)
> +{
> +	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
> +				PM_WKDEP, (1 << clkdm2->dep_bit));
> +}
> +
> +static int omap2_clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
> +{
> +	struct clkdm_dep *cd;
> +	u32 mask = 0;
> +
> +	for (cd = clkdm->wkdep_srcs; cd && cd->clkdm_name; cd++) {
> +		if (!omap_chip_is(cd->omap_chip))
> +			continue;
> +		if (!cd->clkdm)
> +			continue; /* only happens if data is erroneous */
> +
> +		/* PRM accesses are slow, so minimize them */
> +		mask |= 1 << cd->clkdm->dep_bit;
> +		atomic_set(&cd->wkdep_usecount, 0);
> +	}
> +
> +	omap2_prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs,
> +				 PM_WKDEP);
> +	return 0;
> +}
> +
> +static int omap3_clkdm_add_sleepdep(struct clockdomain *clkdm1,
> +						 struct clockdomain
*clkdm2)
> +{
> +	omap2_cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
> +				clkdm1->pwrdm.ptr->prcm_offs,
> +				OMAP3430_CM_SLEEPDEP);
> +	return 0;
> +}
> +
> +static int omap3_clkdm_del_sleepdep(struct clockdomain *clkdm1,
> +						 struct clockdomain
*clkdm2)
> +{
> +	omap2_cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
> +				clkdm1->pwrdm.ptr->prcm_offs,
> +				OMAP3430_CM_SLEEPDEP);
> +	return 0;
> +}
> +
> +static int omap3_clkdm_read_sleepdep(struct clockdomain *clkdm1,
> +						 struct clockdomain
*clkdm2)
> +{
> +	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
> +				OMAP3430_CM_SLEEPDEP, (1 <<
clkdm2->dep_bit));
> +}
> +
> +static int omap3_clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
> +{
> +	struct clkdm_dep *cd;
> +	u32 mask = 0;
> +
> +	for (cd = clkdm->sleepdep_srcs; cd && cd->clkdm_name; cd++) {
> +		if (!omap_chip_is(cd->omap_chip))
> +			continue;
> +		if (!cd->clkdm)
> +			continue; /* only happens if data is erroneous */
> +
> +		/* PRM accesses are slow, so minimize them */
> +		mask |= 1 << cd->clkdm->dep_bit;
> +		atomic_set(&cd->sleepdep_usecount, 0);
> +	}
> +	omap2_prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs,
> +				OMAP3430_CM_SLEEPDEP);
> +	return 0;
> +}
> +
> +struct clkdm_ops omap2_clkdm_operations = {
> +	.clkdm_add_wkdep	= omap2_clkdm_add_wkdep,
> +	.clkdm_del_wkdep	= omap2_clkdm_del_wkdep,
> +	.clkdm_read_wkdep	= omap2_clkdm_read_wkdep,
> +	.clkdm_clear_all_wkdeps	= omap2_clkdm_clear_all_wkdeps,
> +};
> +
> +struct clkdm_ops omap3_clkdm_operations = {
> +	.clkdm_add_wkdep	= omap2_clkdm_add_wkdep,
> +	.clkdm_del_wkdep	= omap2_clkdm_del_wkdep,
> +	.clkdm_read_wkdep	= omap2_clkdm_read_wkdep,
> +	.clkdm_clear_all_wkdeps	= omap2_clkdm_clear_all_wkdeps,
> +	.clkdm_add_sleepdep	= omap3_clkdm_add_sleepdep,
> +	.clkdm_del_sleepdep	= omap3_clkdm_del_sleepdep,
> +	.clkdm_read_sleepdep	= omap3_clkdm_read_sleepdep,
> +	.clkdm_clear_all_sleepdeps	= omap3_clkdm_clear_all_sleepdeps,
> +};
> diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
b/arch/arm/mach-
> omap2/clockdomains2xxx_3xxx_data.c
> index 8cab07a..f85de72 100644
> --- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
> @@ -854,7 +854,12 @@ static struct clockdomain *clockdomains_omap2[]
__initdata = {
>  	NULL,
>  };
>
> -void __init omap2_clockdomains_init(void)
> +void __init omap2xxx_clockdomains_init(void)
>  {
> -	clkdm_init(clockdomains_omap2, clkdm_autodeps, NULL);
> +	clkdm_init(clockdomains_omap2, clkdm_autodeps,
&omap2_clkdm_operations);
> +}
> +
> +void __init omap3xxx_clockdomains_init(void)
> +{
> +	clkdm_init(clockdomains_omap2, clkdm_autodeps,
&omap3_clkdm_operations);
>  }
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index c203204..89cbba2 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -337,15 +337,15 @@ void __init omap2_init_common_infrastructure(void)
>
>  	if (cpu_is_omap242x()) {
>  		omap2xxx_powerdomains_init();
> -		omap2_clockdomains_init();
> +		omap2xxx_clockdomains_init();
>  		omap2420_hwmod_init();
>  	} else if (cpu_is_omap243x()) {
>  		omap2xxx_powerdomains_init();
> -		omap2_clockdomains_init();
> +		omap2xxx_clockdomains_init();
>  		omap2430_hwmod_init();
>  	} else if (cpu_is_omap34xx()) {
>  		omap3xxx_powerdomains_init();
> -		omap2_clockdomains_init();
> +		omap3xxx_clockdomains_init();
>  		omap3xxx_hwmod_init();
>  	} else if (cpu_is_omap44xx()) {
>  		omap44xx_powerdomains_init();
> --
> 1.7.2.3
