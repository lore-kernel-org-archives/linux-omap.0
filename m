From: hong zhang <henryzhang62@yahoo.com>
Subject: Re: gpio interrupt is not invoked on Panda board
Date: Mon, 4 Jul 2011 10:20:49 -0700 (PDT)
Message-ID: <1309800049.34840.YahooMailClassic@web161718.mail.bf1.yahoo.com>
References: <CA+HSevoHyVW_j0kiWiKbESt_RsO1jStaAcyuy56grBWETt2_zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm30-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.126]:22391 "HELO
	nm30-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757214Ab1GDR0v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jul 2011 13:26:51 -0400
In-Reply-To: <CA+HSevoHyVW_j0kiWiKbESt_RsO1jStaAcyuy56grBWETt2_zQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: CharulathaVaradarajan <charu@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org

Charulatha, Jon,

I want to write a client GPIO driver to handle IR device connecting to =
GPIO191 or GPIO154.=20

Based on http://omappedia.org/wiki/GPIO, arch/arm/plat-omap/gpio.c is a=
 OMAP core gpio driver, customer can write a client gpio driver on top =
of it to select one GPIO pin such as GPIO191 or GPIO154 as input from I=
R device.

Is there any existing sample codes available for reference?=20

May I say arch/arm/match-omap2/gpio.c is a kind of client driver for pl=
at-omap/gpio.c?

---henry

--- On Mon, 7/4/11, Varadarajan, Charulatha <charu@ti.com> wrote:

> From: Varadarajan, Charulatha <charu@ti.com>
> Subject: Re: gpio interrupt is not invoked on Panda board
> To: "hong zhang" <henryzhang62@yahoo.com>
> Cc: "Jon Hunter" <jon-hunter@ti.com>, linux-omap@vger.kernel.org
> Date: Monday, July 4, 2011, 12:47 AM
> Hong,
>=20
> On Sat, Jul 2, 2011 at 04:45, hong zhang <henryzhang62@yahoo.com>
> wrote:
> > --- On Fri, 7/1/11, Jon Hunter <jon-hunter@ti.com>
> wrote:
> >
> >> From: Jon Hunter <jon-hunter@ti.com>
> >> Subject: Re: gpio interrupt is not invoked on
> Panda board
> >> To: "hong zhang" <henryzhang62@yahoo.com>
> >> Cc: linux-omap@vger.kernel.org
> >> Date: Friday, July 1, 2011, 4:17 PM
> >> Hi Henry
> >>
> >> On 7/1/2011 1:10 PM, hong zhang wrote:
> >> > List,
> >> >
> >> > I try to get gpio_191 ping interrupted on
> panda but
> >> never succeeded. What I do is
> >> >
> >> > 1. set 0x410b on dpm_emu19 register to
> enable
> >> interrupt and wakeup
> >> >=A0 =A0=A0=A0on gpio_191
> >> > 2. set bit 31 to 1 on GPIO_IRQSTATUS_SET_0
> register at
> >> 0x4805d034
> >> > 3. set bit 31 to 1 on GPIO_IRQWAKEN_0
> register at
> >> 0x4805d044
> >> > 4. set bit 31 to 0 on GPIO_OE register at
> 0x4805d134
> >> (output)
> >> > 5. set bit 31 to 1 on GPIO_SETDATAOUT
> register at
> >> 0x4805d194
> >> >
> >> > Then I expect I should see interrupt on
> >> GPIO_IRQSTATUS_0 register at 0x4805d02c. But
> nothing happens
> >> for both output and input (put pin on ground or
> 1,8v).
> >>
> >> You will not get an interrupt if you are
> configuring the
> >> gpio as an
> >> output (GPIO_OE[31] =3D 0).
> >>
> > =A0Jon
> >
> > GPIO_OE[31]=3D0 means output. I should get interrupt for
> output.
>=20
> Wrong. As Jon mentioned, no interrupt if the gpio is an
> output.
>=20
> > GPIO_OE[31]=3D1 means input, but I do not get interrupt
> too.
>=20
> You would be able see the interrupt only if the GPIO191's
> state
> is set/reset by the external peripheral /device which is
> connected
> to GPIO191.
>=20
> Refer TRM for more details.
>=20
> -V Charulatha
>=20
> >
> > Do I miss anything here?
> > --
> > To unsubscribe from this list: send the line
> "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
