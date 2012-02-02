From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
Date: Thu, 2 Feb 2012 12:13:00 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1202021159560.2759@xanadu.home>
References: <20120202004253.GA10946@linux.vnet.ibm.com>
 <1328143404-11038-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <1328143404-11038-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202012234050.2759@xanadu.home>
 <20120202044439.GD2435@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120202044439.GD2435@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: mathieu.desnoyers@polymtl.ca, peterz@infradead.org, fweisbec@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, dhowells@redhat.com, Lennert Buytenhek <kernel@wantstofly.org>, Kevin Hilman <khilman@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, eric.dumazet@gmail.com, H Hartley Sweeten <hsweeten@visionengravers.com>, Magnus Damm <magnus.damm@gmail.com>, Will Deacon <will.deacon@arm.com>, Tony Lindgren <tony@atomide.com>, dipankar@in.ibm.com, darren@dvhart.com, mingo@elte.hu, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Len Brown <len.brown@intel.com>, Amit Kucheria <amit.kucheria@canonical.com>, patches@linaro.org, Sekhar Nori <nsekhar@ti.com>, josh@joshtriplett.org, rostedt@goodmis.org, niv@us.ibm.com, linux-samsung-soc@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Barry Song <baohua.song@csr.com>, tglx@linutro
List-Id: linux-omap@vger.kernel.org

On Wed, 1 Feb 2012, Paul E. McKenney wrote:

> On Wed, Feb 01, 2012 at 10:49:22PM -0500, Nicolas Pitre wrote:
> > On Wed, 1 Feb 2012, Paul E. McKenney wrote:
> > 
> > > From: "Paul E. McKenney" <paul.mckenney@linaro.org>
> > > 
> > > The idle loop is a quiscent state for RCU, which means that RCU ignores
> > > CPUs that have told RCU that they are idle via rcu_idle_enter().
> > > There are nevertheless quite a few places where idle CPUs use RCU, most
> > > commonly indirectly via tracing.  This patch fixes these problems for ARM.
> > > 
> > > Many of these bugs have been in the kernel for quite some time, but
> > > Frederic's recent change now gives warnings.
> > > 
> > > This patch takes the straightforward approach of pushing the
> > > rcu_idle_enter()/rcu_idle_exit() pair further down into the core of the
> > > idle loop.
> > 
> > NAK.
> > 
> > 1) This is going to conflict with a patch series I've pushed to RMK 
> >    already.  You can see its result in linux-next.
> > 
> > 2) The purpose of (1) is to do precisely the very opposite i.e. move as 
> >    much common knowledge as possible up the idle call paths and leave 
> >    the platform specific quirks as bare as possible, if any.
> > 
> > So I'd much prefer if this change was constrained to be inside 
> > cpu_idle(), or at least in its close vicinity.
> 
> OK.  Then the tracing in the inner idle loop needs to go.  Other
> restructuring might be required as well. 

Let me expand a bit more on the "if any" in my #2 above.  Most ARM 
sub-architectures don't have any special idle drivers and they simply 
rely on the default cpu_do_idle call.  What this proposed patch is doing 
is to move the rcu_idle_enter()/rcu_idle_exit() pair down into the few 
subarchs with an existing cpu-idle callback.  This means in practice 
that rcu_idle_enter()/rcu_idle_exit() wouldn't be called at all anymore 
on most ARM targets.  Is that appropriate?

> The long and short of it is that you absolutely cannot use RCU between 
> the time you invoke rcu_idle_enter() and the time you invoke 
> rcu_idle_exit().  The ARM idle code currently does just that and 
> therefore must change.
> 
> Whatever change you choose that causes the code to meet that constraint
> is met is fine by me.
> 
> But that constraint absolutely must be met.

I would have to know more about what the rcu_idle_*() calls imply before 
suggesting an alternative.


Nicolas
