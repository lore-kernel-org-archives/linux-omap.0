From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH arm 1/1] arm: Use _rcuidle tracepoint to allow use from
 idle
Date: Tue, 26 Apr 2016 12:42:15 -0700
Message-ID: <20160426194215.GL3715@linux.vnet.ibm.com>
References: <1461617335-22372-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20160426150031.GP5995@atomide.com>
 <20160426175214.GJ3715@linux.vnet.ibm.com>
 <20160426182939.GO5995@atomide.com>
 <20160426151725.657ae70c@gandalf.local.home>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160426151725.657ae70c@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 26, 2016 at 03:17:25PM -0400, Steven Rostedt wrote:
> On Tue, 26 Apr 2016 11:29:39 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160426 10:53]:
> > > Does the following patch help?  
> > 
> > It just changes the output.. See below.
> > 
> > > It is quite possible that there are quite a few more of these.  If this
> > > is the case, then one way to make the kernel list more of them on a
> > > given boot is to build with CONFIG_PROVE_RCU_REPEATEDLY=y.  
> > 
> > OK
> > 
> > Regards,
> > 
> > Tony
> > 
> > 8< ------------------
> > CPU: Testing write buffer coherency: ok
> > CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> > 
> > 
> > RCU used illegally from idle CPU!
> > rcu_scheduler_active = 1, debug_locks = 0
> > RCU used illegally from extended quiescent state!
> > no locks held by swapper/1/0.
> > 
> > stack backtrace:
> > CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.6.0-rc5-next-20160426+ #1113
> > Hardware name: Generic OMAP4 (Flattened Device Tree)
> > [<c0110290>] (unwind_backtrace) from [<c010c3a8>] (show_stack+0x10/0x14)
> > [<c010c3a8>] (show_stack) from [<c047ff88>] (dump_stack+0xb0/0xe4)
> > [<c047ff88>] (dump_stack) from [<c012c014>] (pwrdm_set_next_pwrst+0x100/0x1d4)
> > [<c012c014>] (pwrdm_set_next_pwrst) from [<c0126120>] (omap4_enter_lowpower+0xc8/0x230)
> > [<c0126120>] (omap4_enter_lowpower) from [<c0126c24>] (omap_enter_idle_coupled+0x6c/0x254)
> > [<c0126c24>] (omap_enter_idle_coupled) from [<c0601dfc>] (cpuidle_enter_state+0x80/0x3d4)
> > [<c0601dfc>] (cpuidle_enter_state) from [<c0603d30>] (cpuidle_enter_state_coupled+0x348/0x390)
> > [<c0603d30>] (cpuidle_enter_state_coupled) from [<c0183d34>] (cpu_startup_entry+0x198/0x3a0)
> > [<c0183d34>] (cpu_startup_entry) from [<8010162c>] (0x8010162c)
> > hw-breakpoint: Failed to enable monitor mode on CPU 0.
> 
> Time to play "Whack-a-Mole"(TM)

Indeed!  ;-)

> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Given the similarity with the following:

	http://lkml.kernel.org/g/20160425171239.GE3874@linux.vnet.ibm.com

May I apply your Reviewed-by?

							Thanx, Paul

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
> 
