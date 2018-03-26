From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Sun, 25 Mar 2018 17:22:59 -0700
Message-ID: <20180326002259.GE5700@atomide.com>
References: <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
 <20180324142517.GA94954@atomide.com>
 <20180324200224.GA17857@amd>
 <20180325154512.GC5700@atomide.com>
 <20180325185857.GA7582@amd>
 <20180325205232.GD5700@atomide.com>
 <20180325225556.GA18141@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180325225556.GA18141@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dan Williams <dcbw@redhat.com>, Sebastian Reichel <sre@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180325 22:57]:
> Hi!
> 
> > > > > Hmm. Interesting. Anyway, for me ttyUSB4 is interesting, as it seems
> > > > > to react to AT commands, and in particular reacts to ADT123; (; is
> > > > > important).
> > > > 
> > > > Is that to dial a voice call?
> > > 
> > > Yes. And it is ATD123; not ATD.
> > 
> > Strange, no semicolon is needed when using /dev/gsmtty to
> > dial a voice call with my current pile of pending changes,
> > just doing ATD123 dials..
> 
> Interesting. Maybe I made some mistake in experiment.

Looks like on /dev/ttyUSB4 doing AT+COPS? or AT+CREG? won't work
while on /dev/gsmtty1 they work. So /dev/ttyUSB4 seems to a subset of
what's available over n_gsm on ch1. Anyways, good to hear that
/dev/ttyUSB4 can be used to debug voice calls :)

> Thanks for hints, it would not be bad to get gps working. But .. voice
> calls. Those are important :-).

Yup, please keep us posted :) Meanwhile, I'll slowly continue
getting the n_gsm stuff working.

Tony
