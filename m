From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: Suspend broken on 3.3?
Date: Tue, 3 Apr 2012 12:26:30 +0530
Message-ID: <CAAL8m4wW5e1NL8STFw35ETWp6ANgpFiwvm5dT0HEmNgcn8h87A@mail.gmail.com>
References: <CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com>
 <WC20120330092609.901834@terrafix.co.uk> <CAMrsUdJrJZXjYOs87xmT_J0w7S=VZyfR0tBmhhuYOFmFsOB3SA@mail.gmail.com>
 <WC20120330110442.381887@terrafix.co.uk> <CAMrsUd+AvVp3n1oAREEEmCSBaeA-m68j7gLjXEeJKimX1erfUw@mail.gmail.com>
 <CAMrsUd+K_EwXfypgYWNyAhR7b47avTpWDemS87OTkpH81cJ6Aw@mail.gmail.com> <WC20120402123747.29193B@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50512 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751290Ab2DCG4x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Apr 2012 02:56:53 -0400
Received: by lahj13 with SMTP id j13so3835431lah.19
        for <linux-omap@vger.kernel.org>; Mon, 02 Apr 2012 23:56:51 -0700 (PDT)
In-Reply-To: <WC20120402123747.29193B@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de

On Mon, Apr 2, 2012 at 6:07 PM, Joe Woodward <jw@terrafix.co.uk> wrote:
>
>
> -----Original Message-----
> From: "Raja, Govindraj" <govindraj.raja@ti.com>
> To: Joe Woodward <jw@terrafix.co.uk>, Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Felip=
e Balbi <balbi@ti.com>, neilb@suse.de
> Date: Mon, 2 Apr 2012 16:13:13 +0530
> Subject: Re: Suspend broken on 3.3?
>
>> On Fri, Mar 30, 2012 at 5:54 PM, Raja, Govindraj
>> <govindraj.raja@ti.com> wrote:
>> > On Fri, Mar 30, 2012 at 4:34 PM, Joe Woodward <jw@terrafix.co.uk>
>> wrote:
>> >>
>> >>
>> >> -----Original Message-----
>> >> From: "Raja, Govindraj" <govindraj.raja@ti.com>
>> >> To: Joe Woodward <jw@terrafix.co.uk>
>> >> Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>=
,
>> linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.=
de
>> >> Date: Fri, 30 Mar 2012 15:45:19 +0530
>> >> Subject: Re: Suspend broken on 3.3?
>> >>
>> >>> On Fri, Mar 30, 2012 at 2:56 PM, Joe Woodward <jw@terrafix.co.uk=
>
>> >>> wrote:
>> >>> > ...[snip]...
>> >>> >>
>> >>> >> Could you please try attached patch and let me know if this
>> solves
>> >>> the
>> >>> >> rx issue as well,
>> >>> >> without using dma mode.
>> >>> >>
>> >>> >
>> >>> > Right,
>> >>> >
>> >>> > I think we've getting closer, but still not quite there...
>> >>> >
>> >>> > Firstly, the patch adds an include to "iomap.h" - but this
>> doesn't
>> >>> exist in stock 3.3. Simply removing this include seemed to allow
>> the
>> >>> compile to complete
>> >>> > successfully.
>> >>>
>> >>> Sorry I forgot to specify this is needed for latest mainline.
>> >>>
>> >>> >
>> >>> > With this patch applied (and not in DMA mode) I now get the
>> >>> following:
>> >>> > =A0- If I leave wake-from-suspend enabled for the serial port =
then
>> it
>> >>> works correctly (i.e. no lost/extra 0x00 characters).
>> >>> > =A0- If I disable wake-from-suspend for the serial port and go
>> through
>> >>> a suspend cycle (i.e. suspend and then wake), then the serial po=
rt
>> >>> starts to misbehave as
>> >>> > before.
>> >>> > =A0- If I then re-enable wake-from-suspend and go through a
>> suspend
>> >>> cycle it starts to work correctly again.
>> >>> >
>> >>> > So the problem is still that if wake-from-suspend is disabled =
for
>> a
>> >>> serial port, and a suspend cycle is performed then when woken th=
e
>> >>> serial port will not function
>> >>> > correctly if operating in interrupt-mode.
>> >>>
>> >>> I tried it on my 3430sdp but strangely I don't see a 0x00 char r=
ead
>> >>> after disabling uart wakeups
>> >>> and waking up by keypad press.
>> >>>
>> >>> Probably as a quick try we can try doing uart_insert_char only i=
f
>> data
>> >>> was read from rx fifo
>> >>> (Attached patch)
>> >>>
>> >>
>> >> Sadly the patch makes no difference.
>> >>
>> >> I'm suprised you aren't seeing similar effects.
>> >>
>> >> I've done more testing, and a simplified test case is as follows:
>> >> - take a stock 3.3 kernel and apply your patch to allow disabling=
 of
>> wake-from-suspend for the serial ports.
>> >> - disable wake-from-suspend for the console tty:
>> >> =A0echo disable > /sys/devices/platform/omap/omap_uart.2/power/wa=
keup
>> >> - perform a suspend (you'll need a button or something to wake yo=
u
>> now that the console wont).
>> >> =A0echo mem > /sys/power/state
>> >>
>> >> At this point the console is noticable/painfully slow. No charact=
ers
>> are lost, but it's obvious something isn't right!
>> >
>> >
>> > Yes I see this behavior with console now it becomes very slow afte=
r
>> we
>> > disable module level wakeups.
>> >
>> > One difference to note is :
>> >
>> > in 3.2 =3D> full system PM is prevented in idle path if uart is ac=
tive
>> > i.e, MPU will not hit retention
>> >
>> > in 3.3 =3D> MPU will hit retention independently of uart is active=
 or
>> not.
>> > =A0 =A0 =A0 =A0 =A0 =A0 I think the way to get MPU qos for uart po=
rt
>> activity
>> > while in irq mode is to use PM_WKEN1
>> > =A0 =A0 =A0 =A0 =A0 =A0 reg settings, meaning enabling module leve=
l wakeup
>> event
>> > generation. Disabling it is causing this
>> > =A0 =A0 =A0 =A0 =A0 =A0 slow response.
>> >
>> > Checking if we can workaround this scenario.
>>
>> As of now what I can think of is to update qos reqest to prevent MPU
>> from transitioning in case of port activity if wakeup capability for
>> port
>> is disabled.
>>
>
> Does that get us back to the same behaviour as in 3.2? If thats the b=
est we can do, then I guess that'll have to do.
>

yes, only if we are in non-dma mode with wakeup disabled.


> Will similar problems exist when in DMA-mode (as we I set the DMA fla=
g it seemed to work ok)?

In dma mode we might not need MPU for uart fifo ops and while in irq
mode we need MPU
for fifo ops, while mpu is hitting low power states way to get mpu qos
for uart ops
is by generating module level wakeup events, if module level wakeups
are disabled
and if uart does relies on mpu for fifo ops we have to prevent MPU
from hitting low power
states.

>
> It does seem a little strange from my naive point of view: surely wha=
t peripherals/pins are used to wake the device from suspend should not =
affect how the device
> chooses to enable/disable clocks/power-domains to save power when run=
ning?
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
