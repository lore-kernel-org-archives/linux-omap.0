From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH 0/3] capebus moving omap_devices to mach-omap2
Date: Fri, 2 Nov 2012 11:39:41 +0100
Message-ID: <041C30E9-0CD2-4CF4-823A-E27B7BFF1BE1@dominion.thruhere.net>
References: <20121101110418.GF410@arwen.pp.htv.fi> <3AF5A6FC-61D9-40CA-85B3-81C2C788CB76@antoniou-consulting.com> <20121101124025.GA12489@arwen.pp.htv.fi> <A16B0ABF-AB9D-4F48-88BD-96F123FFEF2F@antoniou-consulting.com> <20121101131609.GC12489@arwen.pp.htv.fi> <E911D0B7-0397-4ED0-828E-71F9531E84E0@antoniou-consulting.com> <20121101135148.382aec00@pyramind.ukuu.org.uk> <9F25E89E-9194-4725-8A8C-053DCBADA1DB@antoniou-consulting.com> <20121101220518.GE14982@arwen.pp.htv.fi> <CA+Bv8XbAvEXe=zDaA8W2+ROD2duYMRcJu4-bms31OH=V_ScKow@mail.gmail.com> <20121102085718.GF17063@arwen.pp.htv.fi> <CA+Bv8Xb4eAQ2po-nwCT6ZXNdaU7cwshVaGC795e3GYZ+B7L-jQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.1 \(1498\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36157 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab2KBKji convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Nov 2012 06:39:38 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so2329805wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 02 Nov 2012 03:39:37 -0700 (PDT)
In-Reply-To: <CA+Bv8Xb4eAQ2po-nwCT6ZXNdaU7cwshVaGC795e3GYZ+B7L-jQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: balbi@ti.com, Pantelis Antoniou <panto@antoniou-consulting.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>


Op 2 nov. 2012, om 10:42 heeft Russ Dill <Russ.Dill@ti.com> het volgend=
e geschreven:

> On Fri, Nov 2, 2012 at 1:57 AM, Felipe Balbi <balbi@ti.com> wrote:
>> Hi,
>>=20
>> On Thu, Nov 01, 2012 at 04:49:23PM -0700, Russ Dill wrote:
>>> On Thu, Nov 1, 2012 at 3:05 PM, Felipe Balbi <balbi@ti.com> wrote:
>>>> HI,
>>>>=20
>>>> On Thu, Nov 01, 2012 at 03:59:50PM +0200, Pantelis Antoniou wrote:
>>>>> Hi Alan,
>>>>>=20
>>>>> On Nov 1, 2012, at 3:51 PM, Alan Cox wrote:
>>>>>=20
>>>>>>> What they want, and what every user wants, is I plug this board=
 in, and
>>>>>>> the driver make sure everything is loaded and ready. No, the en=
d users
>>>>>>> don't want to see any of the implementation details of how the =
bitfile
>>>>>>> is transported; the driver can handle it.
>>>>>>=20
>>>>>> That doesn't necessarily make it a bus merely some kind of hotpl=
ug
>>>>>> enumeration of devices. That should all work properly both for d=
evices
>>>>>> and busses with spi and i=B2c as the final bits needed for it go=
t fixed
>>>>>> some time ago.
>>>>>>=20
>>>>>> In an ideal world you don't want to be writing custom drivers fo=
r stuff.
>>>>>> If your cape routes an i=B2c serial device to the existing syste=
m i=B2c
>>>>>> busses then you want to just create an instance of any existing =
driver on
>>>>>> the existing i=B2c bus not create a whole new layer of goop.
>>>>>>=20
>>>>>> It does need to do the plumbing and resource management for the =
plumbing
>>>>>> but thats not the same as being a bus.
>>>>>>=20
>>>>>> Alan
>>>>>=20
>>>>>=20
>>>>> Fair enough. But there's no such thing a 'hotplug enumeration
>>>>> construct' in Linux yet, and a bus is the closest thing to it. It=
 does
>>>>> take advantage of the nice way device code matches drivers and de=
vices
>>>>> though.
>>>>>=20
>>>>> I'm afraid that having the I2C/SPI drivers doing the detection wo=
n't
>>>>> work.  The capes can have arbitrary I2C/SPI devices (and even mor=
e
>>>>> weird components).  There is no way to assure for example that th=
e I2C
>>>>> device responding to address 'foo' in cape A is the same I2C devi=
ce
>>>>> responding to the same address in cape B.
>>>>=20
>>>> your ->detect() method should take care of that.
>>>=20
>>> There isn't some magical serial number in I=B2C devices that a
>>> ->detect() method can read and the implementation of I=B2C is somew=
hat
>>> flexible. One devices read may be another devices write. A detect
>>=20
>> look at what other drivers do. You can read a revision register, you=
 can
>> write a command and see if the device responds as expected, it doesn=
't
>> matter.
>=20
> Since a "revision" register isn't required by the I=B2C spec, it isn'=
t
> implemented on a huge number of chips. Also, having a few dozen probe
> routines come though and write to random address of every single I=B2=
C
> device can a) take a really long time, and b) have quite a few
> unintended side effects.
>=20
>>> method that only performs reads could easily toggle a gpio that res=
ets
>>> the board, rewrite and eeprom, or set the printer on fire. If you
>>=20
>> how ? It's just a read.
>=20
> Because the I=B2C spec is incredibly flexible. For a lot of devices,
> reading from a register is done by writing the register address, and
> then reading the contents. For devices that don't implement registers
> in that way (such as many eeproms), this is just a write.
>=20
>>> browse through various detect functions, yes, some of them key off =
an
>>> ID, but a lot of them just check various registers to see if certai=
n
>>> bits are zero, or certain bits are one. A lot of I=B2C devices I've
>>> dealt with have no good way of probing them, especially GPIO chips
>>> (you'll notice none of the I=B2C GPIO expanders have detect functio=
ns)
>>=20
>> it doesn't mean it can't be done.
>=20
> Really? Please, do tell how you would write a detect function for a
> PCA9534. It has 4 registers, an input port registers, an output port
> register, a polarity inversion register, and a configuration register=
=2E
> And don't forget, since we are probing, every detect routine for ever=
y
> I=B2C driver will have to run with every I=B2C address on every bus,
> possibly with both address formats.

Worse, things like early revisions of the picoDLP projector will erase =
their firmware if you do a linear scan through all addresses.=20

regards,

Koen--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
