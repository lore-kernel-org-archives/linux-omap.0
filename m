From: Johan Hovold <johan@kernel.org>
Subject: Re: OMAP serial runtime PM and autosuspend (was: Re: [PATCH 4/7]
 dt-bindings: gnss: add u-blox binding))
Date: Mon, 21 May 2018 15:48:30 +0200
Message-ID: <20180521134830.GR30172@localhost>
References: <20180507175032.GR98604@atomide.com>
 <20180508065852.GW2285@localhost>
 <20180508152228.GV98604@atomide.com>
 <20180508154756.GW98604@atomide.com>
 <20180508155405.GX98604@atomide.com>
 <20180508164904.GZ98604@atomide.com>
 <20180509131003.GC2285@localhost>
 <20180509135706.GB98604@atomide.com>
 <20180517100948.GI30172@localhost>
 <20180517171038.GL98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180517171038.GL98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Johan Hovold <johan@kernel.org>, Sebastian Reichel <sre@kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Andreas Kemnade <andreas@kemnade.info>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, May 17, 2018 at 10:10:38AM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [180517 10:12]:
> > [ Sorry about the late reply. ]
> > 
> > On Wed, May 09, 2018 at 06:57:06AM -0700, Tony Lindgren wrote:
> > > * Johan Hovold <johan@kernel.org> [180509 13:12]:
> > 
> > > > It seems we really should not be using the negative autosuspend to
> > > > configure the RPM behaviour the way these drivers do. Perhaps a new
> > > > mechanism is needed.
> > > 
> > > Hmm well simply defaulting to "on" instead of "auto" and setting the
> > > autosuspend_ms to 3000 by default might be doable. I think that way
> > > we can keep use_autosuspend() in probe. Let's hope there are no
> > > existing use cases that would break with that.
> > 
> > No, defaulting to "on" (i.e. calling pm_runtime_forbid()) wouldn't work
> > either as that would also prevent the device from runtime suspending
> > just as the current negative autosuspend delay does.
> 
> Well in that case we should just stick with -1 value for the
> autosuspend. And just do pm_runtime_put_sync_suspend() after
> probe and on close.

That won't work either as a negative autosuspend delay prevents runtime
suspend completely (by grabbing an extra RPM reference).

> > I fail to see how we can implement this using the current toolbox. What
> > you're after here is really a mechanism for selecting between two
> > different runtime PM schemes at runtime:
> > 
> > 	1. normal serial RPM, where the controller is active while the
> > 	   port is open (this should be the safe default)
> 
> Agreed. And that is the case already.

Yes, but it's not really the case today as since omap-serial (and
8250-omap) sets a negative autosuspend at probe and hence does not
runtime-suspend when the port is closed. So that's the long-standing bug
which needs fixing.

> > 	2. aggressive serial RPM, where the controller is allowed to
> > 	   suspend while the port is open even though this may result in
> > 	   lost characters when waking up on incoming data
> 
> In this case it seems that the only thing needed is to just
> configure the autosuspend delay for the parent port. The use of
> -1 has been around since the start of runtime PM AFAIK, so maybe
> we should just document it. I guess we could also introduce
> pm_runtime_block_autoidle_unless_configured() :)

The implications of a negative autosuspend delay are already documented
(in Documentation/power/runtime_pm.txt); it's just the omap drivers that
gets it wrong when trying to do things which aren't currently supported
(and never have been).

So I still think we need a new mechanism for this.

> > For normal ttys, we need a user-space interface for selecting between
> > the two, and for serdev we may want a way to select the RPM scheme from
> > within the kernel.
> > 
> > Note that with my serdev controller runtime PM patch, serdev core could
> > always opt for aggressive PM (as by default serdev core holds an RPM
> > reference for the controller while the port is open).
> 
> So if your serdev controller was to set the parent autosuspend
> delay on open() and set it back on close() this should work?

Is it really the job of a serdev driver to set the autosuspend delay of
a parent controller? Isn't this somethings which depends on the
characteristics of the controller (possibly configurable by user space)
such as the cost of runtime suspending and resuming?

The patch I posted works with what we have today; if a parent serial
controller driver uses aggressive runtime PM by default or after having
been configured through sysfs to do so.

What I'm getting at here is that the delay should be set by the serial
driver implementing aggressive runtime PM. Then all we need is a
mechanism to determine whether an extra RPM reference should be taken at
tty open or not (configurable by user space, defaulting to yes).

Specifically, the serial drivers themselves would always use
autosuspend and not have to deal with supporting the two RPM schemes
(normal vs aggressive runtime PM).

Thanks,
Johan
