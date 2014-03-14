From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 4/4] ARM: DTS: AM43x: Add DSS node
Date: Fri, 14 Mar 2014 14:07:45 +0000
Message-ID: <20140314140745.GL25870@e106331-lin.cambridge.arm.com>
References: <1394701109-6721-1-git-send-email-sathyap@ti.com>
 <1394701109-6721-5-git-send-email-sathyap@ti.com>
 <20140313174623.GD25870@e106331-lin.cambridge.arm.com>
 <5321F77E.9000302@ti.com>
 <20140314091002.GG25870@e106331-lin.cambridge.arm.com>
 <5322CF02.4060705@ti.com>
 <20140314101405.GI25870@e106331-lin.cambridge.arm.com>
 <5322D7A4.4090602@ti.com>
 <5322E2D9.5000509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:53560 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754720AbaCNOH5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Mar 2014 10:07:57 -0400
Content-Disposition: inline
In-Reply-To: <5322E2D9.5000509@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, "balbi@ti.com" <balbi@ti.com>, "av.tikhomirov@samsung.com" <av.tikhomirov@samsung.com>
Cc: Sathya Prakash M R <sathyap@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "paul@pwsan.com" <paul@pwsan.com>

On Fri, Mar 14, 2014 at 11:07:05AM +0000, Tomi Valkeinen wrote:
> On 14/03/14 12:19, Tomi Valkeinen wrote:
> > On 14/03/14 12:14, Mark Rutland wrote:
> > 
> >> I can't see anything obviously wrong in platform_device_del. Do you have
> >> a backtrace?
> > 
> > Yes, below.
> > 
> > I can see at least drivers/usb/dwc3/dwc3-exynos.c doing the exact same thing
> > I do, so maybe I've got something wrong with the omapdss driver.
> 
> Looks to me that the devices created by of_platform_populate() are not
> unregisterable in all cases. The address resource created via
> of_platform_populate() had NULL res->parent, which causes
> release_resource to crash.

Hmm. I can't see that unregistering such devices ever works as you say,
given that __release_resource expects a non-NULL parent pointer. Either
we should be setting the parent pointer when initialising devices from
dt or we should teach __release_resource to not care. I'll have a go at
fixing that.

It looks like drivers/usb/dwc3/dwc3-exynos.c only unregisters the
top-level device, not children. This top-level device has no
IORESOURCE_{IO,MEM} resources judging by
arch/arm/boot/dts/exynos5250.dtsi, which would explain why that driver
isn't exploding: __release_resource will never get called.

Anton, Felipe: 

Does unregistering the parent ensure the children get cleaned up, or
does it leave them dangling in the dwc3-exynos driver?

Cheers,
Mark.
