From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-omap3-2.6.39: spurious irq 95, during heavy SD card load
Date: Thu, 3 Nov 2011 12:37:32 -0700
Message-ID: <20111103193732.GY31337@atomide.com>
References: <loom.20111103T103055-675@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17082 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756479Ab1KCThe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 15:37:34 -0400
Content-Disposition: inline
In-Reply-To: <loom.20111103T103055-675@post.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manfred <manfred@student.ethz.ch>
Cc: linux-omap@vger.kernel.org

* Manfred <manfred@student.ethz.ch> [111103 02:15]:
> Dear users/developers, 
> 
> I am trying to install the xenomai real-time linux on a gumstix overo fire with
> an omap3530. 
> After some starting problems, I succeed to patch the 2.6.33 kernel and run some
> latency tests
>  with normal worst case latencies ~60us. However, the overall worst case latency
> is very bad (5ms), 
> because i occasionally get spurious interrupt errors like this:
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 86
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 86
...

> Or is there a specific patch to resolve this?
> I was not able to reproduce this on the NAND-flash, 
> but it is also to small to make large continous data transfers. 

What the warnings mean is that the ack for irq86 did not reach
the hardware before that interrupt got unmasked again.

To fix this, find the irq handler for irq86, and add a readback
of the interrupt status register or revision register to the
interrupt handler right after the write acking the interrupt.

To see some examples, please do:

$ grep -ri "flush posted write" drivers/

Regards,

Tony
