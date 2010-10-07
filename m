From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC] tidspbridge: use a parameter to allocate shared memory
Date: Thu, 7 Oct 2010 16:01:02 +0200
Message-ID: <201010071601.04597.laurent.pinchart@ideasonboard.com>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com> <201010070940.14208.laurent.pinchart@ideasonboard.com> <20101007083242.GB14554@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.irobotique.be ([92.243.18.41]:59656 "EHLO
	perceval.irobotique.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab0JGOAx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 10:00:53 -0400
In-Reply-To: <20101007083242.GB14554@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Greg Kroah-Hartman <gregkh@suse.de>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ernesto Ramos <ernesto@ti.com>, linux-omap@vger.kernel.org, Ameya Palande <ameya.palande@nokia.com>

Hi Russell

On Thursday 07 October 2010 10:32:42 Russell King - ARM Linux wrote:
> On Thu, Oct 07, 2010 at 09:40:12AM +0200, Laurent Pinchart wrote:
> > Hi Omar,
> > 
> > On Thursday 07 October 2010 07:45:36 Omar Ramirez Luna wrote:
> > > tidspbridge driver uses a block of memory denominated SHared Memory
> > > to store info & communicate with DSP, this SHM needs to be physically
> > > contiguous and non-cacheable,
> > 
> > There are non-cacheable mappings, but there's no such thing as
> > non-cacheable memory. Does the MPU mapping for that SHM block really
> > needs to be non- cacheable, your could you instead flush the cache after
> > writing to it (performance issues might be involved, I don't know the
> > details about that SHM usage) ?
> 
> ARMv6 and above don't like having multiple mappings with different
> memory type/shareability/cache attributes.  It's architecturally
> forbidden.
> 
> So if you want non-cacheable memory and you want to be architecturally
> compliant, you have to exclude it from the kernel's direct-mapped
> memory mapping.

That's why Omar's patch uses 'mem=' to exclude system memory from the kernel 
mappings. That's not ideal though, as that memory will be wasted forever, 
hence my comments regarding whether a non-cacheable mapping was really 
required.

Do we have an infrastructure, or even an embryo thereof, to remove pages from 
the kernel's direct-mapped memory mapping at runtime ? The use of super pages 
probably complicates the matter.

-- 
Regards,

Laurent Pinchart
