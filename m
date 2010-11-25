From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are disabled
Date: Thu, 25 Nov 2010 19:38:07 +0100
Message-ID: <AANLkTik5cRQPodAYtacTD5EdQYnDbvGgOoNfNfHuW+fq@mail.gmail.com>
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
	<AANLkTina+O1GgMgS0qDKix=d4HOtT1fFrCotTuCCxACv@mail.gmail.com>
	<alpine.DEB.2.00.1011251017390.20215@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55787 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab0KYSiI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 13:38:08 -0500
Received: by qyk12 with SMTP id 12so2191927qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Nov 2010 10:38:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1011251017390.20215@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, tom.leiming@gmail.com, pramod.gurav@ti.com, thomas.petazzoni@free-electrons.com, govindraj.raja@ti.com

On Thu, Nov 25, 2010 at 6:35 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Jean
>
> On Thu, 25 Nov 2010, Jean Pihet wrote:
>
>> On Thu, Nov 25, 2010 at 12:49 AM, Paul Walmsley <paul@pwsan.com> wro=
te:
>> >
>> > The console semaphore must be held while the OMAP UART devices are
>> > disabled, lest a console write cause an ARM abort (and a kernel cr=
ash)
>> > when the underlying console device is inaccessible. =A0These crash=
es
>> > only occur when the console is on one of the OMAP internal serial
>> > ports.
>> This does not fix the issue for me on Beagle (console on ttyO2).
>>
>> Doing:
>> =A0 / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_time=
out
>> =A0 / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_time=
out
>> =A0 / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_time=
out
>> and waiting 5 seconds hangs the console.
>
> If this is without sleep_while_idle enabled, then you're seeing an
> unrelated bug that is not related to this patch. =A0That's because, w=
hen
> /debug/pm_debug/sleep_while_idle is 0, the pm34xx.c code that this pa=
tch
> touches won't be reached.
Ok so we still have a problem. I understood the correct fix is to
migrate the UART code to hwmod.

> By the way, you write that the above situation "hangs the console." =A0=
Is it
> just the case that the console dies and the rest of the system is sti=
ll
> alive, or does the whole system crash?
The console hangs, the rest of the system still runs.

>> However enabling sleep_while_idle before configuring the UART2 timeo=
ut
>> makes it work ok:
>> =A0 / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_time=
out
>> =A0 / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_time=
out
>> =A0 / # echo 1 > /debug/pm_debug/sleep_while_idle
>> =A0 / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_time=
out
>>
>> This result is similar to what I tested on a recent l-o master w/o t=
he fix.
>> Am I missing something?
>
> It may depend on your loglevel settings. =A0If warning messages aren'=
t
> emitted to the console, then you won't see this crash.
>
> Whether the system crashes also depends on whether you happen to get =
a new
> worst-case deactivation latency from your console serial port during =
PM
> idle. =A0If not, and there are no other console writes after the UART=
 is
> disabled, then this patch won't affect anything.
>
> Just FYI, without this patch, Tony's N810 crashed reliably upon enter=
ing
> dynamic idle.
'crashed reliably' ;p

>
>> One more remark. With OFF mode enabled I noticed that PER can go OFF
>> without CORE going OFF, which could trigger the errata i582. I think
>> this is another latent problem.
>
> This appears to be unrelated to the patch under discussion. =A0Maybe =
you
> should start a separate list thread on this issue? =A0We do not appea=
r to
> have the suggested workaround sequence in the TRM in the current code=
=2E
> This workaround is quite complex. =A0Someone from TI should definitel=
y put
> together some patches to implement it.
Yes this is unrelated, let's discuss this separately.

>
>
> - Paul

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
