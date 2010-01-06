From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: serial port input corruption with 2.6.32?
Date: Wed, 06 Jan 2010 15:26:58 -0800
Message-ID: <87k4vuak71.fsf@deeprootsystems.com>
References: <5e088bd90912231259k12dfafeckecbaaa1d29cec4ed@mail.gmail.com>
	<4551feaf0912231306gfebba89rf4e5b014c3a74fe7@mail.gmail.com>
	<5e088bd90912231322y3f507e4bvc453583946340cb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:46134 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066Ab0AFX1C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 18:27:02 -0500
Received: by pzk1 with SMTP id 1so2503144pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 15:27:01 -0800 (PST)
In-Reply-To: <5e088bd90912231322y3f507e4bvc453583946340cb8@mail.gmail.com> (Steve Sakoman's message of "Wed\, 23 Dec 2009 13\:22\:44 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, linux-omap@vger.kernel.org

Steve Sakoman <sakoman@gmail.com> writes:

> On Wed, Dec 23, 2009 at 1:06 PM, Robert Nelson <robertcnelson@gmail.c=
om> wrote:
>> On Wed, Dec 23, 2009 at 2:59 PM, Steve Sakoman <sakoman@gmail.com> w=
rote:
>>> I'm seeing some strange behavior with my console serial port with 2=
=2E6.32.
>>>
>>> Output seems fine -- no errors in the boot messages.
>>>
>>> However it seems that quite often the first character typed in a
>>> console session is garbled -- subsequent characters are OK:
>>>
>>> root@omap3:~# =EF=BF=BDs -l
>>> -sh: =EF=BF=BDs: not found
>>>
>>> If commands are typed in rapid succession this issue doesn't show u=
p,
>>> but if several seconds pass since the last keystroke the first
>>> character is garbled once again.
>>>
>>> Anyone else seeing this? =C2=A0A search of this list didn't turn an=
ything
>>> up, but perhaps my google mojo is just bad today.
>>>
>>> Steve
>>
>> Hey Steve,
>>
>> I saw something similar while testing 2.6.32, by chance are you usin=
g
>> any power management patches?
>>
>> I had to disable CONFIG_CPU_IDLE:
>>
>> -CONFIG_CPU_IDLE=3Dy
>> -CONFIG_CPU_IDLE_GOV_LADDER=3Dy
>> -CONFIG_CPU_IDLE_GOV_MENU=3Dy
>> +# CONFIG_CPU_IDLE is not set
>
> Now power management patches, but CPU_IDLE is indeed enabled.   I'll
> give it a try with CPU_IDLE disabled.

As of 2.6.32, much of the PM patches are in mainline now, including
CPUidle.

> Does this just work around a bug that ought to be fixed, or is
> enabling CPU_IDLE just a bad idea?

CPUidle itself is just fine.

You've discovered a PM "feature."  ;)

I'm guessing you (or your userland) has enabled sleep-while-idle.
Check the value of <debugfs>/pm_debug/sleep_while_idle.  This
enables PM features during idle.

What you're seeing is a side-effect of allowing the UARTs to be idled
and un-clocked during idle.

The UARTs have a SW inactivity timer (default 5 secs) after which
their clocks will be cut during idle.  The UARTs themselves are also
configured as wakeup sources by default, so any UART input will
trigger a wakeup.  However, the first char serves as the wakeup but
the OMAP does not wakeup fast enough to actually latch the first
character, resulting in either garbage or a lost char.

The simplest way to avoid the problem (but implies increased power
consumption) is to simply disable the UART inactivity timer for your
console UART.  This way, that UART will never timeout and its clocks
will never be cut:

  # echo 0 > /sys/devices/platform/serial8250.N/sleep_timeout

(where N =3D [0, 1, 2], as in ttySN)

Another alternative (although not a very practical one) is to use
something else as a wakeup source (GPIO, twl4030 keypad) before typing
on the console.

Personally, after so much PM development, I've now develop the habit
of typing the first character of commands twice.  :)

Basically, there is currently no way of avoiding this problem if you
are using UARTs as the wakeup source and want power savings. =20

This will also have obvious and serious PM implications for non
serial-console devices connected to UARTs (IrDA, bluetooth, modems,
etc.)

I've heard some ideas of muxing the UART into GPIO mode when idle and
having a bitbanging to get the first char so it is not lost, but
haven't seen any patches to do it. =20

While it doesn't really solve your problem, I hope it at least helps
understand the reason for it.

Kevin


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
