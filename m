From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP serial runtime PM and autosuspend (was: Re: [PATCH 4/7]
 dt-bindings: gnss: add u-blox binding))
Date: Thu, 17 May 2018 10:10:38 -0700
Message-ID: <20180517171038.GL98604@atomide.com>
References: <20180507163439.GV2285@localhost>
 <20180507175032.GR98604@atomide.com>
 <20180508065852.GW2285@localhost>
 <20180508152228.GV98604@atomide.com>
 <20180508154756.GW98604@atomide.com>
 <20180508155405.GX98604@atomide.com>
 <20180508164904.GZ98604@atomide.com>
 <20180509131003.GC2285@localhost>
 <20180509135706.GB98604@atomide.com>
 <20180517100948.GI30172@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180517100948.GI30172@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Andreas Kemnade <andreas@kemnade.info>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Johan Hovold <johan@kernel.org> [180517 10:12]:
> [ Sorry about the late reply. ]
> 
> On Wed, May 09, 2018 at 06:57:06AM -0700, Tony Lindgren wrote:
> > * Johan Hovold <johan@kernel.org> [180509 13:12]:
> 
> > > It seems we really should not be using the negative autosuspend to
> > > configure the RPM behaviour the way these drivers do. Perhaps a new
> > > mechanism is needed.
> > 
> > Hmm well simply defaulting to "on" instead of "auto" and setting the
> > autosuspend_ms to 3000 by default might be doable. I think that way
> > we can keep use_autosuspend() in probe. Let's hope there are no
> > existing use cases that would break with that.
> 
> No, defaulting to "on" (i.e. calling pm_runtime_forbid()) wouldn't work
> either as that would also prevent the device from runtime suspending
> just as the current negative autosuspend delay does.

Well in that case we should just stick with -1 value for the
autosuspend. And just do pm_runtime_put_sync_suspend() after
probe and on close.

> I fail to see how we can implement this using the current toolbox. What
> you're after here is really a mechanism for selecting between two
> different runtime PM schemes at runtime:
> 
> 	1. normal serial RPM, where the controller is active while the
> 	   port is open (this should be the safe default)

Agreed. And that is the case already.

> 	2. aggressive serial RPM, where the controller is allowed to
> 	   suspend while the port is open even though this may result in
> 	   lost characters when waking up on incoming data

In this case it seems that the only thing needed is to just
configure the autosuspend delay for the parent port. The use of
-1 has been around since the start of runtime PM AFAIK, so maybe
we should just document it. I guess we could also introduce
pm_runtime_block_autoidle_unless_configured() :)

> For normal ttys, we need a user-space interface for selecting between
> the two, and for serdev we may want a way to select the RPM scheme from
> within the kernel.
> 
> Note that with my serdev controller runtime PM patch, serdev core could
> always opt for aggressive PM (as by default serdev core holds an RPM
> reference for the controller while the port is open).

So if your serdev controller was to set the parent autosuspend
delay on open() and set it back on close() this should work?

Regards,

Tony
