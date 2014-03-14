From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 4/4] ARM: DTS: AM43x: Add DSS node
Date: Fri, 14 Mar 2014 10:14:06 +0000
Message-ID: <20140314101405.GI25870@e106331-lin.cambridge.arm.com>
References: <1394701109-6721-1-git-send-email-sathyap@ti.com>
 <1394701109-6721-5-git-send-email-sathyap@ti.com>
 <20140313174623.GD25870@e106331-lin.cambridge.arm.com>
 <5321F77E.9000302@ti.com>
 <20140314091002.GG25870@e106331-lin.cambridge.arm.com>
 <5322CF02.4060705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:46488 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753150AbaCNKOR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Mar 2014 06:14:17 -0400
Content-Disposition: inline
In-Reply-To: <5322CF02.4060705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sathya Prakash M R <sathyap@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "paul@pwsan.com" <paul@pwsan.com>

On Fri, Mar 14, 2014 at 09:42:26AM +0000, Tomi Valkeinen wrote:
> On 14/03/14 11:10, Mark Rutland wrote:
> 
> > The "simple-bus" compatible string is intended for busses which are
> > transparent (bar some address remapping expressed via ranges), and is
> > not intended as an annotation to get Linux to probe child nodes.
> > 
> > Any node with a "simple-bus" entry in the compatible list should either
> > be handled as a transparent bus, or optionally as the more specific bus
> > it claims to be (where some hardware configuration may be required
> > before children can be probed). Unfortunately Linux probes chidlren
> > regardless, which is arguable a Linux bug.
> > 
> > There's no reason to leak this issue into dts files. Please remove the
> > "simple-bus" string, and get the dss driver to probe children as
> > required -- as described above the dss node never makes sense as a
> > simple-bus.
> 
> Ok. I'll remove the simple-bus, and make the dss_core register the
> devices. I presume of_platform_populate() is fine for this? Seems to
> work fine for registration, but I haven't figured out yet how to
> unregister the devices (I get a crash in platform_device_del() if I just
> call platform_device_unregister for the submodules).

I think of_platform_populate should be ok. It's not fantastic -- all
child nodes will be probed, regardless of whether you expect them to
exist, but it's not as broken as using "simple-bus".

I'm unfortunately not familiar with how unregistration works.

I can't see anything obviously wrong in platform_device_del. Do you have
a backtrace?

Thanks,
Mark.
