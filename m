From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: cpuidle status in mainline for Beagleboard xM
Date: Fri, 2 Sep 2011 09:23:52 +0200
Message-ID: <CACKLOr1h23n-dSCZ6Dqzo_EW_6fyieZodCKfXFmn7i2tL=hQCQ@mail.gmail.com>
References: <CACKLOr10aTCwkBZnSinvP4HLPhrJeiBs=6KM2we4DwTT0NJ22A@mail.gmail.com>
	<87vctcjo2w.fsf@ti.com>
	<CACKLOr0KpCUXrXM7M9YvE3DGPbGjzT4N678eEPfx_GGE7+40-w@mail.gmail.com>
	<87ei00f94i.fsf@ti.com>
	<4E607241.8000704@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:40680 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755718Ab1IBHXx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 03:23:53 -0400
Received: by yie30 with SMTP id 30so1998507yie.19
        for <linux-omap@vger.kernel.org>; Fri, 02 Sep 2011 00:23:53 -0700 (PDT)
In-Reply-To: <4E607241.8000704@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Koen Kooi <koen@beagleboard.org>

On 2 September 2011 08:05, Jarkko Nikula <jarkko.nikula@bitmer.com> wrote:
> Other usual things to check that display is off (echo 1 >
> /sys/class/graphics/fb0/blank) and no cable to musb/otg port.
>
> Haven't tried myself with recent kernel but does EHCI and hub on XM let to
> idle cpu at all? At least on one board having on-board hub I had to disable
> or unload ehci module in order to hit the retention.
>

I've checked that too and I've even disabled USB support in the kernel
just to be sure. But still nothing:

root@beagleboard:~# powertop -d -t 100
PowerTOP 1.12   (C) 2007, 2008 Intel Corporation

Collecting data for 100 seconds


Cn                Avg residency
C0 (cpu running)        ( 0.0%)
C0               58.5ms (100.0%)
C1                0.0ms ( 0.0%)
C2                0.0ms ( 0.0%)
C3                0.0ms ( 0.0%)
C4                0.0ms ( 0.0%)
C5                0.0ms ( 0.0%)
C6                0.0ms ( 0.0%)

Even when CPU has been idle 100% of the time it doesn't hit any state
deeper than C0.


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
