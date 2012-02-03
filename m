From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
Date: Thu, 2 Feb 2012 22:04:58 -0800
Message-ID: <20120203060458.GF2380@linux.vnet.ibm.com>
References: <20120202044439.GD2435@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021159560.2759@xanadu.home>
 <20120202174337.GS2518@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021257340.2759@xanadu.home>
 <20120202190708.GE2518@linux.vnet.ibm.com> <87obtgc1xx.fsf@ti.com>
 <4F2B1307.5010207@gmail.com>
 <1328223819.5882.133.camel@gandalf.stny.rr.com>
 <20120202232736.GL2518@linux.vnet.ibm.com>
 <1328237131.5882.135.camel@gandalf.stny.rr.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1328237131.5882.135.camel@gandalf.stny.rr.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, mathieu.desnoyers@polymtl.ca, peterz@infradead.org, fweisbec@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, dhowells@redhat.com, Lennert Buytenhek <kernel@wantstofly.org>, Kevin Hilman <khilman@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, eric.dumazet@gmail.com, "Paul E. McKenney" <paul.mckenney@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Tony Lindgren <tony@atomide.com>, dipankar@in.ibm.com, darren@dvhart.com, mingo@elte.hu, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Len Brown <len.brown@intel.com>, Amit Kucheria <amit.kucheria@canonical.com>, patches@linaro.org, Will Deacon <will.deacon@arm.com>, josh@joshtriplett.org, Sekhar Nori <nsekhar@ti.com>, niv@us.ibm.com, linux-samsung-soc@vger.kernel.org, Barry Song <baohua.song@csr.com>, tglx@linutronix.de, linux-omap@v
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 02, 2012 at 09:45:31PM -0500, Steven Rostedt wrote:
> On Thu, 2012-02-02 at 15:27 -0800, Paul E. McKenney wrote:
> > On Thu, Feb 02, 2012 at 06:03:39PM -0500, Steven Rostedt wrote:
> > 
> > [ . . . ]
> > 
> > > Anyway, one answer is (and I was talking with Paul about this on IRC) is
> > > that we can create a special "TRACE_EVENT_IDLE()" that will explicitly
> > > call "rcu_idle_exit/enter()" as it expects to be called with it off.
> > > 
> > > This should solve most issues I believe.
> > 
> > You OK with something like RCU_NONIDLE() rather than RCU_EVENT_IDLE()?
> > I have this funny feeling that tracing won't be the only thing using
> > RCU from idle.  :-/
> > 
> > Something like this, perhaps?
> > 
> > 	#define RCU_NONIDLE(a) \
> > 		do { \
> > 			rcu_idle_exit(); \
> > 			do { a; } while (0); \
> > 			rcu_idle_enter(); \
> > 		}
> > 
> 
> I'm fine with this. But what is the overhead for doing such a thing.
> Remember, to encapsulate a tracepoint means that you will be doing that
> work everytime regardless if the tracepoint is ever activated or not. Or
> even worse, not even compiled into the kernel.
> 
> Now this is entering and exiting idle, so maybe it's not that critical?

It is an atomic instruction or two, plus some memory barriers.  Entering
idle is more heavyweight for RCU_FAST_NO_HZ.  But as you say, it is
entering and exiting idle.

But should I make an empty definition of RCU_NONIDLE() for some #define
or another?

	#ifdef CONFIG_YOU_TELL_ME
	#define RCU_NONIDLE(a) \
		do { \
			rcu_idle_exit(); \
			do { a; } while (0); \
			rcu_idle_enter(); \
		} while (0)
	#else /* #ifdef CONFIG_YOU_TELL_ME */
	#define RCU_NONIDLE(a) do { } while (0);
	#endif /* #else #ifdef CONFIG_YOU_TELL_ME */

Or is event tracing unconditional these days?

							Thanx, Paul
