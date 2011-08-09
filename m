From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: How to handle named resources with DT?
Date: Tue, 9 Aug 2011 22:59:07 +0200
Message-ID: <4E419F9B.4030804@ti.com>
References: <4E40FC88.5090403@ti.com> <20110809195114.GB14281@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41414 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993Ab1HIU71 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Aug 2011 16:59:27 -0400
In-Reply-To: <20110809195114.GB14281@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 8/9/2011 9:51 PM, Russell King - ARM Linux wrote:
> On Tue, Aug 09, 2011 at 11:23:20AM +0200, Cousson, Benoit wrote:
>> Hi Grant,
>>
>> Trying to bind hwmod informations with DT, I'm facing a little limitation.
>> A bunch of drivers are using the platform_get_resource_byname, so the
>> name for the resource is needed.
>>
>> The name is used so far for IORESOURCE_MEM, IORESOURCE_IRQ and
>> IORESOURCE_DMA types of resources.
>>
>> Do you have any plan to add that, or do you have any clean way to avoid
>> that without having to use the resource index?
>
> Named resources are evil.  You only have to look at /proc/iomem to see
> why that's the case.  Here's an example:
>
> b7a01000-b7a01003 : set
>    b7a01000-b7a01003 : set

So what? That just shows that /proc/iomem outputs sucks, but that does 
not prove that named resources are evil.

[...]

> How very informative.  Not.  So what device owns those?  Who knows,
> that's lost by the crappy named resource stuff.

Maybe, but this is not lost by the platform_device, and this is what 
really matters in this case.
We need to get the resource local to a device, we do not care about the 
global view. This is exactly what the platform_get_resource_byname is doing.
For my point of view, the need for that is similar to the clkdev / 
clk_get(dev, name) you did. For sure, in that case, the real global 
clock name is still relevant, but the important point for the driver is 
the local device name.

Not providing the name of the resource will give you the device name, 
but how informative is that for the driver? What entry is the good one 
in the middle of that list?

b7a01040-b7a01043 : omap_foo
b7a01044-b7a01047 : omap_foo
b7a01048-b7a0104b : omap_foo
b7a01060-b7a01063 : omap_foo

Bottom-line, in both cases, /proc/iomem sucks... But who cares about the 
internal representation? A platform_driver can still take advantage of 
that, and this is exactly what we are looking for.

Benoit


