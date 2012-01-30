From: Paul Walmsley <paul@pwsan.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Mon, 30 Jan 2012 16:34:12 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com> <87obtlrniz.fsf@ti.com> <CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com> <87obtkpyna.fsf@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1186875345-1327966249=:17726"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53030 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab2A3XeN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 18:34:13 -0500
In-Reply-To: <87obtkpyna.fsf@ti.com>
Content-ID: <alpine.DEB.2.00.1201301630540.17726@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1186875345-1327966249=:17726
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1201301630541.17726@utopia.booyaka.com>

On Mon, 30 Jan 2012, Kevin Hilman wrote:

> Grazvydas Ignotas <notasas@gmail.com> writes:
>=20
> > On Mon, Jan 30, 2012 at 9:36 PM, Kevin Hilman <khilman@ti.com> wrote:
> >> Grazvydas Ignotas <notasas@gmail.com> writes:
> >>
> >>> On 3.2 (I think some earlier versions too), with CONFIG_CPU_IDLE
> >>> enabled GPIO based buttons are not working properly on OMAP3 pandora,
> >>> button presses are almost never registered. The buttons are connected
> >>> GPIO bank4 and have hardware debounce feature enabled.
> >>>
> >>> Doing either of the following solves (or hides) the problem:
> >>> - disabling CPU_IDLE in kernel config
> >>> - disabling debounce for the buttons
> >>> - running a program spinning a loop on the CPU
> >>>
> >>> From what I can see in the code debounce clock is disabled when
> >>> entering idle, can those GPIOs work without debounce clock?
> >>
> >> Yes, the clock is only for the debounce feature, but the GPIOs are
> >> capable of wakeups and interrupts with the debounce clock disabled.
> >
> > Hmm but it doesn't work here (OMAP3530 ES2.1), /proc/interrupts
> > doesn't increase when I hit buttons unless something else is happening
> > at the same time. I wonder if I'm missing something here, does it all
> > work for you with debounce on?=20
>=20
> Yes. =20
>=20
> Specifically, I tested on a n900 which has several GPIOs in the board
> file (board-rx51.c) with debounce enabled.
>=20
> When I push the button (or slide the switch in this case), I see
> /proc/interrupts incrementing on an idle system with CPUidle enabled.
>=20
> The same GPIOs can also bring the system out of suspend (debounce clocks
> are disabled on suspend also.)

That's probably I/O ring/pad wakeups happening there, not GPIO wakeups. =20
Gra=B8vydas, you are referring to the case where the CORE powerdomain is on=
,=20
but the GPIO IP block is idle?

Supposedly when the GPIO blocks enter idle with the debounce clock off,=20
they enter a state that basically links the input pad to the GPIO block's=
=20
SWAKEUP line.  Pure combinational logic, no clocks.  The TRM references,=20
in the 34xx TRM Rev. ZT [SWPU223T], are Figure 25-7 "Asynchronous Path",=20
Figure 25-9 "Wake-Up Request Generation", and Section 25.4.1.2=20
"Asynchronous Path: Wake-Up Request Generation".

So apparently, looking at these references, the following registers should=
=20
be configured:

1. at least one of GPIO_LEVELDETECT{0,1} or GPIO_{RISING,FALLING}DETECT

2. GPIO_WAKEUPENABLE

3. GPIO_IRQENABLE1

It seems highly suspicious to me that nothing in=20
set_24xx_gpio_triggering() in our GPIO code seems to touch the=20
WAKEUPENABLE register.


- Paul
--155748971-1186875345-1327966249=:17726--
