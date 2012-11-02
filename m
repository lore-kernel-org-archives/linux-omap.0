From: Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH 0/3] capebus moving omap_devices to mach-omap2
Date: Fri, 2 Nov 2012 12:07:08 -0400
Message-ID: <CA+T6QPkWLXx6-Bh-4VdsdoHypHNkJ4hTdkk-rqUEyGEswpW6fQ@mail.gmail.com>
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
	<20121102112104.4657fb7b@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:54616 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab2KBQHL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Nov 2012 12:07:11 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2702492lag.19
        for <linux-omap@vger.kernel.org>; Fri, 02 Nov 2012 09:07:09 -0700 (PDT)
In-Reply-To: <20121102112104.4657fb7b@pyramind.ukuu.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russ Dill <Russ.Dill@ti.com>, balbi@ti.com, Pantelis Antoniou <panto@antoniou-consulting.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

On Fri, Nov 2, 2012 at 7:21 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wro=
te:
>> >> Fair enough. But there's no such thing a 'hotplug enumeration
>> >> construct' in Linux yet, and a bus is the closest thing to it. It=
 does
>> >> take advantage of the nice way device code matches drivers and de=
vices
>> >> though.
>
> A bus is the wrong construct. You need something to add devices onto =
the
> busses. You can do that. The Intel SFI layer on phones for example
> enumerates devices through a firmware table set and creates them on t=
he
> right actual physical bus not on their own fake one.

Physically, it is a bus, though it is made up of several other busses.
While I could certainly see people using the mechanism for enumerating
soldered-down devices over the fixed busses, there is a physical
connector that deserves some abstraction/identification.

=46urther, it is critical to enable hardware vendors to avoid writing
any code for which there are existing drivers.

>
> It's not hotplug in the sense that the phone happens be a fixed
> configuration but it does support hotplug behaviour because the order=
 of
> the drivers and enumeration is undefined (and both orders work).

I think SFI is interesting, but certainly lacks all of the interfaces.
It seems reasonable to me to extend the specification to add the
missing interfaces, but what doesn't seem to map is the fact that the
SFI structures are initially processed in the bootloader and passed
statically to the kernel, rather than enabling run-time operation.
Users may make run-time trade-offs and also need mechanisms for
performing initial debug on products like "proto capes".

Capebus seems to me to provide this solution fairly well. I don't
believe the SFI approach covers the most critical aspects of hotplug
behaviour.

>
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
>> There isn't some magical serial number in I=B2C devices that a
>> ->detect() method can read and the implementation of I=B2C is somewh=
at
>
> It doesn't matter.
>
> What you are basically talking about is
>
>
>         cape layer
>                 - wtf is this
>                 - how do I plumb it
>
>                 - create device nodes with correct name for
>                   binding, address etc on the right bus
>
>
>         i2c layer
>                 - ooh a new i2c device
>                 - probe as indicated by device name
>                 - attach correct driver

Many of the devices cannot be probed.

>
>
> Architecturally its possible you want to make some caps MFDs if they =
have
> their own bus heirarchies etc but generally I doubt it.
>
>
> Take a look at arch/x86/platform/mrst/mrst.c. It's a specific example=
 of
> a platform which parses tables and attaches devices to the right phys=
ical
> bus in a manner they can be reliably probed even when the device has =
no
> sane autodetect.

I know I *am* the slow person in the room, but doesn't this approach
require the code to be compiled into the kernel to support the devices
ahead of time? While I think it might be reasonable to have hardware
developers provide DT fragments in their EEPROMs, there's no way to
get them to submit code patches in order to get their hardware to
work. They need to ship hardware that works with pre-existing
software, since there will be hundreds of boards created by people
with little to no previous Linux experience (akin to Arduino). I seem
to be missing how that approach would get us there.

>
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
