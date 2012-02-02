From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
Date: Thu, 2 Feb 2012 15:03:26 -0800
Message-ID: <20120202230326.GJ2518@linux.vnet.ibm.com>
References: <20120202004253.GA10946@linux.vnet.ibm.com>
 <1328143404-11038-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <1328143404-11038-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202012234050.2759@xanadu.home>
 <20120202044439.GD2435@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021159560.2759@xanadu.home>
 <20120202174337.GS2518@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021257340.2759@xanadu.home>
 <20120202190708.GE2518@linux.vnet.ibm.com> <87obtgc1xx.fsf@ti.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87obtgc1xx.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, mathieu.desnoyers@polymtl.ca, peterz@infradead.org, fweisbec@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, dhowells@redhat.com, Lennert Buytenhek <kernel@wantstofly.org>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, eric.dumazet@gmail.com, "Paul E. McKenney" <paul.mckenney@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Tony Lindgren <tony@atomide.com>, dipankar@in.ibm.com, darren@dvhart.com, mingo@elte.hu, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Len Brown <len.brown@intel.com>, Amit Kucheria <amit.kucheria@canonical.com>, patches@linaro.org, Will Deacon <will.deacon@arm.com>, josh@joshtriplett.org, Sekhar Nori <nsekhar@ti.com>, niv@us.ibm.com, linux-samsung-soc@vger.kernel.org, rostedt@goodmis.org, Barry Song <baohua.song@csr.com>, tglx@linutronix.de, linux-omap@vger.kerne
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 02, 2012 at 02:20:26PM -0800, Kevin Hilman wrote:
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> 
> [...]
> 
> >> > The two options I see are:
> >> > 
> >> > 1.	Rip tracing out of the inner idle loops and everything that
> >> > 	they invoke.
> >> 
> >> What I suggested above.  But as I said I know sh*t about that tracing 
> >> implementation so that's an easy suggestion for me to make.
> >
> > Works for me as well.  ;-)
> 
> While I must admit not having a better suggestion, I for one would vote
> strongly against removing tracing from the idle path.
> 
> Being a PM developer and maintainer, much of the code I work on and
> maintain happens to be run in the bowels of the idle path.  Not having
> the ability to trace this code would be a major step backwards IMO.

OK...

What if the tracing code between the rcu_idle_enter() and the
rcu_idle_exit() had to be enclosed in a wrapper?  For example,
the tracing in cpuidle_idle_call() might appear as follows:

	RCU_NONIDLE(
		trace_power_start(POWER_CSTATE, next_state, dev->cpu);
		trace_cpu_idle(next_state, dev->cpu);
	);

	entered_state = target_state->enter(dev, drv, next_state);

	RCU_NONIDLE(
		trace_power_end(dev->cpu);
		trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
	);

The RCU_NONIDLE() macro would do rcu_idle_exit(), execute its
argument, then do rcu_idle_enter().  (Credit to Steven Rostedt
for suggesting this.)  Given the possibility of code invoked both
from idle and not-idle, I have some changes to rcu to allow nesting
of rcu_idle_enter() and rcu_idle_exit().

Would that work for you?

							Thanx, Paul
