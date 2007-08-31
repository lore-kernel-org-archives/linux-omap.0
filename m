From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/2] MUSB: tracking down locking bugs
Date: Thu, 30 Aug 2007 23:38:49 -0700
Message-ID: <20070831063849.D66E621D977@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20070831025359.663866890@mvista.com>
	<20070831054830.13B7B21D977@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<46D7AF5D.2020204@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <46D7AF5D.2020204@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: khilman@mvista.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> >> With the help of the lock debugging features of the -rt patch, I'm
> >> trying to track down locking issues in the MUSB driver.
> > 
> > It was last done about 18 months ago, so it's clearly Time to
> > check those locks again.  :)
>
> Agreed.
>
> In the short term, I'll have a couple more "band-aid" style patches for
> you to sanity check.  They fix a couple deadlocks uncovered by my
> 'BUG_ON' patch, but since I don't know this driver all that well, there
> may be better ways to do things.

The simple solution is to just analyse the call paths.  Remember too
that a BUG_ON(f(spin_is_locked(L))) is likely to be a false alarm...

Also, nowadays I run most things with lockdep, which helps establish
that there can't be *that* many locking bugs.


> For the long term, more lock granularity should probably be used.  For
> example, currently the entire interrupt handler wrapped with a
> spin_lock_irqsave().  When moving to the threaded interrupts of
> PREEMPT_RT, this effictively negates the benefit of having threaded
> handlers in the first place.

I've heard that conventional wisdom -- conventional to advocates
of threaded IRQ handlers, that is! -- but I don't exactly see how
it would apply in cases like this.

Having multiple execution contexts trip over each others' accesses
to registers or data structures isn't a way to have a safe driver.

- Dave
