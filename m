From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: rcu self-detected stall messages on OMAP3, 4 boards
Date: Fri, 21 Sep 2012 11:58:27 -0700
Message-ID: <20120921185827.GC2454@linux.vnet.ibm.com>
References: <alpine.DEB.2.00.1209122237080.7275@utopia.booyaka.com>
 <20120913011208.GT4257@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209131839000.23318@utopia.booyaka.com>
 <20120920000351.GI2455@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209200753450.3801@utopia.booyaka.com>
 <F95344A7-3351-4E6B-BF61-37E591AF16A2@ti.com>
 <20120920220130.GN2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com>
 <20120920232114.GO2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Bruce, Becky" <bbruce@ti.com>, "Paul E. McKenney" <paul.mckenney@linaro.org>, "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<linux-arm-kernel@lists.infradead.org>" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, "<snijsure@grid-net.com>" <snijsure@grid-net.com>, fweisbec@gmail.com
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 21, 2012 at 06:08:59PM +0000, Paul Walmsley wrote:
> cc Frederic Weisbecker - context is here: 
> 
>    http://marc.info/?l=linux-kernel&m=134749030206016&w=2
> 
> On Thu, 20 Sep 2012, Paul E. McKenney wrote:
> 
> > Fair point.  I am wondering whether there is some path into the idle
> > loop that somehow avoids telling RCU that the CPU has in face entered
> > idle.  There needs to be an rcu_idle_enter() call on the way to idle,
> > otherwise RCU CPU stall warnings are expected behavior.
> 
> As far as I know, our only idle entry point is in 
> arch/arm/common/process.c:cpu_idle().

In mainline, this is arch/arm/kernel/process.c, correct?

> Looking at the x86 idle entry, they call rcu_idle_{enter,exit}() inside 
> {stop,start}_critical_timings().  Making that change here didn't help.

The reason x86 does this is that they have idle notifiers deeper in the
idle loop that use RCU read-side critical sections.  So this was an
expected result.

> Also tried commenting out the code from the stop_critical_timings() call 
> to the WARN_ON(irqs_disabled()), and adding a local_irq_enable().  That 
> also didn't help, which suggests that the problem is not caused by the 
> OMAP-specific PM idle code.

I must admit that you make a convincing case here.  Though it does leave
me wondering what is different about Panda (and MX28, IIRC).

I may take your advice of remote access to a Panda board, though that
is likely to take a bit of time due to timezones.  Regardless of the
underlying issue here, I clearly need to make the stall-warning messages
do a better job of printing out needed information.

							Thanx, Paul
