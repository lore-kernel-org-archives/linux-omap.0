From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH arm 1/1] arm: Use _rcuidle tracepoint to allow use from
 idle
Date: Tue, 26 Apr 2016 13:46:15 -0700
Message-ID: <20160426204613.GT5995@atomide.com>
References: <20160426175214.GJ3715@linux.vnet.ibm.com>
 <20160426182939.GO5995@atomide.com>
 <20160426190755.GK3715@linux.vnet.ibm.com>
 <20160426193949.GP5995@atomide.com>
 <20160426154414.7bb33de4@gandalf.local.home>
 <20160426195158.GR5995@atomide.com>
 <20160426200613.GO3715@linux.vnet.ibm.com>
 <20160426201134.GA29779@linux.vnet.ibm.com>
 <20160426202538.GS5995@atomide.com>
 <20160426204148.GR3715@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160426204148.GR3715@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, mingo@kernel.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160426 13:42]:
> On Tue, Apr 26, 2016 at 01:25:39PM -0700, Tony Lindgren wrote:
> > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160426 13:12]:
> > > On Tue, Apr 26, 2016 at 01:06:13PM -0700, Paul E. McKenney wrote:
> > > > On Tue, Apr 26, 2016 at 12:51:59PM -0700, Tony Lindgren wrote:
> > > > > * Steven Rostedt <rostedt@goodmis.org> [160426 12:45]:
> > > > > > *Whack* *Whack* *Whack*!!!
> > > > > > 
> > > > > > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > > > > > ---
> > > > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > > > index fb74dc1f7520..4fa43c02d682 100644
> > > > > > --- a/drivers/clk/clk.c
> > > > > > +++ b/drivers/clk/clk.c
> > > > > > @@ -682,12 +682,12 @@ static void clk_core_disable(struct clk_core *core)
> > > > > >  	if (--core->enable_count > 0)
> > > > > >  		return;
> > > > > >  
> > > > > > -	trace_clk_disable(core);
> > > > > > +	trace_clk_disable_rcuidle(core);
> > > > > >  
> > > > > >  	if (core->ops->disable)
> > > > > >  		core->ops->disable(core->hw);
> > > > > >  
> > > > > > -	trace_clk_disable_complete(core);
> > > > > > +	trace_clk_disable_complete_rcuidle(core);
> > > > > >  
> > > > > >  	clk_core_disable(core->parent);
> > > > > >  }
> > > > > 
> > > > > Now the mole shows up here!
> > > > 
> > > > And the patch shows up here!
> > > 
> > > And I bet you will need this one as well...
> > 
> > OK and now the mode is coming back after a short nap during idle:
> 
> Seems a bit unfair to whack it just after a short nap, but here goes!

This mode seems pretty hard headed :) Now clk_core_enable:

[ INFO: suspicious RCU usage. ]
4.6.0-rc5-next-20160426+ #1127 Not tainted
-------------------------------
include/trace/events/clk.h:45 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


RCU used illegally from idle CPU!
rcu_scheduler_active = 1, debug_locks = 0
RCU used illegally from extended quiescent state!
2 locks held by swapper/0/0:
 #0:  (&oh->hwmod_key#30){......}, at: [<c0121afc>] omap_hwmod_enable+0x18/0x44
 #1:  (enable_lock){......}, at: [<c0630684>] clk_enable_lock+0x18/0x124

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc5-next-20160426+ #1127
Hardware name: Generic OMAP36xx (Flattened Device Tree)
[<c0110290>] (unwind_backtrace) from [<c010c3a8>] (show_stack+0x10/0x14)
[<c010c3a8>] (show_stack) from [<c047fd68>] (dump_stack+0xb0/0xe4)
[<c047fd68>] (dump_stack) from [<c06315c0>] (clk_core_enable+0x1e0/0x36c)
[<c06315c0>] (clk_core_enable) from [<c0632298>] (clk_enable+0x1c/0x38)
[<c0632298>] (clk_enable) from [<c01204e0>] (_enable_clocks+0x18/0x7c)
[<c01204e0>] (_enable_clocks) from [<c012137c>] (_enable+0x114/0x2ec)
[<c012137c>] (_enable) from [<c0121b08>] (omap_hwmod_enable+0x24/0x44)
[<c0121b08>] (omap_hwmod_enable) from [<c0122ad0>] (omap_device_enable+0x3c/0x90)
[<c0122ad0>] (omap_device_enable) from [<c0122b34>] (_od_runtime_resume+0x10/0x38)
[<c0122b34>] (_od_runtime_resume) from [<c052cc00>] (__rpm_callback+0x2c/0x60)
[<c052cc00>] (__rpm_callback) from [<c052cc54>] (rpm_callback+0x20/0x80)
[<c052cc54>] (rpm_callback) from [<c052df7c>] (rpm_resume+0x3d0/0x6f0)
[<c052df7c>] (rpm_resume) from [<c052e2e8>] (__pm_runtime_resume+0x4c/0x64)
[<c052e2e8>] (__pm_runtime_resume) from [<c04bf2c4>] (omap2_gpio_resume_after_idle+0x54/0x68)
[<c04bf2c4>] (omap2_gpio_resume_after_idle) from [<c01269dc>] (omap3_enter_idle_bm+0xfc/0x1ec)
[<c01269dc>] (omap3_enter_idle_bm) from [<c0601888>] (cpuidle_enter_state+0x80/0x3d4)
[<c0601888>] (cpuidle_enter_state) from [<c0183b08>] (cpu_startup_entry+0x198/0x3a0)
[<c0183b08>] (cpu_startup_entry) from [<c0b00c0c>] (start_kernel+0x354/0x3c8)
[<c0b00c0c>] (start_kernel) from [<8000807c>] (0x8000807c)
