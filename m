From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] ARM: OMAP: Remove MPU-timer based sched_clock()
Date: Mon, 26 Nov 2007 10:40:04 -0800
Message-ID: <20071126184004.GC21886@atomide.com>
References: <20071112232401.723638265@mvista.com>
	<20071112232414.658134414@mvista.com>
	<20071123191815.GA559@atomide.com>
	<1196092764.8693.10.camel@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1196092764.8693.10.camel@vence.hilman.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [071126 07:59]:
> 
> On Fri, 2007-11-23 at 11:18 -0800, Tony Lindgren wrote:
> > * Kevin Hilman <khilman@mvista.com> [071112 15:25]:
> > > Remove MPU-timer based sched_clock() in favor of the common one based
> > > on 32k sync timer which works across all OMAP1/2/3 platforms.
> > > 
> > > Using 32k based one also gives a valid sched_clock() very early in the
> > > boot process.
> > 
> > AFAIK there is no 32k sync timer for 15xx, or have I missed something?
> > 
> 
> No there isn't.
> 
> But all this means is that 15xx has no higher resolution sched_clock().
> The ARM default jiffies-based one will be used.

I guess I don't understand what you're after by not using mpu timer 2
for proper sched_clock, some PM issues?

Maybe for PM reasons not having mpu timer 2 running could make sense if
it blocks some sleep states. But then again there's no timesource during
sleep states unless mpu timer 2 can use the 32K clock as a source clock..

Tony
