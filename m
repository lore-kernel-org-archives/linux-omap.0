From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH 0/3] capebus moving omap_devices to mach-omap2
Date: Fri, 2 Nov 2012 02:42:51 -0700
Message-ID: <CA+Bv8Xb4eAQ2po-nwCT6ZXNdaU7cwshVaGC795e3GYZ+B7L-jQ@mail.gmail.com>
References: <20121101110418.GF410@arwen.pp.htv.fi>
	<3AF5A6FC-61D9-40CA-85B3-81C2C788CB76@antoniou-consulting.com>
	<20121101124025.GA12489@arwen.pp.htv.fi>
	<A16B0ABF-AB9D-4F48-88BD-96F123FFEF2F@antoniou-consulting.com>
	<20121101131609.GC12489@arwen.pp.htv.fi>
	<E911D0B7-0397-4ED0-828E-71F9531E84E0@antoniou-consulting.com>
	<20121101135148.382aec00@pyramind.ukuu.org.uk>
	<9F25E89E-9194-4725-8A8C-053DCBADA1DB@antoniou-consulting.com>
	<20121101220518.GE14982@arwen.pp.htv.fi>
	<CA+Bv8XbAvEXe=zDaA8W2+ROD2duYMRcJu4-bms31OH=V_ScKow@mail.gmail.com>
	<20121102085718.GF17063@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121102085718.GF17063@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 2, 2012 at 1:57 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Nov 01, 2012 at 04:49:23PM -0700, Russ Dill wrote:
>> On Thu, Nov 1, 2012 at 3:05 PM, Felipe Balbi <balbi@ti.com> wrote:
>> > HI,
>> >
>> > On Thu, Nov 01, 2012 at 03:59:50PM +0200, Pantelis Antoniou wrote:
>> >> Hi Alan,
>> >>
>> >> On Nov 1, 2012, at 3:51 PM, Alan Cox wrote:
>> >>
>> >> >> What they want, and what every user wants, is I plug this boar=
d in, and
>> >> >> the driver make sure everything is loaded and ready. No, the e=
nd users
>> >> >> don't want to see any of the implementation details of how the=
 bitfile
>> >> >> is transported; the driver can handle it.
>> >> >
>> >> > That doesn't necessarily make it a bus merely some kind of hotp=
lug
>> >> > enumeration of devices. That should all work properly both for =
devices
>> >> > and busses with spi and i=C2=B2c as the final bits needed for i=
t got fixed
>> >> > some time ago.
>> >> >
>> >> > In an ideal world you don't want to be writing custom drivers f=
or stuff.
>> >> > If your cape routes an i=C2=B2c serial device to the existing s=
ystem i=C2=B2c
>> >> > busses then you want to just create an instance of any existing=
 driver on
>> >> > the existing i=C2=B2c bus not create a whole new layer of goop.
>> >> >
>> >> > It does need to do the plumbing and resource management for the=
 plumbing
>> >> > but thats not the same as being a bus.
>> >> >
>> >> > Alan
>> >>
>> >>
>> >> Fair enough. But there's no such thing a 'hotplug enumeration
>> >> construct' in Linux yet, and a bus is the closest thing to it. It=
 does
>> >> take advantage of the nice way device code matches drivers and de=
vices
>> >> though.
>> >>
>> >> I'm afraid that having the I2C/SPI drivers doing the detection wo=
n't
>> >> work.  The capes can have arbitrary I2C/SPI devices (and even mor=
e
>> >> weird components).  There is no way to assure for example that th=
e I2C
>> >> device responding to address 'foo' in cape A is the same I2C devi=
ce
>> >> responding to the same address in cape B.
>> >
>> > your ->detect() method should take care of that.
>>
>> There isn't some magical serial number in I=C2=B2C devices that a
>> ->detect() method can read and the implementation of I=C2=B2C is som=
ewhat
>> flexible. One devices read may be another devices write. A detect
>
> look at what other drivers do. You can read a revision register, you =
can
> write a command and see if the device responds as expected, it doesn'=
t
> matter.

Since a "revision" register isn't required by the I=C2=B2C spec, it isn=
't
implemented on a huge number of chips. Also, having a few dozen probe
routines come though and write to random address of every single I=C2=B2=
C
device can a) take a really long time, and b) have quite a few
unintended side effects.

>> method that only performs reads could easily toggle a gpio that rese=
ts
>> the board, rewrite and eeprom, or set the printer on fire. If you
>
> how ? It's just a read.

Because the I=C2=B2C spec is incredibly flexible. For a lot of devices,
reading from a register is done by writing the register address, and
then reading the contents. For devices that don't implement registers
in that way (such as many eeproms), this is just a write.

>> browse through various detect functions, yes, some of them key off a=
n
>> ID, but a lot of them just check various registers to see if certain
>> bits are zero, or certain bits are one. A lot of I=C2=B2C devices I'=
ve
>> dealt with have no good way of probing them, especially GPIO chips
>> (you'll notice none of the I=C2=B2C GPIO expanders have detect funct=
ions)
>
> it doesn't mean it can't be done.

Really? Please, do tell how you would write a detect function for a
PCA9534. It has 4 registers, an input port registers, an output port
register, a polarity inversion register, and a configuration register.
And don't forget, since we are probing, every detect routine for every
I=C2=B2C driver will have to run with every I=C2=B2C address on every b=
us,
possibly with both address formats.

>> On top of all this the detect routine does not tell you if the alert
>> pin is connected to some IRQ, or in the case of a GPIO expander, wha=
t
>> those GPIOs are connected to, etc, etc.
>
> so what ? All you want to do with detect is figure out if the far end=
 is
> who you think it is, not what it's doing.

If we already knew who was there, we wouldn't need a detect routine.
