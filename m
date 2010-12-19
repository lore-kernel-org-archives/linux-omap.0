From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/13] 64-bit sched_clock
Date: Sun, 19 Dec 2010 23:39:10 +0000
Message-ID: <20101219233910.GA816@n2100.arm.linux.org.uk>
References: <20101216092527.GL9937@n2100.arm.linux.org.uk> <20101216130411.GR9937@n2100.arm.linux.org.uk> <AANLkTik0zkpUUvrv8YmxGd_=vMaKR42KbJnd4BqHqias@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57430 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932537Ab0LSXkA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Dec 2010 18:40:00 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTik0zkpUUvrv8YmxGd_=vMaKR42KbJnd4BqHqias@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Alessandro Rubini <rubini@unipv.it>, Imre Kaloz <kaloz@openwrt.org>, Eric Miao <eric.y.miao@gmail.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, john stultz <johnstul@us.ibm.com>, linux-tegra@vger.kernel.org, Olof Johansson <olof@lixom.net>, Colin Cross <ccross@android.com>, STEricsson <STEricsson_nomadik_linux@list.st.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Lennert Buytenhek <kernel@wantstofly.org>, Krzysztof Halasa <khc@pm.waw.pl>

On Sun, Dec 19, 2010 at 11:23:02PM +0100, Linus Walleij wrote:
> 2010/12/16 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>=20
> > I can provide an init_early() method in the machine description whi=
ch
> > setup_arch() can call as the last thing it does - this will happen
> > after the ->reserve and ->map_io callbacks, but before interrupts a=
nd
> > timers have been setup. =A0This is the ideal time to setup the
> > sched_clock(). =A0However, that means digging through lots of arch =
code
> > to sort out what can be moved where, and that's going to be inheren=
tly
> > unreliable.
> >
> > I think init_early() has merit in other ways - it'll allow us to re=
move
> > crap from the ->map_io callbacks which is doing stuff like register=
ing
> > clk structures and so forth.
>=20
> I agree. I was contemplating a clock_init() or similar a way back
> for setting up clock trees early. We would have to move clock tree
> registration in front of the init_sched_clock() call in the init_earl=
y()
> handler in many cases since the rate often comes from the clock
> framework, but this is indeed where it belongs.

Yes, that was indeed one of the subsystems that I thought platforms
should initialize there - one of my motivations is in connection with
6433/1 and 6434/1.

If we have everyone setting up their clock subsystems in init_early,
then we can have both the TWD and SP804 always getting their clock
rates from the clk API, rather than having the conditional approach
in those two patches.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
