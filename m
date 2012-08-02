From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: omap_device: query on "fck" clk alias created
Date: Thu, 2 Aug 2012 13:04:37 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA7DF5C@DBDE01.ent.ti.com>
References: <50191F00.1040501@ti.com>
 <20120801141414.GM7405@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36230 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832Ab2HBNEx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 09:04:53 -0400
In-Reply-To: <20120801141414.GM7405@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Wed, Aug 01, 2012 at 19:44:14, Russell King - ARM Linux wrote:
> On Wed, Aug 01, 2012 at 05:50:16PM +0530, Vaibhav Hiremath wrote:
> > The clk_get() api will not work, unless we pass both the arguments (dev,
> > con_id) properly. Now expecting driver to always label con_id with "fck"
> > is undesirable, as the same driver can be reused on multiple platforms,
> > which can be non-omap and/or non-ti platforms.
> 
> Why not?
> 
> The connection ID is defined by the driver, and the platform stuff is
> expected to provide drivers with what they require.  It's not the other
> way around (platforms don't tell drivers what they require.)
> 
> In other words, if the device has two clocks, one called ick and one called
> fck, then the device _should_ use clk_get() specifying "ick" for one, and
> "fck" for the other.
> 
> And platforms better provide an "ick" and a "fck" for the device, even if
> they have no respresentation for one or other of them (in which case you
> supply a dummy clock.)
> 

Russell, I completely agree with you, infact I am on the same page.
Let me give you a real example, which I am dealing with now,

On AM335x device we have integrated DCAN, this IP is not from TI.
IP is from Bosch and doesn't follow any of the TI IP standards, like 
HighLander spec. The IP is just integrated with interconnect bus and given a 
required clocksource (in this case its one clock). 

The driver for this IP is generic, (drivers/net/can/c_can/c_can_platform.c) 
obviously used across non-ti devices already and driver is implemented with,
    clk_get(dev, NULL);


So in this context,

  1. Either I have to change the driver to specify con_id. Modifying a 
     generic driver.
OR
  2. Change the clock tree table to add an clock entry for this clock with 
     con_id = NULL, but I have to fix dev_id as well. I believe this I can 
     achieve using " of_dev_auxdata".
OR
  3. Create an alias at run time (omap is doing currently) with using 
     dynamic dev_id and con_id = NULL.


Thanks,
Vaibhav
