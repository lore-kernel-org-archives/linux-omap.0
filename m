From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] driver-core: platform: Resolve DT interrupt references late
Date: Wed, 08 Jan 2014 22:01:46 +0100
Message-ID: <5253830.a53UI1vY1X@wuerfel>
References: <20140108011957.GK5074@atomide.com> <14122609.M29raBct1E@wuerfel> <20140108202407.GA28442@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62021 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757026AbaAHVBy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jan 2014 16:01:54 -0500
In-Reply-To: <20140108202407.GA28442@ulmo.nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org

On Wednesday 08 January 2014 21:24:08 Thierry Reding wrote:
> 
> The problem with devres, or any other solution for that matter, is that
> for the cases where we'd need something like this (that is, statically
> allocated devices in board setup code) we don't have a fully initialized
> struct device. We need at least device_initialize() to have been called
> before devres can be used. Therefore we still need some sort of lookup
> table that can be used to seed devres objects. Also devres will go away
> completely when a driver is unloaded, so it'll have to be repopulated
> everytime.
> 
> I don't think that would buy us much over a simple table lookup.

I would think we can come up with a way to add data to a device that
ends up in devres by the time the device gets registered. The question
is more whether you want a global table (or a set of global tables
for that matter) or rather have all the data local to the devices
you register. I generally prefer the latter.

There is an interesting question about what subsystems you'd want to
include in this mechanism. We have a growing number of subsystems
that want data represented in DT (clock, regulator, dmaengine, reset,
led, pwm, irq, iommu, ...), most of which don't have a 'struct resource'
equivalent. We could either try to create something generic enough
to easily cover all of them, or we declare that if you actually want
to use all of them you should really use DT, and we make it hard to
add another subsystem specific lookup mechanism.

	Arnd
