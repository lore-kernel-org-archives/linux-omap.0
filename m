From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP serial runtime PM and autosuspend (was: Re: [PATCH 4/7]
 dt-bindings: gnss: add u-blox binding))
Date: Thu, 24 May 2018 06:32:37 -0700
Message-ID: <20180524133237.GA98604@atomide.com>
References: <20180508154756.GW98604@atomide.com>
 <20180508155405.GX98604@atomide.com>
 <20180508164904.GZ98604@atomide.com>
 <20180509131003.GC2285@localhost>
 <20180509135706.GB98604@atomide.com>
 <20180517100948.GI30172@localhost>
 <20180517171038.GL98604@atomide.com>
 <20180521134830.GR30172@localhost>
 <20180521154832.GY98604@atomide.com>
 <20180524091742.GZ30172@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180524091742.GZ30172@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Andreas Kemnade <andreas@kemnade.info>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Johan Hovold <johan@kernel.org> [180524 09:20]:
> On Mon, May 21, 2018 at 08:48:32AM -0700, Tony Lindgren wrote:
> > 
> > Yes the bug for closed ports needs to be fixed for sure.
> 
> I did some forensic on this and it seems this problem has "always" been
> there. Specifically, closed ports have never been runtime suspended
> unless a non-negative autosuspend delay has been set by user space since
> fcdca75728ac ("ARM: OMAP2+: UART: Add runtime pm support for omap-serial
> driver") which was merged seven years ago.
>
> So while it would certainly be nice to save some more power by default,
> this would really be a new feature rather than a bug or regression fix
> (which reduces the urgency for this issue somewhat too).

Yes it's been there since the start.

> > > > > 	2. aggressive serial RPM, where the controller is allowed to
> > > > > 	   suspend while the port is open even though this may result in
> > > > > 	   lost characters when waking up on incoming data
> > > > 
> > > > In this case it seems that the only thing needed is to just
> > > > configure the autosuspend delay for the parent port. The use of
> > > > -1 has been around since the start of runtime PM AFAIK, so maybe
> > > > we should just document it. I guess we could also introduce
> > > > pm_runtime_block_autoidle_unless_configured() :)
> > > 
> > > The implications of a negative autosuspend delay are already documented
> > > (in Documentation/power/runtime_pm.txt); it's just the omap drivers that
> > > gets it wrong when trying to do things which aren't currently supported
> > > (and never have been).
> > > 
> > > So I still think we need a new mechanism for this.
> > 
> > Well if you have some better mechanism in mind let's try it out. Short of
> > sprinkling pm_runtime_force_suspend/resume calls all over, I'm out of ideas
> > right now.
> 
> Yeah, that would be too much of a hack and likely wouldn't work either
> (and we really should do away with those _force calls altogether).
> 
> I've been thinking a bit too much about this already, but it may be
> possible to use the pm QoS framework for this. A resume latency can be
> set through sysfs where "n/a" is defined to mean "no latency accepted"
> (i.e. controller remains always-on while port is open) and "0" means
> "any latency accepted" (i.e. omap aggressive serial RPM is allowed).

Oh yeah, PM QoS might work here!

> Now, implementing this may get a little tricky as we want to be able to
> change this setting on the fly (consider consoles) and we need to figure
> out the interaction with serdev (user space should probably not be
> allowed to request a resume latency for ports used by serdev).

It sounds like Andy Shevchenko has a series of patches that just might
allow us to make this all generic for Linux serial framework. So adding
Andy to Cc, I don't think he has posted all the patches yet.

Andy, see the PM QoS comment above for console idling :)

> I'd be happy to dig into this some more, but not in my spare time I'm
> afraid.

Indeed.

> > > > > For normal ttys, we need a user-space interface for selecting between
> > > > > the two, and for serdev we may want a way to select the RPM scheme from
> > > > > within the kernel.
> > > > > 
> > > > > Note that with my serdev controller runtime PM patch, serdev core could
> > > > > always opt for aggressive PM (as by default serdev core holds an RPM
> > > > > reference for the controller while the port is open).
> > > > 
> > > > So if your serdev controller was to set the parent autosuspend
> > > > delay on open() and set it back on close() this should work?
> > > 
> > > Is it really the job of a serdev driver to set the autosuspend delay of
> > > a parent controller? Isn't this somethings which depends on the
> > > characteristics of the controller (possibly configurable by user space)
> > > such as the cost of runtime suspending and resuming?
> > 
> > Only in some cases will the serdev driver know it's safe to configure
> > the parent controller. Configuring the parent controller from userspace
> > works just fine as we've seen for years now.
> 
> Yes, user space may override the default settings provided by the serial
> driver, but a serdev driver, in contrast, knows nothing about the
> underlying serial hardware.
> 
> > > The patch I posted works with what we have today; if a parent serial
> > > controller driver uses aggressive runtime PM by default or after having
> > > been configured through sysfs to do so.
> > 
> > Yeah let's stick with configuring the parent controller from userspace
> > for now at least.
> 
> Yep, status quo works for the time being (since this isn't a
> regression). 
> 
> > > What I'm getting at here is that the delay should be set by the serial
> > > driver implementing aggressive runtime PM. Then all we need is a
> > > mechanism to determine whether an extra RPM reference should be taken at
> > > tty open or not (configurable by user space, defaulting to yes).
> > 
> > OK yeah some additional on/off switch seems to be missing here.
> 
> As mentioned above, PM QoS resume latency may possibly be used, and
> otherwise me may able to define a new (generic) QoS flag for this.

Good idea.

> > > Specifically, the serial drivers themselves would always use
> > > autosuspend and not have to deal with supporting the two RPM schemes
> > > (normal vs aggressive runtime PM).
> > 
> > OK. So if I understand your idea right, we could have autosuspend timeout
> > set to 3000ms in the 8250_omap.c but still default to RPM blocked?
> > Then user can enable aggressive PM via /sys as desired, right?
> 
> Not RPM blocked; the ports must always be able to suspend when the port
> is closed. But user space should be able to enable the aggressive
> (active) runtime PM via sysfs independently of the autosuspend delay,
> yes.

Yup OK, I like the PM QoS approach.

Regards,

Tony
