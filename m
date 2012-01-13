From: Paul Walmsley <paul@pwsan.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 13 Jan 2012 16:06:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201131543580.3659@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown> <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
 <87hazzquhb.fsf@ti.com> <87lipbp6uq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51756 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab2AMXG2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 18:06:28 -0500
In-Reply-To: <87lipbp6uq.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

On Fri, 13 Jan 2012, Kevin Hilman wrote:

> Kevin Hilman <khilman@ti.com> writes:
> 
> [...]
> 
> >> From: Paul Walmsley <paul@pwsan.com>
> >> Date: Fri, 13 Jan 2012 02:10:30 -0700
> >> Subject: [PATCH] ARM: OMAP3: PM: allow MPU to enter low-power states even
> >>  when the UART is active
> >>
> >> For some reason, both the existing OMAP3 PM code and the OMAP3 CPUIdle
> >> driver prevent the MPU powerdomain from entering low-power modes when
> >> any UART isn't asleep.  Possibly it is intended to minimize the ARM
> >> wakeup latency when UART activity arrives, but the UART has a FIFO
> >> that should handle this for most cases, with no dropped characters.  I
> >> may be forgetting something important, though.  And CORE/PER low-power
> >> states are a different matter entirely.
> >
> > Just FYI... the UART can_sleep hackery was removed for v3.3 and replaced
> > by using a PM QoS constraint:
> 
> However, looking closer I see now that the constraint being used in the
> mailine driver uses the CPU_DMA_LATENCY QoS constraint, which is preventing 
> deeper C states as well just like the current code (before your patch),
> so an similar fix will still be needed for mainline.

Hmm.  This is the following code in serial_omap_set_termios() ? 

	/* calculate wakeup latency constraint */
	up->calc_latency = (1000000 * up->port.fifosize) /
				(1000 * baud / 8);
	up->latency = up->calc_latency;
	schedule_work(&up->qos_work);

Let's work out this formula for 115.2kbps:

(1000000 * 16) / (1000 * 115200 / 8)

= 16000000 / 14400000

= 1.11...  (presumably the unit here is milliseconds)

= 1 (since up->calc_latency is a u32)

Then up->calc_latency is passed to pm_qos_update_request().  According to 
Documentation/power/pm_qos_interface.txt, it is expecting microseconds.
So that's one problem.  To fix that it should be 

        up->calc_latency = (1000000 * up->port.fifosize) /
                                (baud / 8);

With that change, it should be possible to enter C3, with the timings that 
are in the mainline cpuidle34xx.c.


- Paul
