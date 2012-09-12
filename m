From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 4/7] ARM: OMAP2+: PM: use power domain functional state in
 stats counters
Date: Wed, 12 Sep 2012 16:35:10 -0700
Message-ID: <87ligestld.fsf@deeprootsystems.com>
References: <1347443732-7411-1-git-send-email-j-pihet@ti.com>
 <1347443732-7411-5-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1347443732-7411-5-git-send-email-j-pihet@ti.com> (Jean Pihet's
 message of "Wed, 12 Sep 2012 11:55:29 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Nishanth Menon <nm@ti.com>, paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> The PM code uses some counters to keep track of the power domains
> transitions, in order to provide the information to drivers (in
> pwrdm_get_context_loss_count) and to expose the information to
> sysfs for debug purpose.

nit: this is part of debugfs, not sysfs

Otherwise, patch is fine.

> This patch provides the information for each functional state.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Kevin

> ---
>  arch/arm/mach-omap2/pm-debug.c    |   15 ++++++++-------
>  arch/arm/mach-omap2/powerdomain.c |   12 ++++++------
>  arch/arm/mach-omap2/powerdomain.h |    4 ++--
>  3 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 814bcd9..8eaa3f2 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -53,9 +53,10 @@ enum {
>  	DEBUG_FILE_TIMERS,
>  };
>  
> -static const char pwrdm_state_names[][PWRDM_MAX_PWRSTS] = {
> +static const char pwrdm_state_names[][PWRDM_MAX_FUNC_PWRSTS] = {
>  	"OFF",
> -	"RET",
> +	"OSWR",
> +	"CSWR",
>  	"INA",
>  	"ON"
>  };
> @@ -102,13 +103,13 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
>  		strncmp(pwrdm->name, "dpll", 4) == 0)
>  		return 0;
>  
> -	if (pwrdm->state != pwrdm_read_pwrst(pwrdm))
> +	if (pwrdm->state != pwrdm_read_fpwrst(pwrdm))
>  		printk(KERN_ERR "pwrdm state mismatch(%s) %d != %d\n",
> -			pwrdm->name, pwrdm->state, pwrdm_read_pwrst(pwrdm));
> +		       pwrdm->name, pwrdm->state, pwrdm_read_fpwrst(pwrdm));
>  
>  	seq_printf(s, "%s (%s)", pwrdm->name,
>  			pwrdm_state_names[pwrdm->state]);
> -	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
> +	for (i = 0; i < PWRDM_MAX_FUNC_PWRSTS; i++)
>  		seq_printf(s, ",%s:%d", pwrdm_state_names[i],
>  			pwrdm->state_counter[i]);
>  
> @@ -137,7 +138,7 @@ static int pwrdm_dbg_show_timer(struct powerdomain *pwrdm, void *user)
>  	seq_printf(s, "%s (%s)", pwrdm->name,
>  		pwrdm_state_names[pwrdm->state]);
>  
> -	for (i = 0; i < 4; i++)
> +	for (i = 0; i < PWRDM_MAX_FUNC_PWRSTS; i++)
>  		seq_printf(s, ",%s:%lld", pwrdm_state_names[i],
>  			pwrdm->state_timer[i]);
>  
> @@ -211,7 +212,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *dir)
>  
>  	t = sched_clock();
>  
> -	for (i = 0; i < 4; i++)
> +	for (i = 0; i < PWRDM_MAX_FUNC_PWRSTS; i++)
>  		pwrdm->state_timer[i] = 0;
>  
>  	pwrdm->timer = t;
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 82ae9e9..267241f 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -106,7 +106,7 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
>  	list_add(&pwrdm->node, &pwrdm_list);
>  
>  	/* Initialize the powerdomain's state counter */
> -	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
> +	for (i = 0; i < PWRDM_MAX_FUNC_PWRSTS; i++)
>  		pwrdm->state_counter[i] = 0;
>  
>  	pwrdm->ret_logic_off_counter = 0;
> @@ -114,7 +114,7 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
>  		pwrdm->ret_mem_off_counter[i] = 0;
>  
>  	pwrdm_wait_transition(pwrdm);
> -	pwrdm->state = pwrdm_read_pwrst(pwrdm);
> +	pwrdm->state = pwrdm_read_fpwrst(pwrdm);
>  	pwrdm->state_counter[pwrdm->state] = 1;
>  
>  	pr_debug("powerdomain: registered %s\n", pwrdm->name);
> @@ -149,17 +149,17 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>  	if (pwrdm == NULL)
>  		return -EINVAL;
>  
> -	state = pwrdm_read_pwrst(pwrdm);
> +	state = pwrdm_read_fpwrst(pwrdm);
>  
>  	switch (flag) {
>  	case PWRDM_STATE_NOW:
>  		prev = pwrdm->state;
>  		break;
>  	case PWRDM_STATE_PREV:
> -		prev = pwrdm_read_prev_pwrst(pwrdm);
> +		prev = pwrdm_read_prev_fpwrst(pwrdm);
>  		if (pwrdm->state != prev)
>  			pwrdm->state_counter[prev]++;
> -		if (prev == PWRDM_POWER_RET)
> +		if (prev == PWRDM_FUNC_PWRST_OSWR)
>  			_update_logic_membank_counters(pwrdm);
>  		/*
>  		 * If the power domain did not hit the desired state,
> @@ -1414,7 +1414,7 @@ int pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
>  		return -ENODEV;
>  	}
>  
> -	count = pwrdm->state_counter[PWRDM_POWER_OFF];
> +	count = pwrdm->state_counter[PWRDM_FUNC_PWRST_OFF];
>  	count += pwrdm->ret_logic_off_counter;
>  
>  	for (i = 0; i < pwrdm->banks; i++)
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
> index c3dc363..a29caec 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -146,7 +146,7 @@ struct powerdomain {
>  	struct list_head voltdm_node;
>  	spinlock_t lock;
>  	int state;
> -	unsigned state_counter[PWRDM_MAX_PWRSTS];
> +	unsigned state_counter[PWRDM_MAX_FUNC_PWRSTS];
>  	unsigned ret_logic_off_counter;
>  	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
>  
> @@ -160,7 +160,7 @@ struct powerdomain {
>  
>  #ifdef CONFIG_PM_DEBUG
>  	s64 timer;
> -	s64 state_timer[PWRDM_MAX_PWRSTS];
> +	s64 state_timer[PWRDM_MAX_FUNC_PWRSTS];
>  #endif
>  };
