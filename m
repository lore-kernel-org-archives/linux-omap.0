From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression with suspicious RCU usage splats with cpu_pm change
Date: Wed, 19 Jul 2017 01:01:15 -0700
Message-ID: <20170719080115.GN10026@atomide.com>
References: <20170713070749.GE16509@atomide.com>
 <c00272dc-cf84-81a2-b2e2-d52cadf7bcc6@linaro.org>
 <CAJZ5v0j15uWyCRAPep4KwqSiC4UD4ZppAG++SUvN3Ok1wzDwNQ@mail.gmail.com>
 <20170713124318.GK2393@linux.vnet.ibm.com>
 <c5c6623b-ea1d-1bbf-ea80-5d93e7e81c6f@linaro.org>
 <20170717060806.GC10026@atomide.com>
 <20170717123938.GP2393@linux.vnet.ibm.com>
 <20170718054137.GK10026@atomide.com>
 <20170718170001.GD3981@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170718170001.GD3981@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Alex Shi <alex.shi@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>
List-Id: linux-omap@vger.kernel.org

* Paul E. McKenney <paulmck@linux.vnet.ibm.com> [170718 10:00]:
> On Mon, Jul 17, 2017 at 10:41:38PM -0700, Tony Lindgren wrote:
> > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [170717 05:40]:
> > > On Sun, Jul 16, 2017 at 11:08:07PM -0700, Tony Lindgren wrote:
> > > > * Alex Shi <alex.shi@linaro.org> [170716 16:25]:
> > > > > I reused the rcu_irq_enter_irqson() from RCU_NONIDLE to avoid this issue. 
> > > > > It works fine.
> > > > > 
> > > > > Tony, Could you like to give a tested-by if this patch works for you.
> > > > 
> > > > Yeah that keeps things booting for me with no splats so:
> > > > 
> > > > Tested-by: Tony Lindgren <tony@atomide.com>
> > > > 
> > > > In general, it seems we're missing the knowledge in Linux kernel
> > > > of when the entire system is idle. Right now it seems that only
> > > > cpuidle_coupled knows that?
> > > > 
> > > > We could probably simplify things by adding some PM state for
> > > > entire system idle. Then cpuidle code and timer code could use
> > > > that to test when it's safe to do whatever the SoC needs to do
> > > > to enter deeper power states.
> > > > 
> > > > If we already have something like that, please do let me know :)
> > > 
> > > Well, we used to have CONFIG_NO_HZ_FULL_SYSIDLE, which detected
> > > full-system idle lazily so as to avoid scalability bottlenecks.
> > > https://lwn.net/Articles/558284/
> > > 
> > > No one was using it, so I removed it last merge window.  The
> > > patch that removed it is at sysidle.2017.05.11a, which can
> > > probably still be reverted cleanly.  Or just use v4.11 or earlier.
> > 
> > OK thanks for the pointer, for reference that commit is
> > fe5ac724d81a ("rcu: Remove nohz_full full-system-idle state
> > machine").
> > 
> > For a potential user, I think we could use it for example in
> > cpuidle_enter_state_coupled() + omap_enter_idle_coupled() where
> > we try to figure out if the system is fully idle before calling
> > tick_broadcast_enter().
> 
> Would you be willing to prototype your usage on v4.12?  It still has
> NO_HZ_FULL_SYSIDLE.  You have to enable NO_HZ_FULL in order to enable
> NO_HZ_FULL_SYSIDLE at the moment.
> 
> Either way, here is the important bit for usage:
> 
> 	bool rcu_sys_is_idle(void);
> 	void rcu_sysidle_force_exit(void);
> 
> The rcu_sys_is_idle() function returns true if all CPUs other than the
> time-keeping CPU (that is, tick_do_timer_cpu, which is usually CPU 0)
> are in their idle loop.  Of course, if you invoke rcu_sys_is_idle()
> from any CPU other than the time-keeping CPU, you will automatically
> get a return value of false.
> 
> RCU's idle-exit code already sets state appropriately, but if there
> is some other circumstance where you need to force the state machine
> out of all-CPUs-idle state, you can call rcu_sysidle_force_exit().

OK sure I'll take a look at some point.

Thanks,

Tony
