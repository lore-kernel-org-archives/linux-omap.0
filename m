From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] OMAP3: beagle xm: enable upto 800MHz OPP
Date: Thu, 06 Jan 2011 07:44:37 -0600
Message-ID: <4D25C745.7060600@ti.com>
References: <1294260576-20237-1-git-send-email-nm@ti.com>	<1294260576-20237-3-git-send-email-nm@ti.com> <874o9nvskt.fsf@ti.com> <4D25B482.3080709@ti.com> <579AA000-EB86-4DD3-B3B7-29F7A72E0415@beagleboard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:54911 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751547Ab1AFNol (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 08:44:41 -0500
Received: by yie21 with SMTP id 21so5111260yie.4
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 05:44:40 -0800 (PST)
In-Reply-To: <579AA000-EB86-4DD3-B3B7-29F7A72E0415@beagleboard.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@beagleboard.org>
Cc: Kevin Hilman <khilman@ti.com>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>

Koen Kooi had written, on 01/06/2011 07:00 AM, the following:
> Op 6 jan 2011, om 13:24 heeft Nishanth Menon het volgende geschreven:
> 
>> Kevin Hilman wrote, on 01/05/2011 05:28 PM:
>>> Nishanth Menon<nm@ti.com>  writes:
>>>
>>>> Beagle XM uses 3730 and the board design allows enabling 800MHz and 1GHz
>>>> OPPs. However, We need Smart reflex class 1.5 and ABB to enable 1GHz safely.
>>>> For the moment, we tweak the default table to allow for 800Mhz OPP usage.
>>> Isn't this common to any board using 3730 (or 3630?)
>> no it is not. only certain boards are capable of higher frequencies - there is a procedure called PDN analysis and vmin search that needs to be performed to guarentee this.
> 
> What about the "new" 3530s that can run at 720MHz? Those have been speed binned and given a different SKU. I'm using the attached 4 patches (Tony master + beagle patches _+ dvfs: http://dominion.thruhere.net/git/cgit.cgi/linux-omap/log/?h=koen/beagle-next) on my beagle C4 and overo tide to get 720MHz. They don't really work:
for 3530, keep in mind that not *all* boards can support 720MHz (esp the 
old 3430 boards, like my poor SDP3430).
since we consider 3530 as 3430 as well, add a default disabled 720MHz 
OPP in the 3430 table and enable it:
a) if this has anything to do with board behavior (which, unlike 36xx, I 
dont think is the case for 35xx), enable similar to this patch on the 
required boards on a need basis (e.g. based on board rev)
b) if this is a silicon behavior, then, you should modify the 
omap3_opp_init to ensure that for the right silicon this is enabled 
(e.g. only for 3530 rev X onwards or something similar) - but you will 
need some way to detect it in s/w (not through bootargs please!)

> 
> root@usrp-e1xx:~# cpufreq-set -f 720000
> [  104.976318] platform iva.0: omap_voltage_scale: Already at the requestedrate 430000000
> [  104.986236] platform mpu.0: omap_voltage_scale: Already at the requestedrate 600000000
> [  104.996032] platform iva.0: omap_voltage_scale: Already at the requestedrate 430000000
> [  105.006408] platform mpu.0: omap_voltage_scale: Already at the requestedrate 600000000
This is coz we dont have 720MHz and max enabled freq is 600MHz so it 
falls back to that freq.

> 
> But:
> 
> root@usrp-e1xx:~# dmesg | grep 720
> [    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp 720mhz )
> [    0.000000] Kernel command line: console=ttyO2,115200n8 mpurate=720 vram=16M mem=99M@0x80000000 mem=384M@0x88000000 omapfb.mode=dvi:1024x768MR-24@60 omapfb.vram=0:8M,1:4M,2:4M omapdss.def_disp=dvi root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait
> [    0.000000] overo_opp_init: 720MHz MPU OPPs enabled!
> [    0.000000] Switched to new clocking rate (Crystal/Core/MPU): 26.0/224/720 MHz
> 
> 
> root@usrp-e1xx:~# cpufreq-info 
> cpufrequtils 006: cpufreq-info (C) Dominik Brodowski 2004-2009
> Report errors and bugs to cpufreq@vger.kernel.org, please.
> analyzing CPU 0:
>   driver: omap
>   CPUs which run at the same hardware frequency: 0
>   CPUs which need to have their frequency coordinated by software: 0
>   maximum transition latency: 300 us.
>   hardware limits: 125 MHz - 720 MHz
>   available frequency steps: 125 MHz, 250 MHz, 500 MHz, 550 MHz, 600 MHz, 720 MHz
>   available cpufreq governors: conservative, ondemand, userspace, powersave, performance
>   current policy: frequency should be within 125 MHz and 720 MHz.
>                   The governor "userspace" may decide which speed to use
>                   within this range.
>   current CPU frequency is 600 MHz (asserted by call to hardware).
>   cpufreq stats: 125 MHz:0.00%, 250 MHz:0.00%, 500 MHz:0.00%, 550 MHz:0.00%, 600 MHz:100.00%, 720 MHz:0.00%  (1)
> 
> So how do I "properly" get 720MHz on those parts?

as discussed above.

-- 
Regards,
Nishanth Menon
