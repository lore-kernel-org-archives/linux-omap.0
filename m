From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 0/13] 64-bit sched_clock
Date: Sun, 19 Dec 2010 23:23:02 +0100
Message-ID: <AANLkTik0zkpUUvrv8YmxGd_=vMaKR42KbJnd4BqHqias@mail.gmail.com>
References: <20101216092527.GL9937@n2100.arm.linux.org.uk>
	<20101216130411.GR9937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:59953 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757231Ab0LSWXE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Dec 2010 17:23:04 -0500
In-Reply-To: <20101216130411.GR9937@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Alessandro Rubini <rubini@unipv.it>, Imre Kaloz <kaloz@openwrt.org>, Eric Miao <eric.y.miao@gmail.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, john stultz <johnstul@us.ibm.com>, linux-tegra@vger.kernel.org, Olof Johansson <olof@lixom.net>, Colin Cross <ccross@android.com>, STEricsson <STEricsson_nomadik_linux@list.st.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Lennert Buytenhek <kernel@wantstofly.org>, Krzysztof Halasa <khc@pm.waw.pl>

2010/12/16 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> I can provide an init_early() method in the machine description which
> setup_arch() can call as the last thing it does - this will happen
> after the ->reserve and ->map_io callbacks, but before interrupts and
> timers have been setup. =A0This is the ideal time to setup the
> sched_clock(). =A0However, that means digging through lots of arch co=
de
> to sort out what can be moved where, and that's going to be inherentl=
y
> unreliable.
>
> I think init_early() has merit in other ways - it'll allow us to remo=
ve
> crap from the ->map_io callbacks which is doing stuff like registerin=
g
> clk structures and so forth.

I agree. I was contemplating a clock_init() or similar a way back
for setting up clock trees early. We would have to move clock tree
registration in front of the init_sched_clock() call in the init_early(=
)
handler in many cases since the rate often comes from the clock
framework, but this is indeed where it belongs.

So a clear ACK for this approach.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
