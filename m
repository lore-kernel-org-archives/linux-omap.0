From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] input: ads7846: can't disable filtering [was OMAP5912
	touchscreen irq not working]
Date: Mon, 5 Jun 2006 09:13:29 -0700
Message-ID: <200606050913.29810.david-b@pacbell.net>
References: <4477F2BA.3080907@gmail.com>
	<200606050817.13575.david-b@pacbell.net>
	<1149523460.11849.62.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1149523460.11849.62.camel@mammoth.research.nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Imre Deak <imre.deak@nokia.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Monday 05 June 2006 9:04 am, Imre Deak wrote:

> > Using the pen IRQ for driver state transitions is problematic, since the
> > driver has to work with a variety of triggering modes ... both edges,
> > falling only (or, with hw inverter, rising only), low level (or, with
> > inverter, high).
> 
> I understand, but since on some platforms I think it is the only way to
> go  and on others it may reduce the latency of pen up events could we
> still have this feature as an option? If the platform can't define it's
> pen down state function we could fall back on the current pen up
> detection method.

Certainly.  I was never a big fan of that method, but it seemed to
be necessary ... if, after sorting out interrelated bugs in gpio irq
handling, omap_uwire, and ads7846 code, it all works without that
messy pressure sense-as-penup logic, I'd be happy!

- Dave



> --Imre
> 
> > 
> > It's true that having that "poll penirq state" method is a big win.
> > 
> > - Dave
> 
