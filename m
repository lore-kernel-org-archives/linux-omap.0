From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: omap_device: query on "fck" clk alias created
Date: Thu, 2 Aug 2012 14:12:50 +0100
Message-ID: <20120802131250.GO7405@n2100.arm.linux.org.uk>
References: <50191F00.1040501@ti.com> <20120801141414.GM7405@n2100.arm.linux.org.uk> <79CD15C6BA57404B839C016229A409A83EA7DF5C@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53419 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab2HBNM7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 09:12:59 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA7DF5C@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Thu, Aug 02, 2012 at 01:04:37PM +0000, Hiremath, Vaibhav wrote:
> On Wed, Aug 01, 2012 at 19:44:14, Russell King - ARM Linux wrote:
> > On Wed, Aug 01, 2012 at 05:50:16PM +0530, Vaibhav Hiremath wrote:
> > > The clk_get() api will not work, unless we pass both the arguments (dev,
> > > con_id) properly. Now expecting driver to always label con_id with "fck"
> > > is undesirable, as the same driver can be reused on multiple platforms,
> > > which can be non-omap and/or non-ti platforms.
> > 
> > Why not?
> > 
> > The connection ID is defined by the driver, and the platform stuff is
> > expected to provide drivers with what they require.  It's not the other
> > way around (platforms don't tell drivers what they require.)
> > 
> > In other words, if the device has two clocks, one called ick and one called
> > fck, then the device _should_ use clk_get() specifying "ick" for one, and
> > "fck" for the other.
> > 
> > And platforms better provide an "ick" and a "fck" for the device, even if
> > they have no respresentation for one or other of them (in which case you
> > supply a dummy clock.)
> > 
> 
> Russell, I completely agree with you, infact I am on the same page.
> Let me give you a real example, which I am dealing with now,
> 
> On AM335x device we have integrated DCAN, this IP is not from TI.
> IP is from Bosch and doesn't follow any of the TI IP standards, like 
> HighLander spec. The IP is just integrated with interconnect bus and given a 
> required clocksource (in this case its one clock). 
> 
> The driver for this IP is generic, (drivers/net/can/c_can/c_can_platform.c) 
> obviously used across non-ti devices already and driver is implemented with,
>     clk_get(dev, NULL);

So, elsewhere it only has one clock.  Are there any other clocks it needs
on OMAP?

If the answer is no, then the driver is doing the right thing, and OMAP's
clk stuff needs to be adjusted to suit the drivers requirements.

I've said many times over the years that clock connection IDs are defined
by the device or driver and *nothing* else - they're certainly *not* source
names.

That's why, when I modified OMAP drivers to fix them, and they take an
interface and function clock, they end up asking for "ick" and "fck" not
"blah_ick" and "blah_fck".
