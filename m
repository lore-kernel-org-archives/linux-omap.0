From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/5] watchdog: cleanup a bit omap_wdt.c
Date: Sun, 21 Sep 2008 19:01:18 -0700
Message-ID: <200809211901.19080.david-b@pacbell.net>
References: <1221820359-8943-1-git-send-email-felipe.balbi@nokia.com> <20080920180018.GD9873@flint.arm.linux.org.uk> <20080921184058.GC7961@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:41391 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752876AbYIVCBW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Sep 2008 22:01:22 -0400
In-Reply-To: <20080921184058.GC7961@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <felipe.balbi@nokia.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, Andrew Morton <akpm@linux-foundation.org>, "George G. Davis" <gdavis@mvista.com>

On Sunday 21 September 2008, Tony Lindgren wrote:
> Hey, you gotta give Dave some credit! Dave's been polishing tons of omap
> code in addition to the USB, at least I2C, gpio, SPI come to mind. Not to
> mention all the blinking leds!

Blinky leds can be the first visible sign of progress!  ;)


> Regarding getting an army of people to fix code, we need to start
> following another standard policy: All drivers must have a MAINTAINER
> who is capable of fixing things, and ideally doing things the right
> way from the start.

Which includes pushing their code into mainline ... and getting
acks (as you noted elsewhere) from the subsystem maintainer to
help avoid going too far astray.

In some cases that implies getting some new frameworks into mainline,
or updating the ones that are there.  The ALSA-SOC stuff has been
a win there, in terms of maintainable code ... the previous solution
involved very little reuse of the funky codec and data stream code,
while now that's far more practical.

Similarly I2C driver model support, GPIO expander infrastructure,
and SPI:  instead of scattering board-specific code in drivers all
over the source tree, it can now be split out fairly cleanly.  That
makes maintainers much happier.

- Dave
