From: Imre Deak <imre.deak@nokia.com>
Subject: Re: [PATCH] input: ads7846: can't disable filtering [was OMAP5912
	touchscreen irq not working]
Date: Mon, 05 Jun 2006 19:04:20 +0300
Message-ID: <1149523460.11849.62.camel@mammoth.research.nokia.com>
References: <4477F2BA.3080907@gmail.com> <44842780.3010507@gmail.com>
	<1149517743.11849.39.camel@mammoth.research.nokia.com>
	<200606050817.13575.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200606050817.13575.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext David Brownell <david-b@pacbell.net>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 2006-06-05 at 08:17 -0700, ext David Brownell wrote:
> On Monday 05 June 2006 7:29 am, Imre Deak wrote:
> > 
> > The solution would be to use the IRQ line state - as we already do to
> > determine the pen down - for the pen up event as well.
> > ...
> > > Sorry, but at least on OSK with Mistral this new stuff isn't 
> > > usable. Old driver worked quite well.
> > 
> > Yes, I checked the old driver and it uses the pen IRQ for pen down / up
> > events, so that might be the difference.
> 
> Well, there have been recent regressions, but the new code _has_ worked
> quite well in the past ... 

Ok, it would be good to do some comparison on the readings before and
after the breakage. I'll try to get a board and figure this out.

> 
> Using the pen IRQ for driver state transitions is problematic, since the
> driver has to work with a variety of triggering modes ... both edges,
> falling only (or, with hw inverter, rising only), low level (or, with
> inverter, high).

I understand, but since on some platforms I think it is the only way to
go  and on others it may reduce the latency of pen up events could we
still have this feature as an option? If the platform can't define it's
pen down state function we could fall back on the current pen up
detection method.

--Imre

> 
> It's true that having that "poll penirq state" method is a big win.
> 
> - Dave
