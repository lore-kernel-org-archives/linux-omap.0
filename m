From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: cpuidle status in mainline for Beagleboard xM
Date: Mon, 5 Sep 2011 10:04:56 +0200
Message-ID: <CACKLOr17HpyBmRjBKmUZMORzPJGSsu5Nf1SE=8MeWL7T2yc56A@mail.gmail.com>
References: <CACKLOr10aTCwkBZnSinvP4HLPhrJeiBs=6KM2we4DwTT0NJ22A@mail.gmail.com>
	<87vctcjo2w.fsf@ti.com>
	<CACKLOr0KpCUXrXM7M9YvE3DGPbGjzT4N678eEPfx_GGE7+40-w@mail.gmail.com>
	<87ei00f94i.fsf@ti.com>
	<4E607241.8000704@bitmer.com>
	<CACKLOr1h23n-dSCZ6Dqzo_EW_6fyieZodCKfXFmn7i2tL=hQCQ@mail.gmail.com>
	<87fwke989o.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41855 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab1IEIE7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 04:04:59 -0400
Received: by iabu26 with SMTP id u26so6078669iab.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 01:04:58 -0700 (PDT)
In-Reply-To: <87fwke989o.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, Koen Kooi <koen@beagleboard.org>

On 2 September 2011 19:14, Kevin Hilman <khilman@ti.com> wrote:
> javier Martin <javier.martin@vista-silicon.com> writes:
>
>> On 2 September 2011 08:05, Jarkko Nikula <jarkko.nikula@bitmer.com> =
wrote:
>>> Other usual things to check that display is off (echo 1 >
>>> /sys/class/graphics/fb0/blank) and no cable to musb/otg port.
>>>
>>> Haven't tried myself with recent kernel but does EHCI and hub on XM=
 let to
>>> idle cpu at all? At least on one board having on-board hub I had to=
 disable
>>> or unload ehci module in order to hit the retention.
>>>
>>
>> I've checked that too and I've even disabled USB support in the kern=
el
>> just to be sure. But still nothing:
>>
>> root@beagleboard:~# powertop -d -t 100
>> PowerTOP 1.12 =A0 (C) 2007, 2008 Intel Corporation
>>
>> Collecting data for 100 seconds
>>
>>
>> Cn =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Avg residency
>> C0 (cpu running) =A0 =A0 =A0 =A0( 0.0%)
>> C0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 58.5ms (100.0%)
>> C1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00.0ms ( 0.0%)
>> C2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00.0ms ( 0.0%)
>> C3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00.0ms ( 0.0%)
>> C4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00.0ms ( 0.0%)
>> C5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00.0ms ( 0.0%)
>> C6 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00.0ms ( 0.0%)
>>
>> Even when CPU has been idle 100% of the time it doesn't hit any stat=
e
>> deeper than C0.
>
> Did you allow the UARTs to idle:

Yes I did:
root@beagleboard:/sys/devices/system/cpu/cpu0/cpuidle# echo 5 >
/sys/devices/platform/omap/omap_uart.0/sleep_timeout
root@beagleboard:/sys/devices/system/cpu/cpu0/cpuidle# echo 5 >
/sys/devices/platform/omap/omap_uart.1/sleep_timeout
root@beagleboard:/sys/devices/system/cpu/cpu0/cpuidle# echo 5 >
/sys/devices/platform/omap/omap_uart.2/sleep_timeout
root@beagleboard:/sys/devices/system/cpu/cpu0/cpuidle# echo 5 >
/sys/devices/platform/omap/omap_uart.3/sleep_timeout

[   65.853820] omap_device: omap_uart.3: new worst case activate
latency 0: 30517
[   65.944366] omap_device: omap_uart.2: new worst case deactivate
latency 0: 30517


> # UART timeouts: omap-serial (4th UART only on OMAP36xx and OMAP4)
> echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout
>
> I just tested this using today's linux-omap master branch (+ merged
> v3.1-rc4 which includes a fix for a bootup problem.)
>
> I booted my Beagle XM with a busybox rootfs on MMC and it worked fine
> for me.
>
> I don't have powertop on the rootfs, but I manually dumped the sysfs
> files that powertop reads, so I can see the state times.
>
> After allowing the UARTs to idle, I see:
>
> # cd /sys/devices/system/cpu/cpu0
> /sys/devices/system/cpu/cpu0/cpuidle # cat state?/time
> 43531831
> 8997
> 157215
> 0
> 3467925
> 0
> 0

OK, I've just tried with the same kernel as you did (linux-omap master
+  v3.1-rc4 merge) and I can't get any other state than 0:

root@beagleboard:/sys/devices/system/cpu/cpu0/cpuidle# cat state?/time
162570397
0
0
0
0
0
0


Just one question. Do you access the shell through UART?

What I do is waiting for 20 seconds to allow the UART to suspend and
then see state reports.


--=20
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
