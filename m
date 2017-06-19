From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] ARM/hw_breakpoint: Fix possible recursive locking for
 arch_hw_breakpoint_init
Date: Mon, 19 Jun 2017 16:17:21 +0100
Message-ID: <20170619151720.GC9291@arm.com>
References: <20170616082238.15553-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170616082238.15553-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 16, 2017 at 01:22:38AM -0700, Tony Lindgren wrote:
> Recent change to use cpuhp_setup_state_cpuslocked() with commit
> fe2a5cd8aa03 ("ARM/hw_breakpoint: Use cpuhp_setup_state_cpuslocked()")
> missed to change the related paired cpuhp_remove_state_nocalls_cpuslocked().
> 
> Now if arch_hw_breakpoint_init() fails, we get "WARNING: possible recursive
> locking detected" on the exit path.
> 
> Fixes: fe2a5cd8aa03 ("ARM/hw_breakpoint: Use
> cpuhp_setup_state_cpuslocked()")
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/kernel/hw_breakpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This looks correct to me, so I guess it should go via -tip (where the
problematic patch is queued already).

Will

> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -1106,7 +1106,7 @@ static int __init arch_hw_breakpoint_init(void)
>  		core_num_brps = 0;
>  		core_num_wrps = 0;
>  		if (ret > 0)
> -			cpuhp_remove_state_nocalls(ret);
> +			cpuhp_remove_state_nocalls_cpuslocked(ret);
>  		cpus_read_unlock();
>  		return 0;
>  	}
> -- 
> 2.13.0
