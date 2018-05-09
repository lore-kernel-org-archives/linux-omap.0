From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP serial runtime PM and autosuspend (was: Re: [PATCH 4/7]
 dt-bindings: gnss: add u-blox binding))
Date: Wed, 9 May 2018 06:57:06 -0700
Message-ID: <20180509135706.GB98604@atomide.com>
References: <20180507100135.GS2285@localhost>
 <20180507154515.GP98604@atomide.com>
 <20180507163439.GV2285@localhost>
 <20180507175032.GR98604@atomide.com>
 <20180508065852.GW2285@localhost>
 <20180508152228.GV98604@atomide.com>
 <20180508154756.GW98604@atomide.com>
 <20180508155405.GX98604@atomide.com>
 <20180508164904.GZ98604@atomide.com>
 <20180509131003.GC2285@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180509131003.GC2285@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Andreas Kemnade <andreas@kemnade.info>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Johan Hovold <johan@kernel.org> [180509 13:12]:
> While this seems to fix the idling of closed ports here too, I'm not
> sure we can move use_autosuspend to startup() like this.
> 
> First, this flag should be set before registering the tty so that udev
> can be used to update the attributes.
> 
> Second, this prevents setting the autosuspend delay through sysfs when
> the port is closed (when autosuspend is disabled).

Yeah I noticed that too yesterday.

> It seems we really should not be using the negative autosuspend to
> configure the RPM behaviour the way these drivers do. Perhaps a new
> mechanism is needed.

Hmm well simply defaulting to "on" instead of "auto" and setting the
autosuspend_ms to 3000 by default might be doable. I think that way
we can keep use_autosuspend() in probe. Let's hope there are no
existing use cases that would break with that.

> But I'm afraid I don't have time to look at this today.

Sure np thanks,

Tony
