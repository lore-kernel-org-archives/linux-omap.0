From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: How to handle named resources with DT?
Date: Wed, 10 Aug 2011 11:29:58 +1000
Message-ID: <20110810012958.GB23511@yookeroo.fritz.box>
References: <4E40FC88.5090403@ti.com>
 <20110809162907.GA630@manju-WNB7PBC4801-0006>
 <4E4166F0.9050401@ti.com>
 <CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:48144 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393Ab1HJBqK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Aug 2011 21:46:10 -0400
Content-Disposition: inline
In-Reply-To: <CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Aug 09, 2011 at 11:23:45AM -0600, Grant Likely wrote:
> On Tue, Aug 9, 2011 at 10:57 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> > Hi Manju,
> >
> > On 8/9/2011 6:29 PM, G, Manjunath Kondaiah wrote:
> >>
> >> Hi Benoit,
> >>
> >> On Tue, Aug 09, 2011 at 11:23:20AM +0200, Cousson, Benoit wrote:
> >>>
> >>> Hi Grant,
> >>>
> >>> Trying to bind hwmod informations with DT, I'm facing a little
> >>> limitation.
> >>> A bunch of drivers are using the platform_get_resource_byname, so
> >>> the name for the resource is needed.
> >>>
> >>> The name is used so far for IORESOURCE_MEM, IORESOURCE_IRQ and
> >>> IORESOURCE_DMA types of resources.
> >>
> >> IORESOURCE_MEM and IORESOURCE_IRQ's are fetched from dt blob and
> >> it will be part of pdev.
> >
> > Yes, but without the proper name in the resource structure. It will be then
> > impossible to use the platform_get_resource_byname function that is
> > currently used by a bunch of drivers.
> 
> There is no analogous mechanism for _byname in the device tree.  The
> DT binding for a device must explicitly state what order the register
> ranges are in.  The driver will need to be adapted.

Well, the driver proper shouldn't need changing.  It should be
possible to assign the correct names in the glue which translates the
DT reg entries into the Linux resource structures.

The difficulty with adding th enames to the DT itself is that it
exposes the essentially Linux-specific names in what's supposed to be
an OS neutral data structure.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
