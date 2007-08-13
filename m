From: Tony Lindgren <tony@atomide.com>
Subject: Re: Common code for TSC 2101 and 2102
Date: Mon, 13 Aug 2007 00:05:12 -0700
Message-ID: <20070813070512.GC13948@atomide.com>
References: <fb249edb0706040644w55ac4c55k495ae2050f94aea0@mail.gmail.com>
	<200707131304.24074.david-b@pacbell.net>
	<20070810072912.GE8658@atomide.com>
	<200708102004.59747.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200708102004.59747.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070810 20:05]:
> On Friday 10 August 2007, Tony Lindgren wrote:
> > I'll be pushing Andrzej's patch today.
> 
> I saw it ... it was after I've finally started to dig
> out from under my pile of patches going upstream, and
> even fired up an OMAP build again!  :)

Cool :)

> Glad to see this.  Now I'll have to actually take
> more of a real look at it.  Presumably I'll have a
> few updates, and then will feel it's time to start
> pushing three patches upstream from this big one:
> 
>  - drivers/spi/tsc210x.c core, which I can handle;
>  - drivers/hwmon/tsc210x_sensors.c, through hwmon;
>  - drivers/input/touchscreen/tsc210x_ts.c, through input;
>  - ... and later sound/soc/.../something.c, TBD.
> 
> I figure an initial upstream merge should included
> one or both of { touchscreen, hwmon } in addition
> to the core.  Hitting 2.6.24-early should be possible.

Great!

Tony
