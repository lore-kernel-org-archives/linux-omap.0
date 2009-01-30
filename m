From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Beagle PM hangs
Date: Fri, 30 Jan 2009 15:21:57 -0800
Message-ID: <87pri4gz1m.fsf@deeprootsystems.com>
References: <345163910901280814nb847b34pca50f4ee6e49929d@mail.gmail.com>
	<87zlhbqtrv.fsf@deeprootsystems.com>
	<87skn3qq6x.fsf@deeprootsystems.com>
	<ABB3227E-1B40-47F0-BD79-FE974FDEF4CE@beagleboard.org>
	<13B9B4C6EF24D648824FF11BE89671620376E9A5E5@dlee02.ent.ti.com>
	<212700A7-C5FE-4CAA-BACF-7931D45C02CC@beagleboard.org>
	<87y6wsh100.fsf@deeprootsystems.com>
	<13B9B4C6EF24D648824FF11BE89671620376E9A684@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:38125 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105AbZA3XWB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 18:22:01 -0500
Received: by rv-out-0506.google.com with SMTP id k40so667396rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2009 15:22:00 -0800 (PST)
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620376E9A684@dlee02.ent.ti.com> (Richard Woodruff's message of "Fri\, 30 Jan 2009 16\:49\:34 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Koen Kooi <koen@beagleboard.org>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

"Woodruff, Richard" <r-woodruff2@ti.com> writes:

>>In fact, you wouldn't even need a custom governor.
>> To avoid governor picking overdrive OPP:
>>
>> # echo 550000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
>>
>> To allow overdrive:
>>
>> # echo 600000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
>
> Sure. Now is someone going to fix up every root file system which users have around.

I'm not suggesting this as the standard way.  The point was to say
that a custom governor is not the only way.

> It would be better to init the limit in the driver for this version of OMAP.

Agreed.

CPUfreq policy is just as easily set in the kernel at init time.  Then
the default would be set right, and the rootfs would be left to change
it if desired.

Kevin

> Even if you do that someone still needs to turn on and off the limit
> dynamically or create a custom governor.
>
> Until that kind of smart control is pervasive it is safer to just put the interface a layer down for expert use.
>
> But like I was saying, people are free to set the clock to what ever they want.  On a properly characterized part it might even be safe for many years.  A 3440 will sit well above 600MHz in nominal.
>
> Regards,
> Richard W.
