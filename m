From: Tony Lindgren <tony@atomide.com>
Subject: Re: I2C zero length transfers and SMBUS_QUICK
Date: Thu, 9 Nov 2006 04:32:13 +0200
Message-ID: <20061109023212.GE9740@atomide.com>
References: <20061103105004.70334.qmail@web37904.mail.mud.yahoo.com>
	<454DBDC7.70706@gmail.com> <200611051737.11242.david-b@pacbell.net>
	<20061107174039.GG6215@atomide.com>
	<20061107202432.2B2941DC800@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20061107202432.2B2941DC800@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [061107 22:24]:
> > > > Our hack to make things work on OMAP will not be accepted 
> > > > upstream. But staying with broken OMAP features only because 
> > > > (available) hack isn't acceptable in mainline doesn't sound 
> > > > like an option as well.
> > > > 
> > > > I personally vote for working OMAP ;)
> > > 
> > > Me too ... the sad part is that this is basically a design bug
> > > in the upstream I2C stack, and over the past couple years there
> > > have been no evident signs of it ever getting fixed.

The thing is that at some point when more and more people will be using
the mainline kernel with omap, we end up with mysterious problem reports
like "sound does not work" and then we don't know where the problem is.

So we really should figure out how to have the same version in
mainline and linux-omap tree.

> > I wonder if we could help somehow by doing "embedded i2c stack"
> > by modifying your SPI framework to support i2c?
> 
> Well, "clone-and-modify" vs "modify-in-place" ... could be.  I sure
> did that SPI framework with a strong goal of not repeating most design
> mistakes made in the the I2C stack!!  And folk tell me I succeeded...
> 
> An "embedded i2c" stack could be done easily:  clone-and-modify SPI,
> removing assumptions like "full duplex", "names start with spi_",
> and "addressing works like this"; add synchronous SMBUS-ish utilities
> on top; add drivers; share or stir, mixing to taste.  :)
> 
> 
> The politics of that would be more awkward than the technical side
> of things ... as you imply, the flaws in the current I2C stack are
> most glaringly evident to folk doing work in embedded systems (and
> not just OMAP).  So "embedded i2c" would be a useful starting meme.
> 
> After all, one point is the need for real I2C support ... and a stack
> designed around an assumption that everything supports SMBUS_QUICK
> should probably not be called an "i2c" stack!!
> 
> I think Jean Delvare has the notion that some people _are_ working on
> incremental tweaks to fix such issues in the upstream "I2C" stack.
> Anyone serious about fixing these issues should start some discussion
> on that I2C list.

Let's hope somebody picks it up at some point after getting tired of
working around the same issues over and over again :)

Tony
