From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: omap_device: query on "fck" clk alias created
Date: Wed, 1 Aug 2012 15:14:14 +0100
Message-ID: <20120801141414.GM7405@n2100.arm.linux.org.uk>
References: <50191F00.1040501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53009 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155Ab2HAOOZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 10:14:25 -0400
Content-Disposition: inline
In-Reply-To: <50191F00.1040501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Wed, Aug 01, 2012 at 05:50:16PM +0530, Vaibhav Hiremath wrote:
> The clk_get() api will not work, unless we pass both the arguments (dev,
> con_id) properly. Now expecting driver to always label con_id with "fck"
> is undesirable, as the same driver can be reused on multiple platforms,
> which can be non-omap and/or non-ti platforms.

Why not?

The connection ID is defined by the driver, and the platform stuff is
expected to provide drivers with what they require.  It's not the other
way around (platforms don't tell drivers what they require.)

In other words, if the device has two clocks, one called ick and one called
fck, then the device _should_ use clk_get() specifying "ick" for one, and
"fck" for the other.

And platforms better provide an "ick" and a "fck" for the device, even if
they have no respresentation for one or other of them (in which case you
supply a dummy clock.)
