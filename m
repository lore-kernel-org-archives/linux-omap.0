From: Kevin Hilman <khilman@ti.com>
Subject: Re: cpuidle status in mainline for Beagleboard xM
Date: Tue, 06 Sep 2011 14:04:29 -0700
Message-ID: <87pqjd1ixu.fsf@ti.com>
References: <CACKLOr10aTCwkBZnSinvP4HLPhrJeiBs=6KM2we4DwTT0NJ22A@mail.gmail.com>
	<87vctcjo2w.fsf@ti.com>
	<CACKLOr0KpCUXrXM7M9YvE3DGPbGjzT4N678eEPfx_GGE7+40-w@mail.gmail.com>
	<87ei00f94i.fsf@ti.com> <4E607241.8000704@bitmer.com>
	<CACKLOr1h23n-dSCZ6Dqzo_EW_6fyieZodCKfXFmn7i2tL=hQCQ@mail.gmail.com>
	<87fwke989o.fsf@ti.com>
	<CACKLOr17HpyBmRjBKmUZMORzPJGSsu5Nf1SE=8MeWL7T2yc56A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:52100 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751868Ab1IFVEe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Sep 2011 17:04:34 -0400
Received: by mail-gy0-f173.google.com with SMTP id 12so4665954gyd.4
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 14:04:32 -0700 (PDT)
In-Reply-To: <CACKLOr17HpyBmRjBKmUZMORzPJGSsu5Nf1SE=8MeWL7T2yc56A@mail.gmail.com>
	(javier Martin's message of "Mon, 5 Sep 2011 10:04:56 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, Koen Kooi <koen@beagleboard.org>

javier Martin <javier.martin@vista-silicon.com> writes:

> On 2 September 2011 19:14, Kevin Hilman <khilman@ti.com> wrote:
>> javier Martin <javier.martin@vista-silicon.com> writes:
>>
>>> On 2 September 2011 08:05, Jarkko Nikula <jarkko.nikula@bitmer.com>=
 wrote:
>>>> Other usual things to check that display is off (echo 1 >
>>>> /sys/class/graphics/fb0/blank) and no cable to musb/otg port.
>>>>
>>>> Haven't tried myself with recent kernel but does EHCI and hub on X=
M let to
>>>> idle cpu at all? At least on one board having on-board hub I had t=
o disable
>>>> or unload ehci module in order to hit the retention.
>>>>
>>>
>>> I've checked that too and I've even disabled USB support in the ker=
nel
>>> just to be sure. But still nothing:
>>>
>>> root@beagleboard:~# powertop -d -t 100
>>> PowerTOP 1.12 =C2=A0 (C) 2007, 2008 Intel Corporation
>>>
>>> Collecting data for 100 seconds
>>>
>>>
>>> Cn =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Avg resid=
ency
>>> C0 (cpu running) =C2=A0 =C2=A0 =C2=A0 =C2=A0( 0.0%)
>>> C0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 58.5ms (100.0%)
>>> C1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.0ms ( 0=
=2E0%)
>>> C2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.0ms ( 0=
=2E0%)
>>> C3 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.0ms ( 0=
=2E0%)
>>> C4 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.0ms ( 0=
=2E0%)
>>> C5 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.0ms ( 0=
=2E0%)
>>> C6 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.0ms ( 0=
=2E0%)
>>>
>>> Even when CPU has been idle 100% of the time it doesn't hit any sta=
te
>>> deeper than C0.
>>
>> Did you allow the UARTs to idle:
>
> Yes I did:
> root@beagleboard:/sys/devices/system/cpu/cpu0/cpuidle# echo 5 >
> /sys/devices/platform/omap/omap_uart.0/sleep_timeout
> root@beagleboard:/sys/devices/system/cpu/cpu0/cpuidle# echo 5 >
> /sys/devices/platform/omap/omap_uart.1/sleep_timeout
> root@beagleboard:/sys/devices/system/cpu/cpu0/cpuidle# echo 5 >
> /sys/devices/platform/omap/omap_uart.2/sleep_timeout
> root@beagleboard:/sys/devices/system/cpu/cpu0/cpuidle# echo 5 >
> /sys/devices/platform/omap/omap_uart.3/sleep_timeout
>
> [   65.853820] omap_device: omap_uart.3: new worst case activate
> latency 0: 30517
> [   65.944366] omap_device: omap_uart.2: new worst case deactivate
> latency 0: 30517
>
>
>> # UART timeouts: omap-serial (4th UART only on OMAP36xx and OMAP4)
>> echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
>> echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
>> echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
>> echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout
>>
>> I just tested this using today's linux-omap master branch (+ merged
>> v3.1-rc4 which includes a fix for a bootup problem.)
>>
>> I booted my Beagle XM with a busybox rootfs on MMC and it worked fin=
e
>> for me.
>>
>> I don't have powertop on the rootfs, but I manually dumped the sysfs
>> files that powertop reads, so I can see the state times.
>>
>> After allowing the UARTs to idle, I see:
>>
>> # cd /sys/devices/system/cpu/cpu0
>> /sys/devices/system/cpu/cpu0/cpuidle # cat state?/time
>> 43531831
>> 8997
>> 157215
>> 0
>> 3467925
>> 0
>> 0
>
> OK, I've just tried with the same kernel as you did (linux-omap maste=
r
> +  v3.1-rc4 merge) and I can't get any other state than 0:

> Just one question. Do you access the shell through UART?

Yes.

> What I do is waiting for 20 seconds to allow the UART to suspend and
> then see state reports.

Then I suspect your userspace is keeping the system active.

Can you try to just boot a minimal userspace (e.g. append init=3D/bin/s=
h
to your kernel command line, or use a basic busybox rootfs.)

Keivn
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
