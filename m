From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about
	serial stuff)
Date: Tue, 23 Oct 2012 11:10:36 +0100
Message-ID: <20121023101036.GA1542@n2100.arm.linux.org.uk>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57260 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932942Ab2JWKKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 06:10:40 -0400
Content-Disposition: inline
In-Reply-To: <20121012155434.GO28061@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

On Fri, Oct 12, 2012 at 04:54:34PM +0100, Russell King - ARM Linux wrote:
> For those who don't bother looking at my kautobuild boot tests on the OMAP
> boards I have, here's the errors which get spat out at boot time.  Note
> that some of these I've reported in the past, and one of them is missing
> a newline character at the end of its string.
> 
> twd: can't register interrupt 45 (-22)
> twd_local_timer_register failed -22
> omap_hwmod: mcpdm: cannot be enabled for reset (3)
> omap-gpmc omap-gpmc: error: clk_get
> omap-gpmc: probe of omap-gpmc failed with error -2
> Error setting wl12xx data: -38
> omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
> omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
> omap_hsmmc omap_hsmmc.4: Failed to get debounce clk
> twl6040-codec twl6040-codec: ASoC: Failed to create Capture debugfs file
> omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
> omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).Power Management for TI OMAP4.
> mmc1: host does not support reading read-only switch. assuming write-enable.

Here's the latest set of error like messages, thanks to the kautobuild
system:

omap_hwmod: mcpdm: cannot be enabled for reset (3)
Error setting wl12xx data: -38
omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
omap_hsmmc omap_hsmmc.4: Failed to get debounce clk
omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).Power Management for TI OMAP4.
mmc1: host does not support reading read-only switch. assuming write-enable.

This looks much better compared to the previous set, but we could still
do with getting a "\n" on at least one of those messages...
