From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: omap_device: query on "fck" clk alias created
Date: Thu, 2 Aug 2012 14:09:09 +0100
Message-ID: <20120802130909.GN7405@n2100.arm.linux.org.uk>
References: <50191F00.1040501@ti.com> <50193263.8070907@ti.com> <79CD15C6BA57404B839C016229A409A83EA7DF32@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53411 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab2HBNJW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 09:09:22 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA7DF32@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 02, 2012 at 12:55:42PM +0000, Hiremath, Vaibhav wrote:
> On Wed, Aug 01, 2012 at 19:12:59, Cousson, Benoit wrote:
> > Mmm, I don't know, but even if this is right, shouldn't we avoid such
> > usage. It might be better to be explicit than assuming that the IP will
> > always have an unique clock.
> 
> Isn't this IP specific and driver must know how many clocks he has to 
> address? So I believe it will not be assumption, the driver is written
> considering clocksources and in some cases IP is designed and meant to
> receive only one clock input.

Devices themselves define what clocks they need to operate.  Drivers
designed to be used with the clk API are supposed to obtain all clocks
that the device requires.  The device dictates what clocks are required.

This does not change the way drivers deal with clocks depending on how
they're integrated into a SoC: devices that need five clocks should
_always_ call clk_get() five times to get each of those five clocks.

Where a clock is not individually distinguishable or available in a SoC,
the SoC level must arrange to return a dummy clock to the device driver.

If a device only takes one single clock, then using a connection ID of
NULL is acceptable.  Otherwise, an explicit name must be used, which is
chosen either from the device IPs documentation (eg, the name of the
_clock_ _input_) or with a lack of that information, a name chosen by
the driver writer according to the function of the clock.

You must stop thinking about the picture you get when something gets
integrated into a SoC... and making driver code conditional on the view
presented by the SoC.
