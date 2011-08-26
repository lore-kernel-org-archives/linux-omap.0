From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: How to handle named resources with DT?
Date: Fri, 26 Aug 2011 14:12:00 +1000
Message-ID: <20110826041200.GD2308@yookeroo.fritz.box>
References: <20110809205723.GE11568@ponder.secretlab.ca>
 <20110824231613.GC19890@legolas.emea.dhcp.ti.com>
 <20110825102824.GB10405@n2100.arm.linux.org.uk>
 <201108251705.43168.arnd@arndb.de>
 <877h6173wm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:50575 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab1HZEY1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 00:24:27 -0400
Content-Disposition: inline
In-Reply-To: <877h6173wm.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 25, 2011 at 11:16:25AM -0700, Kevin Hilman wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Thursday 25 August 2011, Russell King - ARM Linux wrote:
> >> On Thu, Aug 25, 2011 at 02:16:14AM +0300, Felipe Balbi wrote:
> >> > on top of all that, for IPs which are used on many SoCs (such as MUSB)
> >> > it's quite silly to force all users to provide resources in a certain
> >> > order. It sounds to me that this will be prone to error in many ways
> >> > until everything is synced up and on the correct order.
> >> > 
> >> > Ditching _byname is a very bad idea.
> >> 
> >> I continue to disagree.  The current _byname is an abonimation and hack
> >> to try to "fix" this problem.
> >> 
> >> _byname should have been implemented differently - rather than overriding
> >> the resources name field (which is normally specified to be the device
> >> or driver name), a new field should have been introduced in struct resource
> >> to carry the resource sub-name (which is really what it is.)
> >> 
> >> That would have avoided making /proc/iomem completely illegible with
> >> multiple devices using this feature.
> >
> > I agree 100%.
> 
> Please clarify. 
> 
> What I hear Russell saying is a problem with the *implementation* of the
> _byname API.  
> 
> What I hear you sating is that since DT doesn't support this, we need to
> remove it's usage completely from platform_devices also.
> 
> These are two very different approaches.
> 
> Fixing the implementation as Russell suggested seems relatively easy,
> and conceptually similar to adding it to the DT.  Removing _byname all
> together seems like significant work just to avoid adding a feature to
> the DT core.

Seriously, how many times do I have to say it?


Using _byname in drivers DOES NOT require adding names to the DT.


All it needs is some glue logic to attach names as the device tree is
read.  This is properly thought of as part of the code which
translates the device tree into struct platform_device, not as part of
drivers proper.

FURTHERMORE, even if there were names in the DT, you'd *still* need
this glue logic, so that drivers converted to _byname could still use
old device trees.

Insisting that the names come from the DT is to mistakenly think of
the DT as an extension of the kernel's internal interfaces, instead of
as the external and OS neutral data structure it actually is.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
