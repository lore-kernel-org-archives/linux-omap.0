From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/13] 64-bit sched_clock
Date: Thu, 16 Dec 2010 13:04:11 +0000
Message-ID: <20101216130411.GR9937@n2100.arm.linux.org.uk>
References: <20101216092527.GL9937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47665 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab0LPNE1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 08:04:27 -0500
Content-Disposition: inline
In-Reply-To: <20101216092527.GL9937@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>, linux-omap@vger.kernel.org, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, john stultz <johnstul@us.ibm.com>, Krzysztof Halasa <khc@pm.waw.pl>, Olof Johansson <olof@lixom.net>, Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Lennert Buytenhek <kernel@wantstofly.org>, Alessandro Rubini <rubini@unipv.it>

There is one issue which remains with this code - that is the
initialization ordering.

init/main.c:

	setup_arch(&command_line);
	...
	sched_init();
	...
	early_irq_init();
	init_IRQ();
	...
	timekeeping_init();
	time_init();

sched_init() calls init_idle() which calls sched_clock() to set the
start time for the idle thread.  However, our sched_clock() is not
initialized (in general) until init/main.c calls time_init().

This results in a big step in the sched_clock() return value during
boot, which is probably not desirable.  At the moment, I work around
this by explicitly setting the epoch_ns to zero after the first update
callback - but this means that sched_clock() will only start at this
point, which may not be desirable for everyone.

Some sched_clock() implementations rely upon clocksource code (they
use the clocksource read function) and this is only initialized when
the clocksource is registered.  There's also the matter of the clock
rate.

It's probably not a good idea to register clocksources before
timekeeping_init() has happened either.

I can provide an init_early() method in the machine description which
setup_arch() can call as the last thing it does - this will happen
after the ->reserve and ->map_io callbacks, but before interrupts and
timers have been setup.  This is the ideal time to setup the
sched_clock().  However, that means digging through lots of arch code
to sort out what can be moved where, and that's going to be inherently
unreliable.

I think init_early() has merit in other ways - it'll allow us to remove
crap from the ->map_io callbacks which is doing stuff like registering
clk structures and so forth.

Any other suggestions?
