From: Johan Hovold <johan@kernel.org>
Subject: Re: OMAP serial runtime PM and autosuspend (was: Re: [PATCH 4/7]
 dt-bindings: gnss: add u-blox binding))
Date: Fri, 25 May 2018 16:02:13 +0200
Message-ID: <20180525140213.GI30172@localhost>
References: <20180508155405.GX98604@atomide.com>
 <20180508164904.GZ98604@atomide.com>
 <20180509131003.GC2285@localhost>
 <20180509135706.GB98604@atomide.com>
 <20180517100948.GI30172@localhost>
 <20180517171038.GL98604@atomide.com>
 <20180521134830.GR30172@localhost>
 <20180521154832.GY98604@atomide.com>
 <20180524091742.GZ30172@localhost>
 <20180524133237.GA98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180524133237.GA98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Johan Hovold <johan@kernel.org>, Sebastian Reichel <sre@kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Andreas Kemnade <andreas@kemnade.info>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Thu, May 24, 2018 at 06:32:37AM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [180524 09:20]:
> > On Mon, May 21, 2018 at 08:48:32AM -0700, Tony Lindgren wrote:

> > > Well if you have some better mechanism in mind let's try it out. Short of
> > > sprinkling pm_runtime_force_suspend/resume calls all over, I'm out of ideas
> > > right now.
> > 
> > Yeah, that would be too much of a hack and likely wouldn't work either
> > (and we really should do away with those _force calls altogether).
> > 
> > I've been thinking a bit too much about this already, but it may be
> > possible to use the pm QoS framework for this. A resume latency can be
> > set through sysfs where "n/a" is defined to mean "no latency accepted"
> > (i.e. controller remains always-on while port is open) and "0" means
> > "any latency accepted" (i.e. omap aggressive serial RPM is allowed).
> 
> Oh yeah, PM QoS might work here!

Actually, after reading a recent QoS related bug report, I realised that
a resume latency request of "n/a" is actually a third way of disabling
runtime PM, which similarly to the negative autosuspend would prevent
also a closed port from suspending.

Using a small positive resume latency for this feels like too much of a
hack, but defining a new QoS flag might still work.

Johan
