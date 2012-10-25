From: Tony Lindgren <tony@atomide.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about
 serial stuff)
Date: Wed, 24 Oct 2012 18:09:17 -0700
Message-ID: <20121025010917.GL11928@atomide.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
 <20121023101036.GA1542@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10613 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757332Ab2JYBJU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 21:09:20 -0400
Content-Disposition: inline
In-Reply-To: <20121023101036.GA1542@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [121023 03:12]:
> On Fri, Oct 12, 2012 at 04:54:34PM +0100, Russell King - ARM Linux wrote:
> > For those who don't bother looking at my kautobuild boot tests on the OMAP
> > boards I have, here's the errors which get spat out at boot time.  Note
> > that some of these I've reported in the past, and one of them is missing
> > a newline character at the end of its string.
> > 
> > twd: can't register interrupt 45 (-22)
> > twd_local_timer_register failed -22
> > omap_hwmod: mcpdm: cannot be enabled for reset (3)
> > omap-gpmc omap-gpmc: error: clk_get
> > omap-gpmc: probe of omap-gpmc failed with error -2
> > Error setting wl12xx data: -38
> > omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
> > omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
> > omap_hsmmc omap_hsmmc.4: Failed to get debounce clk
> > twl6040-codec twl6040-codec: ASoC: Failed to create Capture debugfs file
> > omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
> > omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).Power Management for TI OMAP4.
> > mmc1: host does not support reading read-only switch. assuming write-enable.
> 
> Here's the latest set of error like messages, thanks to the kautobuild
> system:
> 
> omap_hwmod: mcpdm: cannot be enabled for reset (3)
> Error setting wl12xx data: -38

That's now fixed up and I've queued it.

> omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
> omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
> omap_hsmmc omap_hsmmc.4: Failed to get debounce clk
> omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
> omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).Power Management for TI OMAP4.
> mmc1: host does not support reading read-only switch. assuming write-enable.
> 
> This looks much better compared to the previous set, but we could still
> do with getting a "\n" on at least one of those messages...

Kevin, do you have a patch for some of this?

Regards,

Tony
