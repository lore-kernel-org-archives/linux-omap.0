From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Mon, 4 Mar 2013 11:51:38 -0600
Message-ID: <5134DF2A.4050209@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com> <1361899842-30303-12-git-send-email-jon-hunter@ti.com> <CALF0-+V3A-fL7q2nPRmcgnFKmzRt8KwSLuzrwzyyce6MqHjVpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49783 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758585Ab3CDRvs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Mar 2013 12:51:48 -0500
In-Reply-To: <CALF0-+V3A-fL7q2nPRmcgnFKmzRt8KwSLuzrwzyyce6MqHjVpw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <elezegarcia@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>


On 03/04/2013 05:57 AM, Ezequiel Garcia wrote:
> Hi Jon,
> 
> On Tue, Feb 26, 2013 at 2:30 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>> +
>> +Example:
>> +
>> +gpmc: gpmc@6e000000 {
>> +       compatible = "ti,omap3430-gpmc", "simple-bus";
> 
> I'm concern about using simple-bus, and I'm not entirely sure this will work.
> 
> AFAIK, you can't correlate a parent-child relationship in the device tree
> to the order in which drivers will be probed,
> so it's only a matter of coincidence if this is working for you right now.

Ummm, I am not sure I am convinced. Have you looked at
of_platform_bus_create() which creates the devices? It is clearly
creating the child devices after creating the parent device.

> The GPMC code is in "arch/arm/mach-omap2", is located *before* the mtd code
> in the Makefile, and thus the GPMC driver loads *before* the MTD code.

But shouldn't it only matter in the order in which devices are
registered? Unless you have a situation in which the devices are
registered in order (parent then child) but only the driver for the
child is registered before the parent and child devices are registered.
I could see that being a problem.

The only other thing that I can think of is if you happen to be creating
a device both via device-tree and may be you are creating a duplicate
device and calling platform_device_register() somewhere else in your code.

> Morevore, I believe that when we move GPMC from arch/arm/mach-omap2
> to drivers/memory where it should be, this 'simple-bus' will stop
> working properly.

Why? I don't see how the location of files would change this.

> Of course, I can be wrong, but I think you will have to find some other way
> to initialize the GPMC's childs.

Well isn't this how device-tree is meant to work?

It would be great if you could debug your problem and fully understand
why this is not working for you, so we can see if there is a real
problem here. Otherwise this appears to be just guess work.

Jon

