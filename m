From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/3] capebus moving omap_devices to mach-omap2
Date: Fri, 2 Nov 2012 11:21:04 +0000
Message-ID: <20121102112104.4657fb7b@pyramind.ukuu.org.uk>
References: <50924DA3.1060901@ti.com>
	<F49CA12D-4DAC-4293-AD4D-FC7EDCEA6993@antoniou-consulting.com>
	<20121101110418.GF410@arwen.pp.htv.fi>
	<3AF5A6FC-61D9-40CA-85B3-81C2C788CB76@antoniou-consulting.com>
	<20121101124025.GA12489@arwen.pp.htv.fi>
	<A16B0ABF-AB9D-4F48-88BD-96F123FFEF2F@antoniou-consulting.com>
	<20121101131609.GC12489@arwen.pp.htv.fi>
	<E911D0B7-0397-4ED0-828E-71F9531E84E0@antoniou-consulting.com>
	<20121101135148.382aec00@pyramind.ukuu.org.uk>
	<9F25E89E-9194-4725-8A8C-053DCBADA1DB@antoniou-consulting.com>
	<20121101220518.GE14982@arwen.pp.htv.fi>
	<CA+Bv8XbAvEXe=zDaA8W2+ROD2duYMRcJu4-bms31OH=V_ScKow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+Bv8XbAvEXe=zDaA8W2+ROD2duYMRcJu4-bms31OH=V_ScKow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: balbi@ti.com, Pantelis Antoniou <panto@antoniou-consulting.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

> >> Fair enough. But there's no such thing a 'hotplug enumeration
> >> construct' in Linux yet, and a bus is the closest thing to it. It =
does
> >> take advantage of the nice way device code matches drivers and dev=
ices
> >> though.

A bus is the wrong construct. You need something to add devices onto th=
e
busses. You can do that. The Intel SFI layer on phones for example
enumerates devices through a firmware table set and creates them on the
right actual physical bus not on their own fake one.

It's not hotplug in the sense that the phone happens be a fixed
configuration but it does support hotplug behaviour because the order o=
f
the drivers and enumeration is undefined (and both orders work).

> >>
> >> I'm afraid that having the I2C/SPI drivers doing the detection won=
't
> >> work.  The capes can have arbitrary I2C/SPI devices (and even more
> >> weird components).  There is no way to assure for example that the=
 I2C
> >> device responding to address 'foo' in cape A is the same I2C devic=
e
> >> responding to the same address in cape B.
> >
> > your ->detect() method should take care of that.
>=20
> There isn't some magical serial number in I=C2=B2C devices that a
> ->detect() method can read and the implementation of I=C2=B2C is some=
what

It doesn't matter.

What you are basically talking about is


	cape layer
		- wtf is this
		- how do I plumb it

		- create device nodes with correct name for
		  binding, address etc on the right bus


	i2c layer
		- ooh a new i2c device
		- probe as indicated by device name
		- attach correct driver


Architecturally its possible you want to make some caps MFDs if they ha=
ve
their own bus heirarchies etc but generally I doubt it.


Take a look at arch/x86/platform/mrst/mrst.c. It's a specific example o=
f
a platform which parses tables and attaches devices to the right physic=
al
bus in a manner they can be reliably probed even when the device has no
sane autodetect.

Alan
