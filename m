From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Beagle PM hangs
Date: Fri, 30 Jan 2009 16:40:37 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE89671620376E9A668@dlee02.ent.ti.com>
References: <345163910901280814nb847b34pca50f4ee6e49929d@mail.gmail.com>
 <87zlhbqtrv.fsf@deeprootsystems.com> <87skn3qq6x.fsf@deeprootsystems.com>
 <ABB3227E-1B40-47F0-BD79-FE974FDEF4CE@beagleboard.org>
 <13B9B4C6EF24D648824FF11BE89671620376E9A5E5@dlee02.ent.ti.com>
 <212700A7-C5FE-4CAA-BACF-7931D45C02CC@beagleboard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42637 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbZA3Wkp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 17:40:45 -0500
In-Reply-To: <212700A7-C5FE-4CAA-BACF-7931D45C02CC@beagleboard.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@beagleboard.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

> If you look at http://beagleboard.org/hardware it says "600Mhz"
> multiple times, so I'd expect the board to be running at 600MHz if I
> were a customer. If I read the TRM right I can run the cpu at 600MHz
> continuously for a few years, which exceeds the lifespan of most
> mobile products I have owned.
> So my real question is: why limit it in the kernel if all that's
> needed is a costum userspace governer?

In reference code all OPPs are modeled.  They all are just not exported to cpufreq.  Any driver or user space can peg the system to max opp.  There is nothing stopping anyone from hooking opp selection to cpufreq.  However, it does require a custom governor or a little policy script to set limits.  This is not the default in main line builds.  It could be pushed if someone wanted to do the work.

For the general testing and usage it is easy to just use ondemand.  It's a good general purpose governor.  There is no need to recreate it for general use.  Then treat special needs out of band.  If you want to create a new governor and can get a lot of people to use it then nothing is in the way but time to try and sell up stream people it is needed.

Initial design for customers required the ability to plug in custom managers which sit at the cpufreq level.  Not everyone in the world uses cpufreq for this kind of thing.  Because of this we purposefully kept separation.

Novice uses which just grab a kernel and take the root file system of the day will get it wrong.

Off hand I'm not sure which kernel level mechanism is blocking you in l-o.  I haven't had bandwidth to follow line by line.

Regards,
Richard W.

