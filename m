From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Thu, 29 Mar 2012 19:59:54 +0530
Message-ID: <CAMrsUdKR4nwbBEOx9JPeS=GLDPyioHuijK2596=q2OwJ+ARbxA@mail.gmail.com>
References: <CAMrsUd++maNjaK87bcRUqVHtz5zySujQXZK1YaMH9vnHVWCDag@mail.gmail.com>
 <878viln2t5.fsf@ti.com> <CAMrsUdKXZL4nT0MW=BcD53PsQFE+W1inij3XWe0e5+BjJF3odg@mail.gmail.com>
 <WC20120328153855.621724@terrafix.co.uk> <87vcloipow.fsf@ti.com>
 <WC20120329083556.20174D@terrafix.co.uk> <alpine.DEB.2.00.1203290356190.2788@utopia.booyaka.com>
 <WC20120329112755.541787@terrafix.co.uk> <WC20120329114024.43178C@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:48194 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758579Ab2C2OaR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Mar 2012 10:30:17 -0400
Received: by mail-yx0-f178.google.com with SMTP id m14so1517075yen.9
        for <linux-omap@vger.kernel.org>; Thu, 29 Mar 2012 07:30:16 -0700 (PDT)
In-Reply-To: <WC20120329114024.43178C@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de

On Thu, Mar 29, 2012 at 5:10 PM, Joe Woodward <jw@terrafix.co.uk> wrote=
:
>
>
> -----Original Message-----
> From: "Joe Woodward" <jw@terrafix.co.uk>
> To: "Paul Walmsley" <paul@pwsan.com>
> Cc: "Kevin Hilman" <khilman@ti.com>, "Raja\\, Govindraj" <govindraj.r=
aja@ti.com>, linux-omap@vger.kernel.org, "Felipe Balbi" <balbi@ti.com>,=
 neilb@suse.de
> Date: Thu, 29 Mar 2012 12:27:55 +0100
> Subject: Re: Suspend broken on 3.3?
>
>> > Hello Joe,
>> >
>> > thanks for reporting this. =A0Some thoughts -- really just pure
>> > speculation
>> > -- but I hope some of it might be useful for you...
>> >
>> > On Thu, 29 Mar 2012, Joe Woodward wrote:
>> >
>> > > After digging a bit further I found that the problem isn't lost
>> > characters or character corruption at all...
>> > >
>> > > The UART is actually at 430KBaud (not 900KBaud as I mentioned
>> > earlier).
>> >
>> > 430Kbps? =A0Could you confirm this? =A0OMAP UARTs don't support th=
at rate
>> > as
>> > far as I know - the closest is 460Kbps (OMAP34xx TRM vZR Table 17-=
1
>> > "UART
>> > Mode Baud Rates, Divisor Values, and Error Rates). =A0If one was
>> > desperate,
>> > it might be possible to get 430Kbps by tweaking other parts of the
>> > clock
>> > tree though...
>>
>> Sorry for the confusion... It's 460KBaud - the 430 was just a typo i=
n
>> my previous mail...
>>
>> >
>> > > The data received is very bursty (i.e. sets of messages every
>> second
>> > or
>> > > so), containing a sync sequence to indicate a start of packet.
>> > >
>> > > The received bytes should be: 0x01, 0x52, 0x41 ....rest of packe=
t.
>> > >
>> > > This works 100% of the time on 3.2, but on 3.3 I sometimes (but =
not
>> > always) get: 0x01, 0x00, 0x52, 0x41.
>> > >
>> > > i.e. there is a NULL/0x00 inserted after the first character.
>> >
>> > Is this on the serial console, or on a non-console serial port?
>> >
>> > Looking at drivers/tty/serial/omap-serial.c:receive_chars(), I won=
der
>> > if
>> > the driver is somehow reading bytes from the RX FIFO when it's emp=
ty.
>>
>> > It's unclear to me how this could happen. =A0But you might want to=
 try
>> > doing
>> > an LSR read right before entering the loop in
>> > drivers/tty/serial/omap-serial.c:receive_chars(). =A0In stock v3.3=
,
>> this
>> > would mean adding
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 lsr =3D serial_in(up, UART_LSR);
>> >
>> > at line 190 of drivers/tty/serial/omap-serial.c.
>> >
>>
>> Adding this is made no obvious difference.
>>
>> >
>> > You might also try the DMA path as an experiment. =A0This will tot=
ally
>> > wedge
>> > power management due to an insanely low timer expiration in that
>> path,
>> > but
>> > at least might help narrow the problem down. =A0To do so with a qu=
ick
>> > hack,
>> > you could set omap_serial_default_info.dma_enabled to true instead=
 of
>> > false at arch/arm/mach-omap2/serial.c:76.
>> >
>>
>> This did the trick (I've added it in addition to the LSR read above,
>> i'll back out the LSR read and see if it still works).
>> When DMA is enabled the behaviour (as seen from my application in
>> userspace) is the same as on the stock 3.2 kernel (i.e. for me it wo=
rks
>> :) ).
>>
>
> I've just realised that if anyone has joined this thread late, then I=
'm running in a state with Govindraj's patch in a previous mail in this=
 thread applied to serial.c to
> fix the suspend issues due to the UART wakeup's not being correctly c=
hanged from userspace via sysfs.
>
> It may actually by this patch that is causing the interrupt-enabled s=
erial driver to have broken? The tty that is causing me a problem does =
have wake-from-suspend
> disabled for it from userspace...

Is the patch shared earlier causing this issue of getting 0x00 from rx
randomly ?

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
