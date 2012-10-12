From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Errors at boot time from OMAP4430SDP (and a whinge about serial
	stuff)
Date: Fri, 12 Oct 2012 16:54:34 +0100
Message-ID: <20121012155434.GO28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51457 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945918Ab2JLPyi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Oct 2012 11:54:38 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

For those who don't bother looking at my kautobuild boot tests on the OMAP
boards I have, here's the errors which get spat out at boot time.  Note
that some of these I've reported in the past, and one of them is missing
a newline character at the end of its string.

twd: can't register interrupt 45 (-22)
twd_local_timer_register failed -22
omap_hwmod: mcpdm: cannot be enabled for reset (3)
omap-gpmc omap-gpmc: error: clk_get
omap-gpmc: probe of omap-gpmc failed with error -2
Error setting wl12xx data: -38
omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
omap_hsmmc omap_hsmmc.4: Failed to get debounce clk
twl6040-codec twl6040-codec: ASoC: Failed to create Capture debugfs file
omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).Power Management for TI OMAP4.
mmc1: host does not support reading read-only switch. assuming write-enable.

As of today, I've rebased my serial changes as far forward as I dare at
the moment (to the commit before removal of DMA), and then merged it
into the latest trees from armsoc and myself, fixing up all the horrid
conflicts. I've finally got it to a stage where at least it compiles,
but unfortunately something has broken serial output from userspace
quite badly to the point that it doesn't work.

I know that my serial changes were fine before I tried rebasing them (the
set I posted to the mailing list certainly did work) so I suspect that
it's down to incompatibilities between the fixes done by others (who didn't
really understand all issues involved) and those done by myself.

Unfortunately, the series of patches to fix the register writes and bits
to enable hardware assisted software flow control which have gone into
mainline have actually made the situation much worse - now the hardware
can end up with IXANY stuck on, and no way to turn off hardware assisted
software flow control - which is bad news for binary serial protocols.
It would have been far better to leave the driver as-is - at least the
software flow control would have been dealt correctly by the generic tty
layer.  Instead, we have a worse situation today...

While I may be the ex-maintainer of serial-core, given that I had already
investigated the issues there and had an understanding of the problems,
-and that was known-, copying me with the patches before they went into
mainline would've been the decent thing to have done, so that someone
with the knowledge of the breakage could have said "yes lets take those
patches" and "no, those shouldn't go in because it'll cause breakage"
such as I describe above.

I know how this situation arose; TI are desperate to get rid of the legacy
OMAP DMA API, and wanted me to look at the crypto drivers for DMA engine
support.  In the mean time, they silently took the serial issues away from
me and gave them other people to look at.  Reality is, I could have sorted
out the serial issues while I wait for responses from Dan Williams on the
async tx API issues.

Eventually, I got bored of waiting for Dan's responses, that I looked at
the serial issues anyway, and produced _my_ patch set which fixes the
issues _properly_, so at least I can say that I had done something producive.
The sad thing is, most of that is now having to be reworked to sort out an
entirely new set of problems caused by TI's attitude towards this stuff,
and this rework is consuming a lot more time than it needed to.

As for Dan, an update for the situation from Monday's call.  I have a reply
to my email I sent during that call, and Dan is looking at getting back up
to speed with DMA engine stuff - but he no longer has the hardware.  He
seems to want to keep hold of the responsibility for that, so I think we're
rather stuck at the moment over anything OMAP which uses the crypto stuff.

That's fine for the time being; the schedule for the removal of the legacy
OMAP DMA stuff that I put into feature-removal.txt says "2013" and I _never_
intended that to mean the start of 2013.
