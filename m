From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 10/13] tty: serial: omap: remove some dead code
Date: Fri, 25 Apr 2014 12:47:57 +0100
Message-ID: <20140425124757.3f2069b2@alan.etchedpixels.co.uk>
References: <1398265117-11793-1-git-send-email-balbi@ti.com>
	<1398265117-11793-10-git-send-email-balbi@ti.com>
	<5357DDA8.4040206@ti.com>
	<20140424084305.20c7f301@notabene.brown>
	<20140423230121.GC10924@saruman.home>
	<20140424101329.02e6a62f@notabene.brown>
	<20140424012100.GB13374@saruman.home>
	<20140424151914.6bc6463a@alan.etchedpixels.co.uk>
	<20140425193412.7d32e429@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20140425193412.7d32e429@notabene.brown>
Sender: linux-serial-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: balbi@ti.com, Nishanth Menon <nm@ti.com>, Greg KH <gregkh@linuxfoundation.org>, marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, jslaby@suse.cz, grant.likely@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

> I had a quick look and I guess that uart_change_pm() is the most likely
> candidate for what you are referring to.
> I can see how that interfaces to the specific piece of uart hardware, such as
> omap-serial.c
> But I cannot see how you would plumb that though to the device that was
> plugged in to the serial port.  I guess if that device could be registered as
> a child of the omap_serial device, then power management inheritance might
> come in to play, but I cannot see any way to tell a serial port that it has
> some arbitrary child device.

If your device is powered by something like a regulator then you can
drive the regulator from the uart_pm helpers.

> In one case the "power on" sequence is substantially more complex that just a
> gpio or regulator.  I would need to write a device driver for the (GPS) chip
> which could receive a poweron/poweroff signal from the uart and do the
> required magic.

In which case giving the tty a child device (or devices) would probably
be more sensible yes. No problem with that either.

> I would really like to see the "runtime interpreted power sequences" become a
> real thing.  Then serial-core could activate a "RIPS", and that would have
> the flexibility to do whatever is needed without adding complexity to
> serial-core.

Something like ACPI has you mean ? When we put the device into D0 the
ACPI methods can do stuff.

> So ... with your "serial" hat on, if I were to write/test a patch to allow
> any serial port to have a "power-gpio" described in DT and the gpio would be
> driven in uart_change_pm(), would you consider accepting that patch, or did I
> misunderstand?

We are going to need it anyway for other devices fairly soon. It's common
for new PC class hardware to have gpio management for the bluetooth,
gps and and sometimes sensor devices attached to the tty. That's true
irrespective of whether you happen to choose to use it for virtual gpio
hacks.

Alan
