From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH arm 1/1] arm: Use _rcuidle tracepoint to allow use from
 idle
Date: Tue, 26 Apr 2016 12:41:19 -0700
Message-ID: <20160426194119.GQ5995@atomide.com>
References: <1461617335-22372-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20160426150031.GP5995@atomide.com>
 <20160426175214.GJ3715@linux.vnet.ibm.com>
 <20160426182939.GO5995@atomide.com>
 <20160426151725.657ae70c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160426151725.657ae70c@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Steven Rostedt <rostedt@goodmis.org> [160426 12:18]:
> Time to play "Whack-a-Mole"(TM)

:)

> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 78af6d8cf2e2..12b66b5bcc55 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -523,8 +523,8 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
>  
>  	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
>  		/* Trace the pwrdm desired target state */
> -		trace_power_domain_target(pwrdm->name, pwrst,
> -					  smp_processor_id());
> +		trace_power_domain_target_rcuidle(pwrdm->name, pwrst,
> +						  smp_processor_id());
>  		/* Program the pwrdm desired target state */
>  		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
>  	}

That part is already there with "arm: Use _rcuidle tracepoint to allow
use from idle" which I did not have applied.

Regards,

Tony
