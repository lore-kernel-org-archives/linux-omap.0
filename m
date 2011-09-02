From: Kevin Hilman <khilman@ti.com>
Subject: Re: cpuidle status in mainline for Beagleboard xM
Date: Fri, 02 Sep 2011 10:14:11 -0700
Message-ID: <87fwke989o.fsf@ti.com>
References: <CACKLOr10aTCwkBZnSinvP4HLPhrJeiBs=6KM2we4DwTT0NJ22A@mail.gmail.com>
	<87vctcjo2w.fsf@ti.com>
	<CACKLOr0KpCUXrXM7M9YvE3DGPbGjzT4N678eEPfx_GGE7+40-w@mail.gmail.com>
	<87ei00f94i.fsf@ti.com> <4E607241.8000704@bitmer.com>
	<CACKLOr1h23n-dSCZ6Dqzo_EW_6fyieZodCKfXFmn7i2tL=hQCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53321 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753587Ab1IBROP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 13:14:15 -0400
Received: by mail-gx0-f173.google.com with SMTP id 26so2598841gxk.32
        for <linux-omap@vger.kernel.org>; Fri, 02 Sep 2011 10:14:14 -0700 (PDT)
In-Reply-To: <CACKLOr1h23n-dSCZ6Dqzo_EW_6fyieZodCKfXFmn7i2tL=hQCQ@mail.gmail.com>
	(javier Martin's message of "Fri, 2 Sep 2011 09:23:52 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, Koen Kooi <koen@beagleboard.org>

javier Martin <javier.martin@vista-silicon.com> writes:

> On 2 September 2011 08:05, Jarkko Nikula <jarkko.nikula@bitmer.com> wrote:
>> Other usual things to check that display is off (echo 1 >
>> /sys/class/graphics/fb0/blank) and no cable to musb/otg port.
>>
>> Haven't tried myself with recent kernel but does EHCI and hub on XM let to
>> idle cpu at all? At least on one board having on-board hub I had to disable
>> or unload ehci module in order to hit the retention.
>>
>
> I've checked that too and I've even disabled USB support in the kernel
> just to be sure. But still nothing:
>
> root@beagleboard:~# powertop -d -t 100
> PowerTOP 1.12   (C) 2007, 2008 Intel Corporation
>
> Collecting data for 100 seconds
>
>
> Cn                Avg residency
> C0 (cpu running)        ( 0.0%)
> C0               58.5ms (100.0%)
> C1                0.0ms ( 0.0%)
> C2                0.0ms ( 0.0%)
> C3                0.0ms ( 0.0%)
> C4                0.0ms ( 0.0%)
> C5                0.0ms ( 0.0%)
> C6                0.0ms ( 0.0%)
>
> Even when CPU has been idle 100% of the time it doesn't hit any state
> deeper than C0.

Did you allow the UARTs to idle:

# UART timeouts: omap-serial (4th UART only on OMAP36xx and OMAP4)
echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout               
echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout               
echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout               
echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout               

I just tested this using today's linux-omap master branch (+ merged
v3.1-rc4 which includes a fix for a bootup problem.)

I booted my Beagle XM with a busybox rootfs on MMC and it worked fine
for me.

I don't have powertop on the rootfs, but I manually dumped the sysfs
files that powertop reads, so I can see the state times.

After allowing the UARTs to idle, I see:

# cd /sys/devices/system/cpu/cpu0
/sys/devices/system/cpu/cpu0/cpuidle # cat state?/time                          
43531831                                                                        
8997                                                                            
157215                                                                          
0                                                                               
3467925                                                                         
0                                                                               
0                                                                               


Kevin
