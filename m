From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about serial stuff)
Date: Thu, 25 Oct 2012 10:24:20 -0700
Message-ID: <87d30631ob.fsf@deeprootsystems.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
	<20121023101036.GA1542@n2100.arm.linux.org.uk>
	<20121025010917.GL11928@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40545 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935912Ab2JYRXu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 13:23:50 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2164170pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 10:23:50 -0700 (PDT)
In-Reply-To: <20121025010917.GL11928@atomide.com> (Tony Lindgren's message of
	"Wed, 24 Oct 2012 18:09:17 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tero Kristo <t-kristo@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [121023 03:12]:
>> On Fri, Oct 12, 2012 at 04:54:34PM +0100, Russell King - ARM Linux wrote:
>> > For those who don't bother looking at my kautobuild boot tests on the OMAP
>> > boards I have, here's the errors which get spat out at boot time.  Note
>> > that some of these I've reported in the past, and one of them is missing
>> > a newline character at the end of its string.
>> > 
>> > twd: can't register interrupt 45 (-22)
>> > twd_local_timer_register failed -22
>> > omap_hwmod: mcpdm: cannot be enabled for reset (3)
>> > omap-gpmc omap-gpmc: error: clk_get
>> > omap-gpmc: probe of omap-gpmc failed with error -2
>> > Error setting wl12xx data: -38
>> > omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
>> > omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
>> > omap_hsmmc omap_hsmmc.4: Failed to get debounce clk
>> > twl6040-codec twl6040-codec: ASoC: Failed to create Capture debugfs file
>> > omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
>> > omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).Power Management for TI OMAP4.
>> > mmc1: host does not support reading read-only switch. assuming write-enable.
>> 
>> Here's the latest set of error like messages, thanks to the kautobuild
>> system:
>> 
>> omap_hwmod: mcpdm: cannot be enabled for reset (3)
>> Error setting wl12xx data: -38
>
> That's now fixed up and I've queued it.
>
>> omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
>> omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
>> omap_hsmmc omap_hsmmc.4: Failed to get debounce clk
>> omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
>> omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).Power Management for TI OMAP4.
>> mmc1: host does not support reading read-only switch. assuming write-enable.
>> 
>> This looks much better compared to the previous set, but we could still
>> do with getting a "\n" on at least one of those messages...
>
> Kevin, do you have a patch for some of this?
>

I'll fix up the missing newline right away.

I was planning to leave the VC mismatch problem because it's fixed in
Tero's auto retention series.  However, I haven't been able to get to
that series yet due to all the regressions/bugfixes, so I'll at least
pull out the part that fixes up the mistmatch and submit it for v3.7.

Kevin

[1] http://marc.info/?l=linux-omap&m=134859084918176&w=2

