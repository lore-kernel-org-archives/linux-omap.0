From: Johan Hovold <johan@kernel.org>
Subject: Re: OMAP serial runtime PM and autosuspend (was: Re: [PATCH 4/7]
 dt-bindings: gnss: add u-blox binding))
Date: Thu, 17 May 2018 12:09:48 +0200
Message-ID: <20180517100948.GI30172@localhost>
References: <20180507154515.GP98604@atomide.com>
 <20180507163439.GV2285@localhost>
 <20180507175032.GR98604@atomide.com>
 <20180508065852.GW2285@localhost>
 <20180508152228.GV98604@atomide.com>
 <20180508154756.GW98604@atomide.com>
 <20180508155405.GX98604@atomide.com>
 <20180508164904.GZ98604@atomide.com>
 <20180509131003.GC2285@localhost>
 <20180509135706.GB98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180509135706.GB98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Johan Hovold <johan@kernel.org>, Sebastian Reichel <sre@kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Andreas Kemnade <andreas@kemnade.info>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

[ Sorry about the late reply. ]

On Wed, May 09, 2018 at 06:57:06AM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [180509 13:12]:

> > It seems we really should not be using the negative autosuspend to
> > configure the RPM behaviour the way these drivers do. Perhaps a new
> > mechanism is needed.
> 
> Hmm well simply defaulting to "on" instead of "auto" and setting the
> autosuspend_ms to 3000 by default might be doable. I think that way
> we can keep use_autosuspend() in probe. Let's hope there are no
> existing use cases that would break with that.

No, defaulting to "on" (i.e. calling pm_runtime_forbid()) wouldn't work
either as that would also prevent the device from runtime suspending
just as the current negative autosuspend delay does.

I fail to see how we can implement this using the current toolbox. What
you're after here is really a mechanism for selecting between two
different runtime PM schemes at runtime:

	1. normal serial RPM, where the controller is active while the
	   port is open (this should be the safe default)

	2. aggressive serial RPM, where the controller is allowed to
	   suspend while the port is open even though this may result in
	   lost characters when waking up on incoming data

For normal ttys, we need a user-space interface for selecting between
the two, and for serdev we may want a way to select the RPM scheme from
within the kernel.

Note that with my serdev controller runtime PM patch, serdev core could
always opt for aggressive PM (as by default serdev core holds an RPM
reference for the controller while the port is open).

Thanks,
Johan
