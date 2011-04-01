From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Fri, 1 Apr 2011 23:00:36 +0200
Message-ID: <20110401210036.GB30938@pengutronix.de>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
 <201104011659.40443.arnd@arndb.de>
 <4D95EF8E.9080902@vollmann.ch>
 <201104011750.17344.arnd@arndb.de>
 <alpine.LFD.2.00.1104011441150.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51753 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756838Ab1DAVB3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 17:01:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1104011441150.28032@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Arnd Bergmann <arnd@arndb.de>, david@lang.hm, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, David Brown <davidb@codeaurora.org>, Detlef Vollmann <dv@vollmann.ch>, Bill Gatliff <bgat@billgatliff.com>, Arun Murthy <arun.murthy@stericsson.com>

Hello,

On Fri, Apr 01, 2011 at 03:54:47PM -0400, Nicolas Pitre wrote:
> It would be more useful and scalable to simply sit down, look at the=20
> current mess, and identify common patterns that can be easily factore=
d=20
> out into some shared library code, and all that would be left in the=20
> board or SOC specific files eventually is the data to register with t=
hat=20
> library code.  Nothing so complicated as grand plans or planification=
=20
> that makes it look like a mountain.
>=20
> Two patterns were identified so far, and they are:
>=20
> 1) GPIO drivers
>=20
>    As Linus observed, in the majority of the cases GPIOs are accessed=
=20
>    through simple memory-mapped registers.  Some have absolute state=20
>    registers, the others have separate clear/set registers.  Suffice =
to=20
>    create two generic GPIO drivers each covering those two common cas=
es,=20
>    and those generic drivers would simply register with the higher le=
vel=20
>    gpiolib code, and all the board code would have to do is to provid=
e=20
>    the data for those GPIOs (register offsets, number of GPIOs, etc.)=
=2E =20
>    Whether this data eventually comes from DT is an orthogonal issue.
>=20
> 2) IRQ chip drivers
>=20
>    Again, as Thomas observed, the same issue exists with the majority=
 of=20
>    the IRQ chip drivers.  Most of them follow a common simple pattern=
=20
>    that can be abstracted in some generic library code due to their v=
ery=20
>    similar mode of operation.  Writing a common driver would leave th=
e=20
>    board specific code with only a data table describing hardware=20
>    registers.
>=20
> A good example of such rationalization that already happened is the=20
> leds-gpio driver (./drivers/leds/leds-gpio.c), or similarly the=20
> gpio-keys driver (drivers/input/keyboard/gpio_keys.c).  I remember wh=
en=20
> those board files were implementing their own simple drivers hooking=20
> directly to the input API or the LED API.
>=20
> After that let's take another identified common pattern and factorize=
 it=20
> out from board code.  That might be timers (see RMK's recent=20
> sched_clock() rationalization).  That might be clocks (patches from=20
> Jeremy Kerr exist and need merged). Etc.
Another one is pwm (git ls-files arch/arm | grep pwm). A general
pwm framework was already discussed on lkml and linux-embedded
(http://thread.gmane.org/gmane.linux.ports.mips.general/29037/focus=3D4=
4475);
I don't know the details though.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
