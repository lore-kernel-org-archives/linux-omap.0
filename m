From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Fri, 30 Mar 2012 17:54:24 +0530
Message-ID: <CAMrsUd+AvVp3n1oAREEEmCSBaeA-m68j7gLjXEeJKimX1erfUw@mail.gmail.com>
References: <WC20120329112755.541787@terrafix.co.uk> <WC20120329114024.43178C@terrafix.co.uk>
 <CAMrsUdKR4nwbBEOx9JPeS=GLDPyioHuijK2596=q2OwJ+ARbxA@mail.gmail.com>
 <WC20120330075339.4017FC@terrafix.co.uk> <CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com>
 <WC20120330092609.901834@terrafix.co.uk> <CAMrsUdJrJZXjYOs87xmT_J0w7S=VZyfR0tBmhhuYOFmFsOB3SA@mail.gmail.com>
 <WC20120330110442.381887@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:58398 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760380Ab2C3MYq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 08:24:46 -0400
Received: by ggmi1 with SMTP id i1so222232ggm.3
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 05:24:44 -0700 (PDT)
In-Reply-To: <WC20120330110442.381887@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de

On Fri, Mar 30, 2012 at 4:34 PM, Joe Woodward <jw@terrafix.co.uk> wrote=
:
>
>
> -----Original Message-----
> From: "Raja, Govindraj" <govindraj.raja@ti.com>
> To: Joe Woodward <jw@terrafix.co.uk>
> Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, li=
nux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de
> Date: Fri, 30 Mar 2012 15:45:19 +0530
> Subject: Re: Suspend broken on 3.3?
>
>> On Fri, Mar 30, 2012 at 2:56 PM, Joe Woodward <jw@terrafix.co.uk>
>> wrote:
>> > ...[snip]...
>> >>
>> >> Could you please try attached patch and let me know if this solve=
s
>> the
>> >> rx issue as well,
>> >> without using dma mode.
>> >>
>> >
>> > Right,
>> >
>> > I think we've getting closer, but still not quite there...
>> >
>> > Firstly, the patch adds an include to "iomap.h" - but this doesn't
>> exist in stock 3.3. Simply removing this include seemed to allow the
>> compile to complete
>> > successfully.
>>
>> Sorry I forgot to specify this is needed for latest mainline.
>>
>> >
>> > With this patch applied (and not in DMA mode) I now get the
>> following:
>> > =A0- If I leave wake-from-suspend enabled for the serial port then=
 it
>> works correctly (i.e. no lost/extra 0x00 characters).
>> > =A0- If I disable wake-from-suspend for the serial port and go thr=
ough
>> a suspend cycle (i.e. suspend and then wake), then the serial port
>> starts to misbehave as
>> > before.
>> > =A0- If I then re-enable wake-from-suspend and go through a suspen=
d
>> cycle it starts to work correctly again.
>> >
>> > So the problem is still that if wake-from-suspend is disabled for =
a
>> serial port, and a suspend cycle is performed then when woken the
>> serial port will not function
>> > correctly if operating in interrupt-mode.
>>
>> I tried it on my 3430sdp but strangely I don't see a 0x00 char read
>> after disabling uart wakeups
>> and waking up by keypad press.
>>
>> Probably as a quick try we can try doing uart_insert_char only if da=
ta
>> was read from rx fifo
>> (Attached patch)
>>
>
> Sadly the patch makes no difference.
>
> I'm suprised you aren't seeing similar effects.
>
> I've done more testing, and a simplified test case is as follows:
> - take a stock 3.3 kernel and apply your patch to allow disabling of =
wake-from-suspend for the serial ports.
> - disable wake-from-suspend for the console tty:
> =A0echo disable > /sys/devices/platform/omap/omap_uart.2/power/wakeup
> - perform a suspend (you'll need a button or something to wake you no=
w that the console wont).
> =A0echo mem > /sys/power/state
>
> At this point the console is noticable/painfully slow. No characters =
are lost, but it's obvious something isn't right!


Yes I see this behavior with console now it becomes very slow after we
disable module level wakeups.

One difference to note is :

in 3.2 =3D> full system PM is prevented in idle path if uart is active
i.e, MPU will not hit retention

in 3.3 =3D> MPU will hit retention independently of uart is active or n=
ot.
             I think the way to get MPU qos for uart port activity
while in irq mode is to use PM_WKEN1
             reg settings, meaning enabling module level wakeup event
generation. Disabling it is causing this
             slow response.

Checking if we can workaround this scenario.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
