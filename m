From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH 10/13] tty: serial: omap: remove some dead code
Date: Thu, 24 Apr 2014 15:19:14 +0100
Message-ID: <20140424151914.6bc6463a@alan.etchedpixels.co.uk>
References: <1398265117-11793-1-git-send-email-balbi@ti.com>
	<1398265117-11793-10-git-send-email-balbi@ti.com>
	<5357DDA8.4040206@ti.com>
	<20140424084305.20c7f301@notabene.brown>
	<20140423230121.GC10924@saruman.home>
	<20140424101329.02e6a62f@notabene.brown>
	<20140424012100.GB13374@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140424012100.GB13374-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> > But I don't have discrete hardware.  I have a bunch of stuff soldered onto a
> > board with ad-hoc connections chosen to make the life of the hardware builder
> > easy rather than chosen to make the life of the software developer easy
> > (which I think is the correct choice).
> > 
> > So I need to tell DT "This device is plugged into this UART, and there is no
> > DTR line, but when the UARTs DTR line would be asserted (if it had one), then
> > I need that regulator of there turned on". or maybe "I need to toggle this
> > GPIO  with exactly this pattern, while watching that GPIO to see if it is
> > working".
> > 
> > So I thought:
> > 
> >  1/ give the UART a "virtual" DTR so it could drive any GPIO
> >  2/ create a "gpio-to-regulator" driver which presented as a (virtual) gpio
> >     and responded to state changes on that GPIO by turning on or off the
> >     regulator
> >  3/ create a dedicated driver which knows how to toggle the magic GPIO while
> >     watching the other GPIO to convince the silly device to wakeup, or go to
> >     sleep, as required, and have this appear as a (virtual) GPIO.

Unless you are using it as a "real' DTR line then I think this is the
wrong approach. This problem actually is turning up in both PC class and
ARM boxes now all over the place for three reasons I am seeing.

1. We are getting a lot of hardware moving to serial attached
bluetooth/gps/etc because of the power win. In addition ACPI can describe
power relationships and what is on the other end of a UART embedded in
the device

2. We've got cheap hardware with modem lines being "retrofitted" via gpio

3. There are a subset of devices that have extra control lines beyond the
usual serial port ones. These range from additional control lines for
things like smartcard programmers to port muxing.

> I have no problem either way, just that unused code doesn't have to be
> sitting in the tree and I'm not entirely sure this GPIO should be
> handled by omap-serial.c, perhaps something more generic inside
> serial-core so other UART drivers can benefit from it.

serial-core provides power hooks. If the goal is that this comes on when
you power up the uart and goes away on the last close then the hooks are
there already. If its ldisc specific then the tty layer also calls the
device on ldisc changes precisely so it can make hardware specific
twiddles in such cases.

A set of gpios on the tty_port object would not go amiss and would also
address the PC case.

> considering this is a BTUART device, why didn't you do this at the ldisc
> level ? hci_uart_open() sounds like a good choice from a quick thinking.

ldiscs are hardware independent. Nothing about hardware belongs in an
ldisc. Any ldisc should within reason work on any port.

What I propsed when it came up ages ago was to expose some gpio settings
in the tty, to provide ways for them to be set by default and also ioctls
to configure them. I still think this (but moved into the tty_port as its
a persistent hardware property) is a good idea now that we are starting
to see more use cases than weird dongles and muxes on pre-production
reference boards.

With my tty and serial hat on I think a power gpio is a no-brainer even
without doing the other work and therefore it should probably be described
generically for a serial port in the DT as well as in the ACPI data. If
you should also be able to give it a regulator to use as well that also
seems to make complete sense.

Alan
