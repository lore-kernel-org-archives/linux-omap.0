From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH/RFC 3/4] of/clk: Register clocks suitable for Runtime PM
 with the PM core
Date: Tue, 29 Apr 2014 14:16:10 +0100
Message-ID: <20140429131610.29859C4094A@trevor.secretlab.ca>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>
	<1398334403-26181-4-git-send-email-geert+renesas@glider.be>
	<7hoazpdldx.fsf@paris.lan>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7hoazpdldx.fsf@paris.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Felipe Balbi <balbi@ti.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, 25 Apr 2014 16:44:58 -0700, Kevin Hilman <khilman@linaro.org> wrote:
> Geert Uytterhoeven <geert+renesas@glider.be> writes:
> 
> > When adding a device from DT, check if its clocks are suitable for Runtime
> > PM, and register them with the PM core.
> > If Runtime PM is disabled, just enable the clock.
> >
> > This allows the PM core to automatically manage gate clocks of devices for
> > Runtime PM.
> 
> ...unless the device is already in an existing pm_domain, right?
> 
> I like this approach, and it extends nicely what we already do on
> platforms using drivers/base/power/clock_ops.c into DT land.
> 
> My only concern is how this will interact if it's used along with
> devices that have existing pm_domains.  I don't have any specific
> concerns (yet, because it's Friday, and my brain is turing off), but it
> just made me wonder if this will be potentially confusing.

I have big concerns about this approach. First, it will only work if
a clock is available at deivce creation time. The conversion of irq
controllers to normal device drivers has already shown that is a bad
idea.

I also don't like that it tries to set up every clock, but there is no
guarantee that the driver will even use it. I would rather see this
behaviour linked into the function that obtains the clock at driver
.probe() time. That way it can handle deferred probe correctly and it
only sets up clocks that are actually used by the driver.

g.
