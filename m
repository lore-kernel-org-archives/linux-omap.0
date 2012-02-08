From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH][RFC] tracing/rcu: Add trace_##name##__rcuidle() static
 tracepoint for inside rcu_idle_exit() sections
Date: Wed, 8 Feb 2012 14:57:50 +0100
Message-ID: <20120208135747.GA25473@somewhere.redhat.com>
References: <1328223819.5882.133.camel@gandalf.stny.rr.com>
 <20120202232736.GL2518@linux.vnet.ibm.com>
 <1328237131.5882.135.camel@gandalf.stny.rr.com>
 <20120203060458.GF2380@linux.vnet.ibm.com>
 <1328295309.5882.178.camel@gandalf.stny.rr.com>
 <20120203194005.GK2382@linux.vnet.ibm.com>
 <1328563113.2200.39.camel@gandalf.stny.rr.com>
 <20120206233804.GM5941@linux.vnet.ibm.com>
 <1328617976.2200.66.camel@gandalf.stny.rr.com>
 <20120207141142.GP5941@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20120207141142.GP5941@linux.vnet.ibm.com>
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, mathieu.desnoyers@polymtl.ca, peterz@infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, dhowells@redhat.com, Sekhar Nori <nsekhar@ti.com>, Lennert Buytenhek <kernel@wantstofly.org>, Kevin Hilman <khilman@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, eric.dumazet@gmail.com, "Paul E. McKenney" <paul.mckenney@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Tony Lindgren <tony@atomide.com>, dipankar@in.ibm.com, darren@dvhart.com, mingo@elte.hu, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Len Brown <len.brown@intel.com>, Amit Kucheria <amit.kucheria@canonical.com>, patches@linaro.org, Will Deacon <will.deacon@arm.com>, josh@joshtriplett.org, Steven Rostedt <rostedt@goodmis.org>, niv@us.ibm.com, linux-samsung-soc@vger.kernel.org, Barry Song <baohua.song@csr.com>, tglx@linutroni
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 07, 2012 at 06:11:42AM -0800, Paul E. McKenney wrote:
> On Tue, Feb 07, 2012 at 07:32:56AM -0500, Steven Rostedt wrote:
> > On Mon, 2012-02-06 at 15:38 -0800, Paul E. McKenney wrote:
> > 
> > > Aside from the "pre;" below needing to precede rcu_read_lock_sched_notrace()
> > > as Josh noted, this looks reasonable to me.
> > > 
> > 
> > Does this mean I can add an Acked-by from you and Josh? Obviously with
> > the post "pre" change.
> 
> With the "pre" change,
> 
> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Same for me! Good idea.

Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
