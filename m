From: Tony Lindgren <tony@atomide.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about
 serial stuff)
Date: Fri, 12 Oct 2012 09:24:52 -0700
Message-ID: <20121012162452.GD30339@atomide.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:19246 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754175Ab2JLQY4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Oct 2012 12:24:56 -0400
Content-Disposition: inline
In-Reply-To: <20121012155434.GO28061@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Afzal Mohammed <afzal@ti.com>, =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [121012 08:56]:
> For those who don't bother looking at my kautobuild boot tests on the OMAP
> boards I have, here's the errors which get spat out at boot time.  Note
> that some of these I've reported in the past, and one of them is missing
> a newline character at the end of its string.

Thanks, let's get those fixed ASAP.
 
> twd: can't register interrupt 45 (-22)
> twd_local_timer_register failed -22

Hmm I think this regression was caused by my sparse IRQ changes,
looks like I have a typo using OMAP_INTC_START in stead of the
GIC base. Will do a patch for this.

> omap_hwmod: mcpdm: cannot be enabled for reset (3)

Paul, Benoit, care to take a look at this?

> omap-gpmc omap-gpmc: error: clk_get
> omap-gpmc: probe of omap-gpmc failed with error -2

I think Afzal posted something about this already? Looks
like this too could be sparse IRQ related regression..

> Error setting wl12xx data: -38

Hmm I wonder if wl12xx_set_platform_data() is really
supposed to return -EBUSY if platform_data exists?
Ohad, can you please take a look?

> omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
> omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
> omap_hsmmc omap_hsmmc.4: Failed to get debounce clk

These should be optional AFAIK, so no warning should be
printed.

> twl6040-codec twl6040-codec: ASoC: Failed to create Capture debugfs file

Peter, can you take a look please?

> omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
> omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).Power Management for TI OMAP4.

Kevin?

> mmc1: host does not support reading read-only switch. assuming write-enable.

This too should be optional.
 
> As of today, I've rebased my serial changes as far forward as I dare at
> the moment (to the commit before removal of DMA), and then merged it
> into the latest trees from armsoc and myself, fixing up all the horrid
> conflicts. I've finally got it to a stage where at least it compiles,
> but unfortunately something has broken serial output from userspace
> quite badly to the point that it doesn't work.
> 
> I know that my serial changes were fine before I tried rebasing them (the
> set I posted to the mailing list certainly did work) so I suspect that
> it's down to incompatibilities between the fixes done by others (who didn't
> really understand all issues involved) and those done by myself.

Have you been able to locate the breaking patches, maybe those could
be reverted?

Regards,

Tony
