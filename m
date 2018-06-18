From: Tony Lindgren <tony@atomide.com>
Subject: Re: Charge counter on droid 4
Date: Sun, 17 Jun 2018 23:58:27 -0700
Message-ID: <20180618065827.GN112168@atomide.com>
References: <20180615080014.GA29192@amd>
 <20180615083156.GA32102@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180615083156.GA32102@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180615 08:34]:
> On Fri 2018-06-15 10:00:14, Pavel Machek wrote:
> > Hi!
> > 
> > Droid 4 has non-removable battery, yet the charge counter is reset to
> > near zero on each boot of linux.

Not sure if we actively do anything to reset it. I'm guessing
it's the Motorola bootloader that resets everything on boot.

> > Unfortunately, that makes charge counter pretty much useless on d4, as
> > the "battery full" and "battery empty" limits will be different during
> > each boot.

>From what I've seen also the stock kernel starts only with
voltage based estimate initially after a reboot?

> Hmm, and could we refrain from providing "power" values?
> 
> I was thinking great, we have hardware that does proper power
> measuerement for us. No.... it is driver providing synthetic
> values. As userland has enough information to do that itself, I
> believe we should not do this in kernel.

Hmm I don't follow you, why would we want to remove these as
they implement a standard sysfs interface?

I use the sysfs interface all the time to monitor the power
consumption and the output seems to match what I was seeing
with my power supply.

Note that we also have the IIO raw data also available if that
might help.

Regards,

Tony
