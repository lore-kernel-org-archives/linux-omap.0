From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH 02/12] ARM: OMAP2+: PM: introduce power domains functional
 states
Date: Wed, 12 Dec 2012 15:51:59 +0530
Message-ID: <50C85AC7.8080409@ti.com>
References: <20121209174545.6933.59371.stgit@dusk.lan> <20121209175253.6933.87846.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37425 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753560Ab2LLKWH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Dec 2012 05:22:07 -0500
In-Reply-To: <20121209175253.6933.87846.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Jean Pihet <j-pihet@ti.com>



On 12/9/2012 11:23 PM, Paul Walmsley wrote:
> From: Jean Pihet <jean.pihet@newoldbits.com>
> 
> Introduce the functional states for power domains, which include
> the power states and the logic states.
> This patch provides the API functions to set and read the power
> domains functional state and internal functions to convert between
> the functional (i.e. logical) and the internal (or registers) values.
> 
> In the new API only the functions pwrdm_set_next_fpwrst() and
> pwrdm_set_fpwrst() shall be used to change a power domain target
> state, along with the associated PWRDM_FUNC_* macros as the state
> parameters.
> 
> Note about the power domains allowed states:
> Power domains have varied capabilities, as defined by the value of
> the pwrsts and pwrsts_logic_ret fields of the powerdomain struct.
> When reading or setting a low power state such as OFF/RET, a specific
> requested state may not be supported on the given power domain.
> In the states conversion functions a power or logic state is first
> looked for in the lower power states in order to maximize the power
> savings, then if not found in the higher power states. An iteration
> function is used, as suggested by Rajendra Nayak <rnayak@ti.com>
> This function is temporary and will be removed later in the series.
> 
> This functionality brings consistency in the functional power states
> core code and acts as a guard against hardware implementations
> discrepancies, e.g. some power domains only support the RET logic
> state although reading the logic state registers (previous, current
> and next) always returns OFF. The DSS power domain on OMAP3 is an
> example.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> [paul@pwsan.com: add offset for functional powerstates so it's not
>  possible to confuse them with the old API; use one fn to convert func
>  pwrsts to low-level hardware bits; skip hardware reads when hardware
>  logic retst and logic pwrst bits are missing; fix kerneldoc and
>  commit message; remove unnecessary PWRDM_LOGIC_MEM_PWRST_* macros;
>  combine spinlock patch into this patch; expand the number of operations
>  which take the spinlock]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c |  525 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomain.h |   33 ++
>  2 files changed, 553 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 94b89a25..18f33de 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -1,7 +1,7 @@
>  /*
>   * OMAP powerdomain control
>   *
> - * Copyright (C) 2007-2008, 2011 Texas Instruments, Inc.
> + * Copyright (C) 2007-2008, 2011-2012 Texas Instruments, Inc.
>   * Copyright (C) 2007-2011 Nokia Corporation
>   *
>   * Written by Paul Walmsley
> @@ -44,12 +44,19 @@ enum {
>  	PWRDM_STATE_PREV,
>  };
>  
> -
>  /* pwrdm_list contains all registered struct powerdomains */
>  static LIST_HEAD(pwrdm_list);
>  
>  static struct pwrdm_ops *arch_pwrdm;
>  
> +/*
> + * _fpwrst_names: human-readable functional powerstate names - should match
> + *    the enum pwrdm_func_state order and names
> + */
> +static const char * const _fpwrst_names[] = {
> +	"OFF", "OSWR", "CSWR", "INACTIVE", "ON"
> +};
> +
>  /* Private functions */
>  
>  static struct powerdomain *_pwrdm_lookup(const char *name)
> @@ -145,7 +152,6 @@ static void _update_logic_membank_counters(struct powerdomain *pwrdm)
>  
>  static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>  {
> -
>  	int prev, next, state, trace_state = 0;
>  
>  	if (pwrdm == NULL)
> @@ -259,6 +265,309 @@ static bool _pwrdm_logic_retst_can_change(struct powerdomain *pwrdm)
>  	return _pwrdm_logic_retst_is_controllable(pwrdm);
>  }
>  
> +/**
> + * _match_pwrst: determine the closest supported power state
> + * @pwrsts: list of allowed states, defined as a bitmask
> + * @pwrst: initial state to be used as a starting point
> + * @min: minimum (i.e. lowest consumption) allowed state
> + * @max: maximum (i.e. highest consumption) allowed state
> + *
> + * Search down then up for a valid state from a list of allowed
> + * states.  Used by states conversion functions (_pwrdm_fpwrst_to_*)
> + * to look for allowed power and logic states for a powerdomain.
> + * Returns the matching allowed state.  XXX Deprecated.  The software
> + * should not try to program unsupported powerstates.
> + */
> +static int _match_pwrst(u32 pwrsts, int pwrst, int min, int max)
> +{
> +	int found = 1, new_pwrst = pwrst;
> +
> +	/*
> +	 * If the power domain does not allow any state programmation
> +	 * return the max state which is always allowed
> +	 */
> +	if (!pwrsts)
> +		return max;
> +
> +	/*
> +	 * Search lower: if the requested state is not supported
> +	 * try the lower states, stopping at the minimum allowed
> +	 * state
> +	 */
> +	while (!(pwrsts & (1 << new_pwrst))) {
> +		if (new_pwrst <= min) {
> +			found = 0;
> +			break;
> +		}
> +		new_pwrst--;
> +	}
> +
> +	/*
> +	 * Search higher: if no lower state found fallback to the higher
> +	 * states, stopping at the maximum allowed state
> +	 */
> +	if (!found) {
> +		new_pwrst = pwrst;
> +		while (!(pwrsts & (1 << new_pwrst))) {
> +			if (new_pwrst >= max) {
> +				new_pwrst = max;
> +				break;
> +			}
> +			new_pwrst++;
> +		}
> +	}
> +
> +	return new_pwrst;
> +}
> +
> +/**
> + * _pwrdm_fpwrst_to_pwrst - Convert functional (i.e. logical) to
> + * internal (i.e. registers) values for the power domains states.
> + * @pwrdm: struct powerdomain * to convert the values for
> + * @fpwrst: functional power state
> + * @pwrdm_pwrst: ptr to u8 to return the power state in
> + * @logic_retst: ptr to u8 to return the logic retention state in
> + *

I believe this is internal state, right? it would be good to specify
that as well here.

> + * Returns the internal power state value for the power domain,

This seems to be wrong, as this funtion always returns err or 0.

> or
> + * -EINVAL in case of invalid parameters passed in.
> + */
> +static int _pwrdm_fpwrst_to_pwrst(struct powerdomain *pwrdm, u8 fpwrst,
> +				  u8 *pwrdm_pwrst, u8 *logic_retst)
> +{
> +	if (!pwrdm || !pwrdm_pwrst || !logic_retst)
> +		return -EINVAL;
> +
> +	switch (fpwrst) {
> +	case PWRDM_FUNC_PWRST_ON:
> +		*pwrdm_pwrst = PWRDM_POWER_ON;
> +		*logic_retst = PWRDM_POWER_RET;
> +		break;
> +	case PWRDM_FUNC_PWRST_INACTIVE:
> +		*pwrdm_pwrst = PWRDM_POWER_INACTIVE;
> +		*logic_retst = PWRDM_POWER_RET;
> +		break;
> +	case PWRDM_FUNC_PWRST_CSWR:
> +		*pwrdm_pwrst = PWRDM_POWER_RET;
> +		*logic_retst = PWRDM_POWER_RET;
> +		break;
> +	case PWRDM_FUNC_PWRST_OSWR:
> +		*pwrdm_pwrst = PWRDM_POWER_RET;
> +		*logic_retst = PWRDM_POWER_OFF;
> +		break;
> +	case PWRDM_FUNC_PWRST_OFF:
> +		*pwrdm_pwrst = PWRDM_POWER_OFF;
> +		/*
> +		 * logic_retst is set to PWRDM_POWER_RET in this case
> +		 * since the actual value does not matter, and because
> +		 * some powerdomains don't support a logic_retst of
> +		 * OFF.  XXX Maybe there's some way to indicate a
> +		 * 'don't care' value here?
> +		 */
> +		*logic_retst = PWRDM_POWER_RET;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* XXX deprecated */
> +	*pwrdm_pwrst = _match_pwrst(pwrdm->pwrsts, *pwrdm_pwrst,
> +				    PWRDM_POWER_OFF, PWRDM_POWER_ON);
> +
> +	*logic_retst = _match_pwrst(pwrdm->pwrsts_logic_ret, *logic_retst,
> +				    PWRDM_POWER_OFF, PWRDM_POWER_RET);
> +
> +	pr_debug("powerdomain %s: convert fpwrst %0x to pwrst %0x\n",
> +		 pwrdm->name, fpwrst, *pwrdm_pwrst);
> +
> +	return 0;
> +}
> +
> +/**
> + * _pwrdm_pwrst_to_fpwrst - Convert internal (i.e. registers) to
> + * functional (i.e. logical) values for the power domains states.
> + * @pwrdm: struct powerdomain * to convert the values for
> + * @pwrst: internal powerdomain power state
> + * @logic: internal powerdomain logic power state
> + * @fpwrst: pointer to a u8 to store the corresponding functional power state to
> + *
> + * Returns the functional power state value for the power domain, or
> + * -EINVAL in case of invalid parameters passed in. 

Ditto here.

> @pwrdm, @logic, and @pwrst
> + * are passed in, along with a pointer to the location to store the fpwrst to
> + * in @fpwrst.
> + */
> +static int _pwrdm_pwrst_to_fpwrst(struct powerdomain *pwrdm, u8 pwrst, u8 logic,
> +				  u8 *fpwrst)
> +{
> +	if (!pwrdm || !fpwrst)
> +		return -EINVAL;
> +
> +	switch (pwrst) {
> +	case PWRDM_POWER_ON:
> +		*fpwrst = PWRDM_FUNC_PWRST_ON;
> +		break;
> +	case PWRDM_POWER_INACTIVE:
> +		*fpwrst = PWRDM_FUNC_PWRST_INACTIVE;
> +		break;
> +	case PWRDM_POWER_RET:
> +		if (logic == PWRDM_POWER_OFF)
> +			*fpwrst = PWRDM_FUNC_PWRST_OSWR;
> +		else if (logic == PWRDM_POWER_RET)
> +			*fpwrst = PWRDM_FUNC_PWRST_CSWR;
> +		else
> +			return -EINVAL;
> +		break;
> +	case PWRDM_POWER_OFF:
> +		*fpwrst = PWRDM_FUNC_PWRST_OFF;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	pr_debug("powerdomain: convert pwrst (%0x,%0x) to fpwrst %0x\n",
> +		 pwrst, logic, *fpwrst);
> +
> +	return 0;
> +}
> +
> +/**
> + * _set_logic_retst_and_pwrdm_pwrst - program logic retst and pwrdm next pwrst
> + * @pwrdm: struct powerdomain * to program
> + * @logic: logic retention state to attempt to program
> + * @pwrst: powerdomain next-power-state to program
> + *
> + * Program the next-power-state and logic retention power state of the
> + * powerdomain represented by @pwrdm to @pwrst and @logic,
> + * respectively.  If the powerdomain next-power-state is not
> + * software-controllable, returns 0; otherwise, passes along the
> + * return value from pwrdm_set_logic_retst() if there is an error
> + * returned by that function, otherwise, passes along the return value
> + * from pwrdm_set_next_pwrst()
> + */
> +static int _set_logic_retst_and_pwrdm_pwrst(struct powerdomain *pwrdm,
> +					    u8 logic, u8 pwrst)
> +{
> +	int ret;
> +
> +	if (!_pwrdm_pwrst_is_controllable(pwrdm))
> +		return 0;
> +
> +	if (pwrdm->pwrsts_logic_ret && pwrst == PWRDM_POWER_RET) {
> +		ret = pwrdm_set_logic_retst(pwrdm, logic);
> +		if (ret) {
> +			pr_err("%s: unable to set logic state %0x of powerdomain: %s\n",
> +			       __func__, logic, pwrdm->name);
> +			return ret;
> +		}
> +	}
> +
> +	ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
> +	if (ret)
> +		pr_err("%s: unable to set power state %0x of powerdomain: %s\n",
> +		       __func__, pwrst, pwrdm->name);
> +
> +	return ret;
> +}
> +
> +/**
> + * _pwrdm_read_next_fpwrst - get next powerdomain func power state (lockless)
> + * @pwrdm: struct powerdomain * to get power state
> + *
> + * Return the powerdomain @pwrdm's next functional power state.
> + * Caller must hold @pwrdm->_lock.  Returns -EINVAL if the powerdomain
> + * pointer is null or returns the next power state upon success.
> + */
> +static int _pwrdm_read_next_fpwrst(struct powerdomain *pwrdm)
> +{
> +	int next_pwrst, next_logic, ret;
> +	u8 fpwrst;
> +
> +	if (!arch_pwrdm || !arch_pwrdm->pwrdm_read_next_pwrst)
> +		return -EINVAL;
> +
> +	next_pwrst = arch_pwrdm->pwrdm_read_next_pwrst(pwrdm);
> +	if (next_pwrst < 0)
> +		return next_pwrst;
> +
> +	next_logic = next_pwrst;
> +	if (_pwrdm_logic_retst_can_change(pwrdm) &&
> +	    arch_pwrdm->pwrdm_read_logic_pwrst) {
> +		next_logic = arch_pwrdm->pwrdm_read_logic_pwrst(pwrdm);
> +		if (next_logic < 0)
> +			return next_logic;
> +	}
> +
> +	ret = _pwrdm_pwrst_to_fpwrst(pwrdm, next_pwrst, next_logic, &fpwrst);
> +
> +	return (ret) ? ret : fpwrst;
> +}
> +
> +/**
> + * _pwrdm_read_fpwrst - get current func powerdomain power state (lockless)
> + * @pwrdm: struct powerdomain * to get current functional power state
> + *
> + * Return the powerdomain @pwrdm's current functional power state.
> + * Returns -EINVAL if the powerdomain pointer is null or returns the
> + * current power state upon success.
> + */
> +static int _pwrdm_read_fpwrst(struct powerdomain *pwrdm)
> +{
> +	int pwrst, logic_pwrst, ret;
> +	u8 fpwrst;
> +
> +	if (!_pwrdm_pwrst_can_change(pwrdm))
> +		return PWRDM_FUNC_PWRST_ON;
> +
> +	pwrst = arch_pwrdm->pwrdm_read_pwrst(pwrdm);
> +	if (pwrst < 0)
> +		return pwrst;
> +
> +	logic_pwrst = pwrst;
> +	if (_pwrdm_logic_retst_can_change(pwrdm) &&
> +	    arch_pwrdm->pwrdm_read_logic_pwrst) {
> +		logic_pwrst = arch_pwrdm->pwrdm_read_logic_pwrst(pwrdm);
> +		if (logic_pwrst < 0)
> +			return logic_pwrst;
> +	}
> +
> +	ret = _pwrdm_pwrst_to_fpwrst(pwrdm, pwrst, logic_pwrst, &fpwrst);
> +
> +	return (ret) ? ret : fpwrst;
> +}
> +
> +/**
> + * _pwrdm_read_prev_fpwrst - get previous powerdomain func pwr state (lockless)
> + * @pwrdm: struct powerdomain * to get previous functional power state
> + *
> + * Return the powerdomain @pwrdm's previous functional power state.
> + * Returns -EINVAL if the powerdomain pointer is null or returns the
> + * previous functional power state upon success.
> + */
> +static int _pwrdm_read_prev_fpwrst(struct powerdomain *pwrdm)
> +{
> +	int ret = -EINVAL;
> +	int pwrst, logic_pwrst;
> +	u8 fpwrst;
> +
> +	if (!_pwrdm_pwrst_can_change(pwrdm))
> +		return PWRDM_FUNC_PWRST_ON;
> +
> +	pwrst = arch_pwrdm->pwrdm_read_prev_pwrst(pwrdm);
> +	if (pwrst < 0)
> +		return pwrst;
> +
> +	logic_pwrst = pwrst;
> +	if (_pwrdm_logic_retst_can_change(pwrdm) &&
> +	    arch_pwrdm->pwrdm_read_prev_logic_pwrst) {
> +		logic_pwrst = arch_pwrdm->pwrdm_read_prev_logic_pwrst(pwrdm);
> +		if (logic_pwrst < 0)
> +			return logic_pwrst;
> +	}
> +
> +	ret = _pwrdm_pwrst_to_fpwrst(pwrdm, pwrst, logic_pwrst, &fpwrst);
> +
> +	return (ret) ? ret : fpwrst;
> +}
> +
>  /* Public functions */
>  
>  /**
> @@ -620,7 +929,7 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
>  	if (!pwrdm)
>  		return -EINVAL;
>  
> -	if (pwrdm->pwrsts == PWRSTS_ON)
> +	if (!_pwrdm_pwrst_can_change(pwrdm))
>  		return PWRDM_POWER_ON;
>  
>  	if (arch_pwrdm && arch_pwrdm->pwrdm_read_pwrst)
> @@ -1213,3 +1522,211 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm)
>  
>  	return 0;
>  }
> +
> +/* Public functions for functional power state handling */
> +
> +/**
> + * pwrdm_convert_fpwrst_to_name - return the name of a functional power state
> + * @fpwrst: functional power state to return the name of
> + *
> + * Return a pointer to a string with the human-readable name of the
> + * functional power state (e.g., "ON", "CSWR", etc.)  Intended for use
> + * in debugging.  Returns NULL if @fpwrst is outside the range of the
> + * known functional power states.
> + */
> +const char *pwrdm_convert_fpwrst_to_name(u8 fpwrst)
> +{
> +	if (fpwrst < PWRDM_FPWRST_OFFSET || fpwrst >= PWRDM_MAX_FUNC_PWRSTS)
> +		return NULL;
> +
> +	return _fpwrst_names[fpwrst - PWRDM_FPWRST_OFFSET];
> +}
> +
> +/**
> + * pwrdm_set_next_fpwrst - set next powerdomain functional power state
> + * @pwrdm: struct powerdomain * to set
> + * @fpwrst: one of the PWRDM_POWER_* macros
> + *
> + * Set the powerdomain @pwrdm's next power state to @fpwrst.  The
> + * powerdomain may not enter this state immediately if the
> + * preconditions for this state have not been satisfied.  Returns
> + * -EINVAL if the powerdomain pointer is null or if the power state is
> + * invalid for the powerdomin, or returns 0 upon success.
> + */
> +int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm, u8 fpwrst)
> +{
> +	u8 pwrst, logic;
> +	int ret;
> +
> +	if (!pwrdm || IS_ERR(pwrdm))

You can use IS_ERR_OR_NULL here.

> +		return -EINVAL;
> +
> +	if (!_pwrdm_pwrst_is_controllable(pwrdm))
> +		return 0;
> +
> +	ret = _pwrdm_fpwrst_to_pwrst(pwrdm, fpwrst, &pwrst, &logic);
> +	if (ret)
> +		return ret;
> +
> +	pr_debug("%s: set fpwrst %0x to pwrdm %s\n", __func__, fpwrst,
> +		 pwrdm->name);
> +
> +	pwrdm_lock(pwrdm);
> +	ret = _set_logic_retst_and_pwrdm_pwrst(pwrdm, logic, pwrst);
> +	pwrdm_unlock(pwrdm);
> +
> +	return ret;
> +}
> +
> +/**
> + * pwrdm_read_next_fpwrst - get next powerdomain functional power state
> + * @pwrdm: struct powerdomain * to get power state
> + *
> + * Return the powerdomain @pwrdm's next functional power state.
> + * Returns -EINVAL if the powerdomain pointer is null or returns
> + * the next power state upon success.
> + */
> +int pwrdm_read_next_fpwrst(struct powerdomain *pwrdm)
> +{
> +	int next_pwrst, next_logic, ret;
> +	u8 fpwrst;
> +
> +	if (!arch_pwrdm || !arch_pwrdm->pwrdm_read_next_pwrst)
> +		return -EINVAL;
> +
> +	pwrdm_lock(pwrdm);
> +
> +	next_pwrst = arch_pwrdm->pwrdm_read_next_pwrst(pwrdm);
> +	if (next_pwrst < 0) {
> +		ret = next_pwrst;
> +		goto prnf_out;
> +	}
> +
> +	next_logic = next_pwrst;
> +	if (_pwrdm_logic_retst_can_change(pwrdm) &&
> +	    arch_pwrdm->pwrdm_read_logic_pwrst) {
> +		next_logic = arch_pwrdm->pwrdm_read_logic_pwrst(pwrdm);
> +		if (next_logic < 0) {
> +			ret = next_logic;
> +			goto prnf_out;
> +		}
> +	}
> +
> +	ret = _pwrdm_pwrst_to_fpwrst(pwrdm, next_pwrst, next_logic, &fpwrst);
> +
> +prnf_out:
> +	pwrdm_unlock(pwrdm);
> +
> +	return (ret) ? ret : fpwrst;
> +}
> +
> +/**
> + * pwrdm_set_fpwrst - program next powerdomain functional power state
> + * @pwrdm: struct powerdomain * to set
> + * @fpwrst: power domain functional state, one of the PWRDM_FUNC_* macros
> + *
> + * This programs the pwrdm next functional state, sets the dependencies
> + * and waits for the state to be applied.
> + */
> +int pwrdm_set_fpwrst(struct powerdomain *pwrdm, enum pwrdm_func_state fpwrst)
> +{
> +	u8 next_fpwrst, pwrst, logic, sleep_switch;
> +	int ret = 0;
> +	bool hwsup;
> +
> +	if (!pwrdm || IS_ERR(pwrdm) || !arch_pwrdm ||
> +	    !arch_pwrdm->pwrdm_read_pwrst)
> +		return -EINVAL;
> +
> +	if (!_pwrdm_pwrst_is_controllable(pwrdm))
> +		return 0;
> +
> +	ret = _pwrdm_fpwrst_to_pwrst(pwrdm, fpwrst, &pwrst, &logic);
> +	if (ret)
> +		return -EINVAL;
> +
> +	pr_debug("%s: pwrdm %s: set fpwrst %0x\n", __func__, pwrdm->name,
> +		 fpwrst);
> +
> +	pwrdm_lock(pwrdm);
> +
> +	/*
> +	 * XXX quite heavyweight for what this is intended to do; the
> +	 * next fpwrst should simply be cached
> +	 */
> +	next_fpwrst = _pwrdm_read_next_fpwrst(pwrdm);
> +	if (next_fpwrst == fpwrst)
> +		goto psf_out;
> +
> +	sleep_switch = _pwrdm_save_clkdm_state_and_activate(pwrdm, pwrst,
> +							    &hwsup);
> +
> +	ret = _set_logic_retst_and_pwrdm_pwrst(pwrdm, logic, pwrst);
> +	if (ret)
> +		pr_err("%s: unable to set power state of powerdomain: %s\n",
> +		       __func__, pwrdm->name);
> +
> +	_pwrdm_restore_clkdm_state(pwrdm, sleep_switch, hwsup);
> +
> +psf_out:
> +	pwrdm_unlock(pwrdm);
> +
> +	return ret;
> +}
> +
> +/**
> + * pwrdm_read_fpwrst - get current functional powerdomain power state
> + * @pwrdm: struct powerdomain * to get current functional power state
> + *
> + * Return the powerdomain @pwrdm's current functional power state.
> + * Returns -EINVAL if the powerdomain pointer is null or returns the
> + * current power state upon success.
> + */
> +int pwrdm_read_fpwrst(struct powerdomain *pwrdm)
> +{
> +	int ret;
> +
> +	if (!pwrdm || !arch_pwrdm)
> +		return -EINVAL;
> +
> +	if (!_pwrdm_pwrst_can_change(pwrdm))
> +		return PWRDM_FUNC_PWRST_ON;
> +
> +	if (!arch_pwrdm->pwrdm_read_pwrst)
> +		return -EINVAL;
> +
> +	pwrdm_lock(pwrdm);
> +	ret = _pwrdm_read_fpwrst(pwrdm);
> +	pwrdm_unlock(pwrdm);
> +
> +	return ret;
> +}
> +
> +/**
> + * pwrdm_read_prev_fpwrst - get previous powerdomain functional power state
> + * @pwrdm: struct powerdomain * to get previous functional power state
> + *
> + * Return the powerdomain @pwrdm's previous functional power state.
> + * Returns -EINVAL if the powerdomain pointer is null or returns the
> + * previous functional power state upon success.
> + */
> +int pwrdm_read_prev_fpwrst(struct powerdomain *pwrdm)
> +{
> +	int ret = -EINVAL;
> +

No need to initialize it here.

Thanks,
Vaibhav

> +	if (!pwrdm || !arch_pwrdm)
> +		return -EINVAL;
> +
> +	if (!_pwrdm_pwrst_can_change(pwrdm))
> +		return PWRDM_FUNC_PWRST_ON;
> +
> +	if (!arch_pwrdm->pwrdm_read_prev_pwrst)
> +		return -EINVAL;
> +
> +	pwrdm_lock(pwrdm);
> +	ret = _pwrdm_read_prev_fpwrst(pwrdm);
> +	pwrdm_unlock(pwrdm);
> +
> +	return ret;
> +}
> +
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
> index 842ba46..be835ff 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -1,7 +1,7 @@
>  /*
>   * OMAP2/3/4 powerdomain control
>   *
> - * Copyright (C) 2007-2008, 2010 Texas Instruments, Inc.
> + * Copyright (C) 2007-2008, 2010-2012 Texas Instruments, Inc.
>   * Copyright (C) 2007-2011 Nokia Corporation
>   *
>   * Paul Walmsley
> @@ -23,6 +23,29 @@
>  
>  #include "voltage.h"
>  
> +/*
> + * PWRDM_FPWRST_OFFSET: offset of the first functional power state
> + * from 0.  This offset can be subtracted from the functional power
> + * state macros to produce offsets suitable for array indices, for
> + * example.  The intention behind the addition of this offset is to
> + * prevent functional power states from accidentally being confused
> + * with the low-level, hardware power states.
> + */
> +#define PWRDM_FPWRST_OFFSET		0x80
> +
> +/*
> + * Powerdomain functional power states, used by the external API functions
> + * These must match the order and names in _fpwrst_names[]
> + */
> +enum pwrdm_func_state {
> +	PWRDM_FUNC_PWRST_OFF		= PWRDM_FPWRST_OFFSET,
> +	PWRDM_FUNC_PWRST_OSWR,
> +	PWRDM_FUNC_PWRST_CSWR,
> +	PWRDM_FUNC_PWRST_INACTIVE,
> +	PWRDM_FUNC_PWRST_ON,
> +	PWRDM_MAX_FUNC_PWRSTS		/* Last value, used as the max value */
> +};
> +
>  /* Powerdomain basic power states */
>  #define PWRDM_POWER_OFF		0x0
>  #define PWRDM_POWER_RET		0x1
> @@ -238,6 +261,14 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
>  
>  extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 state);
>  
> +extern const char *pwrdm_convert_fpwrst_to_name(u8 fpwrst);
> +extern int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm, u8 fpwrst);
> +extern int pwrdm_read_next_fpwrst(struct powerdomain *pwrdm);
> +extern int pwrdm_set_fpwrst(struct powerdomain *pwrdm,
> +			    enum pwrdm_func_state fpwrst);
> +extern int pwrdm_read_fpwrst(struct powerdomain *pwrdm);
> +extern int pwrdm_read_prev_fpwrst(struct powerdomain *pwrdm);
> +
>  extern void omap242x_powerdomains_init(void);
>  extern void omap243x_powerdomains_init(void);
>  extern void omap3xxx_powerdomains_init(void);
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
