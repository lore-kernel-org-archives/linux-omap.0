From: Paul Walmsley <paul@pwsan.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Mon, 30 Jan 2012 18:48:29 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201301835430.10061@utopia.booyaka.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com> <87obtlrniz.fsf@ti.com> <CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com> <87obtkpyna.fsf@ti.com> <alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
 <CANOLnOM5VYOQOngF-T=5-CM-J2JzXVEnSaYbDjTQ8P=z9XSSAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-523857793-1327973833=:10061"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39216 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab2AaBsa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 20:48:30 -0500
In-Reply-To: <CANOLnOM5VYOQOngF-T=5-CM-J2JzXVEnSaYbDjTQ8P=z9XSSAw@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1201301837380.10061@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-523857793-1327973833=:10061
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1201301837381.10061@utopia.booyaka.com>

Hi Gra=B8vydas

On Tue, 31 Jan 2012, Grazvydas Ignotas wrote:

> On Tue, Jan 31, 2012 at 1:34 AM, Paul Walmsley <paul@pwsan.com> wrote:
>=20
> > So apparently, looking at these references, the following registers sho=
uld
> > be configured:
> >
> > 1. at least one of GPIO_LEVELDETECT{0,1} or GPIO_{RISING,FALLING}DETECT
> >
> > 2. GPIO_WAKEUPENABLE
> >
> > 3. GPIO_IRQENABLE1
>=20
> According to some /dev/mem hacking, all these have corresponding bits=20
> set.. And as soon as I clear corresponding bit in GPIO_DEBOUNCENABLE=20
> (using the same /dev/mem hacking method), it starts working. When it's=20
> set, even GPIO_DATAIN isn't updating in realtime.

Hmm so I may have misunderstood the problem...=20

If the DEBOUNCENABLE bit is set and the debounce clock is off and the GPIO=
=20
IP block is idle, then yeah, I'd assume that GPIO wakeups would not=20
work.

But it sounds like they are working for you when DEBOUNCENABLE is set and=
=20
the debounce clock is on and the GPIO IP block is idle and CORE & PER are=
=20
ON?

And when DEBOUNCENABLE is clear and the debounce clock is off and the GPIO=
=20
IP block is idle and CORE & PER are still ON, then they work?

If the answer to those two latter questions are true, then it sounds like=
=20
the hardware is working more or less as expected...

Of course our software support probably still isn't right.  We probably=20
should keep the debounce clock enabled as long as some GPIO has debounce=20
support enabled.  And probably provide some way for GPIO users to indicate=
=20
whether they are okay with debounce support being disabled when the=20
rest of the CORE/PER can enter a low-power state.  The motivating=20
principle being that PM shouldn't violate a requirement from the rest of=20
the system...

Anyway, just thinking out loud.


- Paul
--155748971-523857793-1327973833=:10061--
