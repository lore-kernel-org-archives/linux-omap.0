From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH arm 1/1] arm: Use _rcuidle tracepoint to allow use from
 idle
Date: Tue, 26 Apr 2016 13:41:48 -0700
Message-ID: <20160426204148.GR3715@linux.vnet.ibm.com>
References: <20160426150031.GP5995@atomide.com>
 <20160426175214.GJ3715@linux.vnet.ibm.com>
 <20160426182939.GO5995@atomide.com>
 <20160426190755.GK3715@linux.vnet.ibm.com>
 <20160426193949.GP5995@atomide.com>
 <20160426154414.7bb33de4@gandalf.local.home>
 <20160426195158.GR5995@atomide.com>
 <20160426200613.GO3715@linux.vnet.ibm.com>
 <20160426201134.GA29779@linux.vnet.ibm.com>
 <20160426202538.GS5995@atomide.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160426202538.GS5995@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, mingo@kernel.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 26, 2016 at 01:25:39PM -0700, Tony Lindgren wrote:
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160426 13:12]:
> > On Tue, Apr 26, 2016 at 01:06:13PM -0700, Paul E. McKenney wrote:
> > > On Tue, Apr 26, 2016 at 12:51:59PM -0700, Tony Lindgren wrote:
> > > > * Steven Rostedt <rostedt@goodmis.org> [160426 12:45]:
> > > > > *Whack* *Whack* *Whack*!!!
> > > > > 
> > > > > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > > > > ---
> > > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > > index fb74dc1f7520..4fa43c02d682 100644
> > > > > --- a/drivers/clk/clk.c
> > > > > +++ b/drivers/clk/clk.c
> > > > > @@ -682,12 +682,12 @@ static void clk_core_disable(struct clk_core *core)
> > > > >  	if (--core->enable_count > 0)
> > > > >  		return;
> > > > >  
> > > > > -	trace_clk_disable(core);
> > > > > +	trace_clk_disable_rcuidle(core);
> > > > >  
> > > > >  	if (core->ops->disable)
> > > > >  		core->ops->disable(core->hw);
> > > > >  
> > > > > -	trace_clk_disable_complete(core);
> > > > > +	trace_clk_disable_complete_rcuidle(core);
> > > > >  
> > > > >  	clk_core_disable(core->parent);
> > > > >  }
> > > > 
> > > > Now the mole shows up here!
> > > 
> > > And the patch shows up here!
> > 
> > And I bet you will need this one as well...
> 
> OK and now the mode is coming back after a short nap during idle:

Seems a bit unfair to whack it just after a short nap, but here goes!

							Thanx, Paul

------------------------------------------------------------------------

commit 5c8e9cffebfc02acfbcfd18b46a6b1dbce96cbe3
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue Apr 26 13:38:55 2016 -0700

    arm: Whack yet another event-trace-from-idle mole
    
    This commit applies another _rcuidle suffix to fix an RCU use from
    idle.
    
    > ===============================
    > [ INFO: suspicious RCU usage. ]
    > 4.6.0-rc5-next-20160426+ #1122 Not tainted
    > -------------------------------
    > include/trace/events/rpm.h:69 suspicious rcu_dereference_check() usage!
    >
    > other info that might help us debug this:
    >
    >
    > RCU used illegally from idle CPU!
    > rcu_scheduler_active = 1, debug_locks = 0
    > RCU used illegally from extended quiescent state!
    > 1 lock held by swapper/0/0:
    >  #0:  (&(&dev->power.lock)->rlock){-.-...}, at: [<c052e3dc>] __pm_runtime_resume+0x3c/0x64
    >
    > stack backtrace:
    > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc5-next-20160426+ #1122
    > Hardware name: Generic OMAP36xx (Flattened Device Tree)
    > [<c0110290>] (unwind_backtrace) from [<c010c3a8>] (show_stack+0x10/0x14)
    > [<c010c3a8>] (show_stack) from [<c047fd68>] (dump_stack+0xb0/0xe4)
    > [<c047fd68>] (dump_stack) from [<c052e178>] (rpm_resume+0x5cc/0x7f4)
    > [<c052e178>] (rpm_resume) from [<c052e3ec>] (__pm_runtime_resume+0x4c/0x64)
    > [<c052e3ec>] (__pm_runtime_resume) from [<c04bf2c4>] (omap2_gpio_resume_after_idle+0x54/0x68)
    > [<c04bf2c4>] (omap2_gpio_resume_after_idle) from [<c01269dc>] (omap3_enter_idle_bm+0xfc/0x1ec)
    > [<c01269dc>] (omap3_enter_idle_bm) from [<c060198c>] (cpuidle_enter_state+0x80/0x3d4)
    > [<c060198c>] (cpuidle_enter_state) from [<c0183b08>] (cpu_startup_entry+0x198/0x3a0)
    > [<c0183b08>] (cpu_startup_entry) from [<c0b00c0c>] (start_kernel+0x354/0x3c8)
    > [<c0b00c0c>] (start_kernel) from [<8000807c>] (0x8000807c)
    
    Reported-by: Tony Lindgren <tony@atomide.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Tony Lindgren <tony@atomide.com>
    Cc: Russell King <linux@arm.linux.org.uk>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: <linux-omap@vger.kernel.org>
    Cc: <linux-arm-kernel@lists.infradead.org>

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index e4c2b8fdeff3..15b6d5b199d4 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -601,7 +601,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 	struct device *parent = NULL;
 	int retval = 0;
 
-	trace_rpm_resume(dev, rpmflags);
+	trace_rpm_resume_rcuidle(dev, rpmflags);
 
  repeat:
 	if (dev->power.runtime_error)
@@ -764,7 +764,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 		spin_lock_irq(&dev->power.lock);
 	}
 
-	trace_rpm_return_int(dev, _THIS_IP_, retval);
+	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
 
 	return retval;
 }
