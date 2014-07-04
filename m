From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH] tty: serial: Add 8250-core based omap driver
Date: Fri, 04 Jul 2014 18:51:00 +0200
Message-ID: <53B6DB74.2050401@linutronix.de>
References: <1404316809-20637-1-git-send-email-bigeasy@linutronix.de> <20140702160932.GF5541@saruman.home> <20140702190944.GA567@drone.musicnaut.iki.fi> <CAOCHtYgxMeA+Arfe40XeFDEKuCJ8qo1RqNR0hYBGr_Wp6sRfdA@mail.gmail.com> <20140703073411.GX28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140703073411.GX28884@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@ti.com>, linux kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 07/03/2014 09:34 AM, Tony Lindgren wrote:
> Heh. Just to summarize the reason ttyO needs to be a separate name
> and device entry from ttyS is because we also have external 8250
> devices on GPMC and hotplug busses.

So the GPMC devices will first get a higher minor/device number. The
internal serial ports should show up first. I don't see the problem
(yet).

If you need a separate major number (and name) like we do have it now
(between ttySx and ttyOx) then one of requirements would be to tell
Kconfig that one driver can be active at a time.

=46or me the ttyS vs ttyO thing is purely cosmetic. I personally don't
like that it is different on different platforms like ttymxc, ttySC,
ttyTHS, =85

I understand that it is easier to have a specific name for it so one
does not need to find out which node is which (but then there is udev
which could create unique device names based on attributes). And then
you need enter this thingy to securetty & inittab.

That said I am easy on it. Whatever the majority here decides to be a
sane solution I will try to make it happen.

>=20
> Regards,
>=20
> Tony
>=20

Sebastian
