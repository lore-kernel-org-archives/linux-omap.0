From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Beagle PM hangs
Date: Fri, 30 Jan 2009 16:49:34 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE89671620376E9A684@dlee02.ent.ti.com>
References: <345163910901280814nb847b34pca50f4ee6e49929d@mail.gmail.com>
	<87zlhbqtrv.fsf@deeprootsystems.com>	<87skn3qq6x.fsf@deeprootsystems.com>
	<ABB3227E-1B40-47F0-BD79-FE974FDEF4CE@beagleboard.org>
	<13B9B4C6EF24D648824FF11BE89671620376E9A5E5@dlee02.ent.ti.com>
	<212700A7-C5FE-4CAA-BACF-7931D45C02CC@beagleboard.org>
 <87y6wsh100.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42653 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004AbZA3Wtn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 17:49:43 -0500
In-Reply-To: <87y6wsh100.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Koen Kooi <koen@beagleboard.org>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

>In fact, you wouldn't even need a custom governor.
> To avoid governor picking overdrive OPP:
>
> # echo 550000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
>
> To allow overdrive:
>
> # echo 600000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

Sure. Now is someone going to fix up every root file system which users have around.

It would be better to init the limit in the driver for this version of OMAP.

Even if you do that someone still needs to turn on and off the limit dynamically or create a custom governor.

Until that kind of smart control is pervasive it is safer to just put the interface a layer down for expert use.

But like I was saying, people are free to set the clock to what ever they want.  On a properly characterized part it might even be safe for many years.  A 3440 will sit well above 600MHz in nominal.

Regards,
Richard W.
