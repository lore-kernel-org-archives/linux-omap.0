From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 4/4] ARM: DTS: AM43x: Add DSS node
Date: Fri, 14 Mar 2014 18:00:53 +0000
Message-ID: <20140314180052.GO25870@e106331-lin.cambridge.arm.com>
References: <20140313174623.GD25870@e106331-lin.cambridge.arm.com>
 <5321F77E.9000302@ti.com>
 <20140314091002.GG25870@e106331-lin.cambridge.arm.com>
 <5322CF02.4060705@ti.com>
 <20140314101405.GI25870@e106331-lin.cambridge.arm.com>
 <5322D7A4.4090602@ti.com>
 <5322E2D9.5000509@ti.com>
 <20140314140745.GL25870@e106331-lin.cambridge.arm.com>
 <20140314160404.GC21379@saruman.home>
 <53232F8B.5020708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:60926 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754090AbaCNSBD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Mar 2014 14:01:03 -0400
Content-Disposition: inline
In-Reply-To: <53232F8B.5020708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "balbi@ti.com" <balbi@ti.com>, "av.tikhomirov@samsung.com" <av.tikhomirov@samsung.com>, Sathya Prakash M R <sathyap@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "paul@pwsan.com" <paul@pwsan.com>

On Fri, Mar 14, 2014 at 04:34:19PM +0000, Tomi Valkeinen wrote:
> On 14/03/14 18:04, Felipe Balbi wrote:
> > On Fri, Mar 14, 2014 at 02:07:45PM +0000, Mark Rutland wrote:
> >> On Fri, Mar 14, 2014 at 11:07:05AM +0000, Tomi Valkeinen wrote:
> >>> On 14/03/14 12:19, Tomi Valkeinen wrote:
> >>>> On 14/03/14 12:14, Mark Rutland wrote:
> >>>>
> >>>>> I can't see anything obviously wrong in platform_device_del. Do you have
> >>>>> a backtrace?
> >>>>
> >>>> Yes, below.
> >>>>
> >>>> I can see at least drivers/usb/dwc3/dwc3-exynos.c doing the exact same thing
> >>>> I do, so maybe I've got something wrong with the omapdss driver.
> >>>
> >>> Looks to me that the devices created by of_platform_populate() are not
> >>> unregisterable in all cases. The address resource created via
> >>> of_platform_populate() had NULL res->parent, which causes
> >>> release_resource to crash.
> >>
> >> Hmm. I can't see that unregistering such devices ever works as you say,
> >> given that __release_resource expects a non-NULL parent pointer. Either
> >> we should be setting the parent pointer when initialising devices from
> >> dt or we should teach __release_resource to not care. I'll have a go at
> >> fixing that.
> >>
> >> It looks like drivers/usb/dwc3/dwc3-exynos.c only unregisters the
> >> top-level device, not children. This top-level device has no
> >> IORESOURCE_{IO,MEM} resources judging by
> >> arch/arm/boot/dts/exynos5250.dtsi, which would explain why that driver
> >> isn't exploding: __release_resource will never get called.
> >>
> >> Anton, Felipe: 
> >>
> >> Does unregistering the parent ensure the children get cleaned up, or
> >> does it leave them dangling in the dwc3-exynos driver?
> > 
> > you should platform_device_unregister() for each children and
> > dwc3-exynos does that just fine:
> 
> Yes, that's what I do also, and it crashes. What Mark said above about
> unregistering never working for such devices is correct, but I don't
> know why he said dwc3-exynos only unregisters the top level device.

Because I'd failed to read the code correctly. It does indeed unregister
each of the children via platform_device_unregister.

Apologies for the confusion there.

> "such devices" above meaning devices with a 'reg' defined in the DT
> data, if I'm not mistaken.

Yes. As far as I can see, IORESOURCE_MEM resources instantiated from reg
entries in dt do not have their parent pointer initialised, and will
cause __release_resource to blow up. A quick inspection of resources on
my TC2 shows this to be the case -- the parent, sibling, and child
pointers are all NULL.

I'm at a loss to explain how the dwc3-exynos driver can call
platform_device_unregister on devices with such resource and not blow
up. Is anyone able to test dwc3_exynos_remove?

> So at the moment, I think of_platform_populate() and
> platform_device_unregister() combination in a driver is a bit risky.
> Work fine for certain cases, not for some other.

It certainly looks to be broken at the moment, but it should be fixable.

Thanks,
Mark.
