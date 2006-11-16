From: David Brownell <david-b@pacbell.net>
Subject: Re: Moving I2C2 init to plat-omap/devices.c  ?
Date: Thu, 16 Nov 2006 13:29:50 -0800
Message-ID: <20061116212950.C0BC61DF56F@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <EA12F909C0431D458B9D18A176BEE4A508A01E5E@dlee02.ent.ti.com>
	<200611161219.54874.david-b@pacbell.net>
	<20061116205518.GT21064@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061116205518.GT21064@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> >  http://lists.lm-sensors.org/pipermail/i2c/2006-November/000458.html
> > 	... simple updates, some cleanup plus adding some missing
> > 	driver model calls:  shutdown(), and suspend()/resume().
> > 	Looks like this will be merged after minor tweaking.
> > 
> >  http://lists.lm-sensors.org/pipermail/i2c/2006-November/000469.html
> > 	... not actually a patch; copied at the end of this message,
> > 	this introduces the three interesting patches
> > 
> >  http://lists.lm-sensors.org/pipermail/i2c/2006-November/000470.html
> > 	... first patch mentioned, adds new driver binding model
> > 	that fully conforms to the Linux driver model
> > 
> >  http://lists.lm-sensors.org/pipermail/i2c/2006-November/000468.html
> > 	... second patch mentioned, activates that new model
> > 
> >  http://lists.lm-sensors.org/pipermail/i2c/2006-November/000471.html
> > 	... updates OSK support to use it, and tps65010 driver
> > 	(but not aic23/ALSA, that's not upstream yet)
> > 
> > I figure getting those last three patches merged will "take a bit of
> > effort", so feel free to weigh in.  In terms of the original post on
> > this thread, it sort of assumes the OMAP I2C host would switch over
> > to a slightly different registration call, more or less passing the
> > platform_device.id ("2" etc) to the I2C layer and saying "use this
> > as the bus ID".
>
> Wow, that's great, nice job! That should fix the zero length i2c
> probe issue too :)

I find that I prefer to think of it as the "so-called 'I2C' stack
can't work without 'SMBUS_QUICK'" issue.  ;)

It does happen to be true that SMBUS_QUICK would be a zero-length
transaction, if I2C allowed those (and I'm told it doesn't) ... and
of course, anyone starting to use the I2C stack has to get over a
major wierd-out caused by the way that stack violates almost every
rule about how to write drivers in Linux.

- Dave
