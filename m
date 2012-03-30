From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: Suspend broken on 3.3?
Date: Fri, 30 Mar 2012 08:53:39 +0100
Message-ID: <WC20120330075339.4017FC@terrafix.co.uk>
References: <CAMrsUdKXZL4nT0MW=BcD53PsQFE+W1inij3XWe0e5+BjJF3odg@mail.gmail.com> <WC20120328153855.621724@terrafix.co.uk> <87vcloipow.fsf@ti.com> <WC20120329083556.20174D@terrafix.co.uk> <alpine.DEB.2.00.1203290356190.2788@utopia.booyaka.com> <WC20120329112755.541787@terrafix.co.uk> <WC20120329114024.43178C@terrafix.co.uk> <CAMrsUdKR4nwbBEOx9JPeS=GLDPyioHuijK2596=q2OwJ+ARbxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:48362 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758920Ab2C3Hx7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 03:53:59 -0400
In-Reply-To: <CAMrsUdKR4nwbBEOx9JPeS=GLDPyioHuijK2596=q2OwJ+ARbxA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de

-----Original Message-----
=46rom: "Raja, Govindraj" <govindraj.raja@ti.com>
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, linu=
x-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de
Date: Thu, 29 Mar 2012 19:59:54 +0530
Subject: Re: Suspend broken on 3.3?

> On Thu, Mar 29, 2012 at 5:10 PM, Joe Woodward <jw@terrafix.co.uk>
> wrote:
> >
> >
> > -----Original Message-----
> > From: "Joe Woodward" <jw@terrafix.co.uk>
> > To: "Paul Walmsley" <paul@pwsan.com>
> > Cc: "Kevin Hilman" <khilman@ti.com>, "Raja\\, Govindraj"
> <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, "Felipe Balbi"
> <balbi@ti.com>, neilb@suse.de
> > Date: Thu, 29 Mar 2012 12:27:55 +0100
> > Subject: Re: Suspend broken on 3.3?
> >
> >> > Hello Joe,
> >> >
> >> > thanks for reporting this. =A0Some thoughts -- really just pure
> >> > speculation
> >> > -- but I hope some of it might be useful for you...
> >> >
> >> > On Thu, 29 Mar 2012, Joe Woodward wrote:
> >> >
> >> > > After digging a bit further I found that the problem isn't los=
t
> >> > characters or character corruption at all...
> >> > >
> >> > > The UART is actually at 430KBaud (not 900KBaud as I mentioned
> >> > earlier).
> >> >
> >> > 430Kbps? =A0Could you confirm this? =A0OMAP UARTs don't support =
that
> rate
> >> > as
> >> > far as I know - the closest is 460Kbps (OMAP34xx TRM vZR Table
> 17-1
> >> > "UART
> >> > Mode Baud Rates, Divisor Values, and Error Rates). =A0If one was
> >> > desperate,
> >> > it might be possible to get 430Kbps by tweaking other parts of t=
he
> >> > clock
> >> > tree though...
> >>
> >> Sorry for the confusion... It's 460KBaud - the 430 was just a typo
> in
> >> my previous mail...
> >>
> >> >
> >> > > The data received is very bursty (i.e. sets of messages every
> >> second
> >> > or
> >> > > so), containing a sync sequence to indicate a start of packet.
> >> > >
> >> > > The received bytes should be: 0x01, 0x52, 0x41 ....rest of
> packet.
> >> > >
> >> > > This works 100% of the time on 3.2, but on 3.3 I sometimes (bu=
t
> not
> >> > always) get: 0x01, 0x00, 0x52, 0x41.
> >> > >
> >> > > i.e. there is a NULL/0x00 inserted after the first character.
> >> >
> >> > Is this on the serial console, or on a non-console serial port?
> >> >
> >> > Looking at drivers/tty/serial/omap-serial.c:receive_chars(), I
> wonder
> >> > if
> >> > the driver is somehow reading bytes from the RX FIFO when it's
> empty.
> >>
> >> > It's unclear to me how this could happen. =A0But you might want =
to
> try
> >> > doing
> >> > an LSR read right before entering the loop in
> >> > drivers/tty/serial/omap-serial.c:receive_chars(). =A0In stock v3=
=2E3,
> >> this
> >> > would mean adding
> >> >
> >> > =A0 =A0 =A0 =A0 =A0 =A0 lsr =3D serial_in(up, UART_LSR);
> >> >
> >> > at line 190 of drivers/tty/serial/omap-serial.c.
> >> >
> >>
> >> Adding this is made no obvious difference.
> >>
> >> >
> >> > You might also try the DMA path as an experiment. =A0This will
> totally
> >> > wedge
> >> > power management due to an insanely low timer expiration in that
> >> path,
> >> > but
> >> > at least might help narrow the problem down. =A0To do so with a
> quick
> >> > hack,
> >> > you could set omap_serial_default_info.dma_enabled to true inste=
ad
> of
> >> > false at arch/arm/mach-omap2/serial.c:76.
> >> >
> >>
> >> This did the trick (I've added it in addition to the LSR read abov=
e,
> >> i'll back out the LSR read and see if it still works).
> >> When DMA is enabled the behaviour (as seen from my application in
> >> userspace) is the same as on the stock 3.2 kernel (i.e. for me it
> works
> >> :) ).
> >>
> >
> > I've just realised that if anyone has joined this thread late, then
> I'm running in a state with Govindraj's patch in a previous mail in
> this thread applied to serial.c to
> > fix the suspend issues due to the UART wakeup's not being correctly
> changed from userspace via sysfs.
> >
> > It may actually by this patch that is causing the interrupt-enabled
> serial driver to have broken? The tty that is causing me a problem do=
es
> have wake-from-suspend
> > disabled for it from userspace...
>=20
> Is the patch shared earlier causing this issue of getting 0x00 from r=
x
> randomly ?
>=20

In short, yes.

I've gone back to a stock 3.3 kernel and the serial ports give the corr=
ect data, but suspend fails (due to not being able to disable wake-from=
-serial).

I then applied your patch and could disable wakeup on the serial ports =
and suspend correctly, but the (non-console) serial port starts to misb=
ehave.

=46orcing the driver to be DMA-enabled caused everything to work again.=
 So something in the patch is causing the (default) interrupt-enabled s=
erial driver to=20
occassionally fail.

Sorry for the goose chase yesterday. I didn't even think to check if th=
e patch caused the issue as it seemed a bit unrelated.

Cheers,
Joe


> --
> Thanks,
> Govindraj.R
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
