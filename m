From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
Date: Mon, 06 Feb 2012 14:32:54 -0500
Message-ID: <1328556774.2200.28.camel@gandalf.stny.rr.com>
References: <alpine.LFD.2.02.1202012234050.2759@xanadu.home>
 <20120202044439.GD2435@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021159560.2759@xanadu.home>
 <20120202174337.GS2518@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021257340.2759@xanadu.home>
 <20120202190708.GE2518@linux.vnet.ibm.com> <87obtgc1xx.fsf@ti.com>
 <4F2B1307.5010207@gmail.com> <87k4437oaq.fsf@ti.com>
 <1328297787.5882.203.camel@gandalf.stny.rr.com>
 <20120204142123.GA14901@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120204142123.GA14901@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: paulmck@linux.vnet.ibm.com
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, mathieu.desnoyers@polymtl.ca, peterz@infradead.org, fweisbec@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, dhowells@redhat.com, Lennert Buytenhek <kernel@wantstofly.org>, Kevin Hilman <khilman@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, eric.dumazet@gmail.com, H Hartley Sweeten <hsweeten@visionengravers.com>, Magnus Damm <magnus.damm@gmail.com>, Tony Lindgren <tony@atomide.com>, dipankar@in.ibm.com, darren@dvhart.com, mingo@elte.hu, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Len Brown <len.brown@intel.com>, Amit Kucheria <amit.kucheria@canonical.com>, patches@linaro.org, Will Deacon <will.deacon@arm.com>, josh@joshtriplett.org, Sekhar Nori <nsekhar@ti.com>, niv@us.ibm.com, linux-samsung-soc@vger.kernel.org, Barry Song <baohua.song@csr.com>, tglx@linutronix.de, linux-oma
List-Id: linux-omap@vger.kernel.org

On Sat, 2012-02-04 at 06:21 -0800, Paul E. McKenney wrote:
> On Fri, Feb 03, 2012 at 02:36:27PM -0500, Steven Rostedt wrote:

> > Note, this race is even made harder to hit, because due to the static
> > branch that controls whether this gets called, will be off if no
> > tracepoints are attached. So the race can only happen after at least one
> > tracepoint is active.
> 
> I agree that this race is hard to hit when running Linux on bare metal.
> 
> But consider a Linux kernel running as a guest OS.  Then the host might
> preempt the guest in the middle of a tracepoint.  Then from the guest OS's
> viewpoint, that VCPU has just stopped, possibly for a very long time --
> easily long enough for all the other VCPUs to pass through quiescent
> states.  And the guest OS is ignoring that VCPU, so a too-short grace
> period could easily happen in this scenario.

But there's one thing that you forget. The race only happens on adding
or removing of the tracepoint, which requires human intervention.

That is, this gap needs to exist when a human starts or stops tracing on
the guest. For the race to occur, the one guest CPU has to preempt at
that exact location, and then be busy doing other things as a user on
the guest enables or disables tracing. For the enabled part, something
else had to already be tracing that same tracepoint (which seldom
happens, and only if the users chooses to (root user)). Otherwise, the
race only exists on removing the tracepoint.

OK, I'll update statement for running this on a guest. It is less likely
to trigger than me winning the lottery, becoming president of the United
states, *or* curing cancer. Not all together, just one of the above ;-)

-- Steve
