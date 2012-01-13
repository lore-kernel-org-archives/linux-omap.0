From: Paul Walmsley <paul@pwsan.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 13 Jan 2012 16:39:37 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201131637560.3659@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown> <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
 <87hazzquhb.fsf@ti.com> <87lipbp6uq.fsf@ti.com> <alpine.DEB.2.00.1201131543580.3659@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57881 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173Ab2AMXji (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 18:39:38 -0500
In-Reply-To: <alpine.DEB.2.00.1201131543580.3659@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

On Fri, 13 Jan 2012, Paul Walmsley wrote:

> Let's work out this formula for 115.2kbps:
> 
> (1000000 * 16) / (1000 * 115200 / 8)
> 
> = 16000000 / 14400000
> 
> = 1.11...  (presumably the unit here is milliseconds)
> 
> = 1 (since up->calc_latency is a u32)
> 
> Then up->calc_latency is passed to pm_qos_update_request().  According to 
> Documentation/power/pm_qos_interface.txt, it is expecting microseconds.
> So that's one problem.  To fix that it should be 
> 
>         up->calc_latency = (1000000 * up->port.fifosize) /
>                                 (baud / 8);
> 
> With that change, it should be possible to enter C3, with the timings that 
> are in the mainline cpuidle34xx.c.

Actually, just noticed that the fifosize is 60 bytes.  So that's even 
better.  With the fixed formula above, it should be ~ 5.2 ms wakeup 
latency - enough to enter C4 in the CPUIdle data in mainline -- at least 
in theory...


- Paul
