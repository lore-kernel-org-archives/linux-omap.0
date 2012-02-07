From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RFC] tracing/rcu: Add trace_##name##__rcuidle() static
 tracepoint for inside rcu_idle_exit() sections
Date: Mon, 06 Feb 2012 19:36:28 -0500
Message-ID: <1328574988.2200.54.camel@gandalf.stny.rr.com>
References: <20120202190708.GE2518@linux.vnet.ibm.com>
 <87obtgc1xx.fsf@ti.com> <4F2B1307.5010207@gmail.com>
 <1328223819.5882.133.camel@gandalf.stny.rr.com>
 <20120202232736.GL2518@linux.vnet.ibm.com>
 <1328237131.5882.135.camel@gandalf.stny.rr.com>
 <20120203060458.GF2380@linux.vnet.ibm.com>
 <1328295309.5882.178.camel@gandalf.stny.rr.com>
 <20120203194005.GK2382@linux.vnet.ibm.com>
 <1328563113.2200.39.camel@gandalf.stny.rr.com>
 <20120206220502.GA21340@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120206220502.GA21340@leaf>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, mathieu.desnoyers@polymtl.ca, peterz@infradead.org, fweisbec@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, dhowells@redhat.com, Lennert Buytenhek <kernel@wantstofly.org>, Kevin Hilman <khilman@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, eric.dumazet@gmail.com, "Paul E. McKenney" <paul.mckenney@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Tony Lindgren <tony@atomide.com>, dipankar@in.ibm.com, darren@dvhart.com, mingo@elte.hu, paulmck@linux.vnet.ibm.com, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Len Brown <len.brown@intel.com>, Amit Kucheria <amit.kucheria@canonical.com>, patches@linaro.org, Will Deacon <will.deacon@arm.com>, Sekhar Nori <nsekhar@ti.com>, niv@us.ibm.com, linux-samsung-soc@vger.kernel.org, Barry Song <baohua.song@csr.com>, tglx@linutronix.delinux-
List-Id: linux-omap@vger.kernel.org

On Mon, 2012-02-06 at 14:05 -0800, Josh Triplett wrote:
> >   */
> > -#define __DO_TRACE(tp, proto, args, cond)				\
> > +#define __DO_TRACE(tp, proto, args, cond, pre, post)			\
> >  	do {								\
> >  		struct tracepoint_func *it_func_ptr;			\
> >  		void *it_func;						\
> > @@ -123,6 +123,7 @@ static inline void tracepoint_synchroniz
> >  		if (!(cond))						\
> >  			return;						\
> >  		rcu_read_lock_sched_notrace();				\
> > +		pre;							\
> >  		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
> 
> This results in calling rcu_idle_exit after rcu_read_lock; it needs to
> occur before.

Bah! Good catch. The fumes of my furnace must have been sending out some
strong narcotics. Yeah yeah, that's the reason for this mistake, and
I'll stand by it!

-- Steve
