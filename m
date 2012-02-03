From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
Date: Fri, 3 Feb 2012 12:23:34 -0800
Message-ID: <20120203202334.GM2382@linux.vnet.ibm.com>
References: <20120202190708.GE2518@linux.vnet.ibm.com> <87obtgc1xx.fsf@ti.com>
 <4F2B1307.5010207@gmail.com>
 <1328223819.5882.133.camel@gandalf.stny.rr.com>
 <20120202232736.GL2518@linux.vnet.ibm.com>
 <1328237131.5882.135.camel@gandalf.stny.rr.com>
 <20120203060458.GF2380@linux.vnet.ibm.com>
 <1328295309.5882.178.camel@gandalf.stny.rr.com>
 <20120203194005.GK2382@linux.vnet.ibm.com>
 <1328299375.5882.204.camel@gandalf.stny.rr.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1328299375.5882.204.camel@gandalf.stny.rr.com>
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

On Fri, Feb 03, 2012 at 03:02:55PM -0500, Steven Rostedt wrote:
> On Fri, 2012-02-03 at 11:40 -0800, Paul E. McKenney wrote:
> 
> > So the idea is that if you have a trace event that is to be used in idle,
> > you use TRACE_EVENT_IDLE() rather than TRACE_EVENT() to declare that
> > trace event?  That would work for me, and might make for fewer changes
> > for the architecture guys.  Also, this should address the code-size
> > concerns we discussed yesterday.
> > 
> > So sounds good!
> > 
> > Is a DEFINE_EVENT_IDLE() also needed?  Or prehaps a
> > DECLARE_EVENT_CLASS_IDLE()?  My guess is "yes" for at least one of the
> > two based on include/trace/events/power.h.
> 
> I'll have to take a look. I may even find a better way to do this too.

Better is always better.  ;-)

> > I will keep RCU_NONIDLE() for at least a little while (reworking comments
> > to point out TRACE_EVENT_IDLE() and friends) in case there turn out to
> > be non-tracepoint uses of RCU in the idle loop.
> 
> OK, I'll take a crack at this next Monday.

Sounds good!

I plan to push my stack to -next later today, but will yank my cpuidle
commit as soon as your approach is available.  They do not conflict
because the rcu_idle_enter()s nest.

							Thanx, Paul
