From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH] OMAP3: CPUIDLE & PM: check_bm fix.
Date: Thu, 10 Jul 2008 15:53:49 +0300
Message-ID: <87vdzdsxwi.fsf@trdhcp146196.ntc.nokia.com>
References: <1215519440-10234-1-git-send-email-jouni.hogander@nokia.com>
	<1215584973-14982-1-git-send-email-jouni.hogander@nokia.com>
	<000b01c8e18f$31708610$68bf18ac@ent.ti.com>
	<87tzezwnl1.fsf@trdhcp146196.ntc.nokia.com>
	<000c01c8e193$9f1f4d50$68bf18ac@ent.ti.com>
	<87tzeztpz3.fsf@trdhcp146196.ntc.nokia.com>
	<001901c8e19f$32f66f80$68bf18ac@ent.ti.com>
	<13B9B4C6EF24D648824FF11BE8967162035BD675D5@dlee02.ent.ti.com>
	<87iqves1xm.fsf@trdhcp146196.ntc.nokia.com>
	<13B9B4C6EF24D648824FF11BE8967162035BDBF028@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42135 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbYGJMyf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jul 2008 08:54:35 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162035BDBF028@dlee02.ent.ti.com>
	(ext Woodruff's message of "Thu, 10 Jul 2008 07:20:14 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"ext Woodruff, Richard" <r-woodruff2@ti.com> writes:

> Hi,
>
>> >  static void serial8250_stop_tx(struct uart_port *port)
>> > @@ -1268,6 +1276,15 @@ static void serial8250_start_tx(struct u
>> >                 up->acr &=3D ~UART_ACR_TXDIS;
>> >                 serial_icr_write(up, UART_ACR, up->acr);
>> >         }
>> > +#ifdef CONFIG_OMAP3_PM
>> > +       {
>> > +               /* Don't advertise partial idle else TX irqs will
>> not be seen */
>> > +               /* Alternative is to set kernel timer at fifo drai=
n
>> rate */
>> > +               unsigned int tmp;
>> > +               tmp =3D (serial_in(up, UART_OMAP_SYSC) & 0x7) | (1=
 <<
>> 3);
>> > +               serial_out(up, UART_OMAP_SYSC, tmp); /* no-idle */
>> > +       }
>> > +#endif
>>
>> I tried this quickly. This doesn't work alone. At least if we want
>> working serial-console. Problem with this is that when entering char
>> to console to wake-up omap. First character is lost and then no "ech=
o"
>> happens and serial8250_start_tx is not called. I think this will nee=
d
>> some timeout anyway which is started when uart rx|iopad wakeup
>> happens.
>
> Yes that is true.
>
> In reference code it is dealt with and rationalized.  This was an iss=
ue last year in the old code and will be this year in this newer code.
>
> * CDP code employs an activity check which can gate idle.  The disrup=
tion was bothersome and gave a bad impression (even if its just a debug=
 port).  It also interfered at times with existing functional tests whi=
ch depended on console (either getting all characters or reasonable per=
formance).
>
> The current check will: On activity raise a cpuidle bus master
> activity failure for some number of seconds.  This allows normal
> typing for extended periods.  It does this by marking UART function
> IRQs with a time stamp and it checks internal state to make sure
> RX/TX engine is not busy or has queued data waiting.

Isn't this exactly what is done in "Added sleep support to UART" patch
in workaround patch set?

>
> This activity assertion will gate the usage of C states where its F-C=
LOCK is cut.  At the same time its natural wake up events are enabled (=
along with the above hack as the tx events are not currenly hooked into=
 the wakeup logic).
>
> When OFF/RET mode is selected IO pad is enabled for the port wakeup.

I have seen this in CDP reference code. Is there some specific reason
why this is enabled dynamically in code?

>
> ** The end effect is typing and input/output are good.  However, if y=
ou stop interacting for greater than the time out you will loose your 1=
st character.  This is unavoidable as the machine doesn't re-start fast=
 enough to not loose the start bit (wakeup/DPLL relock).
>
> It doesn't take much code to do this today.  But with out it the cons=
ole is not very useable when PM is enabled _AND_ being effective.  As I=
 mentioned initially, having the UART problem in a sense is a good mile=
stone as it shows you are starting to hit the big power states very oft=
en.
>
> Regards,
> Richard W.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
